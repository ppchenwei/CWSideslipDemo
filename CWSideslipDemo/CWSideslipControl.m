//
//  CWSideslipControl.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/9.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "CWSideslipControl.h"

#define BACKBUTTONTAG              2006
#define GESTURERECOGNIZERSPACE     30

@implementation UIView (Frame)

- (void)setX:(CGFloat )originX
{
    CGRect rect = self.frame;
    
    rect.origin.x = originX;
    
    self.frame = rect;
}
@end


@interface CWSideslipControl()
{
     BOOL _bMove;
}

@property (strong, nonatomic)UIView *slipView;

@property (strong, nonatomic)UIViewController *viewController;

@end

@implementation CWSideslipControl
@synthesize slipView = __slipView;

+ (instancetype)shareInstance
{
    static CWSideslipControl *sideslipControl;
    @synchronized (self)
    {
        if (!sideslipControl)
        {
            sideslipControl = [[CWSideslipControl alloc] init];
        }
    }
    return sideslipControl;
}

- (void)addSideView:(UIView *)sideView   toViewController:(UIViewController *)viewController
{
    if (sideView && viewController)
    {
        self.slipView = sideView;
        
        self.viewController = viewController;
        //添加手势监控
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfPanGestureRecognizer:)];
        [self.viewController.view addGestureRecognizer:panGestureRecognizer];
    }
}

- (void)handleOfPanGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint pointView = [gestureRecognizer locationInView:self.viewController.view];
    CGPoint pointWindow = [gestureRecognizer locationInView:self.viewController.view.window];
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    if (state == UIGestureRecognizerStateBegan)
    {
        if (pointView.x > GESTURERECOGNIZERSPACE) _bMove = NO;
        else _bMove = YES;
    }
    else if (state == UIGestureRecognizerStateChanged)
    {
        if ( !_bMove) return;
        
        if (pointWindow.x <= self.slipView.frame.size.width )
        {
            [self moveToPointX:pointWindow.x];
        }
        else
        {
            [self moveToMaxWithAnimation:NO];
        }
    }
    else
    {
        if ( !_bMove) return;
        
        if (self.viewController.view.frame.origin.x > self.slipView.frame.size.width / 2)
        {
            [self moveToMaxWithAnimation:YES];
        }
        else
        {
            [self moveToMinWithAnimation:YES];
        }
    }
}

- (void)moveToMinWithAnimation:(BOOL)animation
{
    if (self.viewController.view.frame.origin.x == 0) return;
    
    if ([self.viewController.view viewWithTag:BACKBUTTONTAG])
    {
        [[self.viewController.view viewWithTag:BACKBUTTONTAG] removeFromSuperview];
    }
    
    [UIView animateWithDuration:animation?0.2:0.0 animations:^{
        [self.viewController.view setX:0];
        [self.slipView setX:-self.slipView.frame.size.width];
    }];
}

- (void)moveToPointX:(CGFloat)pointX
{
    [self.viewController.view setX:pointX];
    [self.slipView setX:pointX - self.slipView.frame.size.width];
}

- (void)moveToMaxWithAnimation:(BOOL)animation
{
    if (self.slipView.frame.origin.x == 0) return;
    
    if (![self.viewController.view viewWithTag:BACKBUTTONTAG])
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:self.viewController.view.bounds];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(onBackButton:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = BACKBUTTONTAG;
        [self.viewController.view addSubview:backButton];
    }
    
    
    [UIView animateWithDuration:animation?0.2:0.0 animations:^{
        [self.viewController.view setX:self.slipView.frame.size.width];
        [self.slipView setX:0];
    }];
}

- (void)onBackButton:(id)sender
{
    UIButton *backButton = (UIButton *)sender;
    [backButton removeFromSuperview];
    [self moveToMinWithAnimation:YES];
}


- (UIView *)slipView
{
    if (![__slipView.superview isKindOfClass:[UIWindow class]])
    {
        [self.viewController.view.window addSubview:__slipView];
    }
    return __slipView;
}

- (void)setSlipView:(UIView *)slipView
{
    CGRect frame = slipView.frame;
    __slipView = slipView;
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    
    if (frame.size.width > screenFrame.size.width)  frame.size.width = screenFrame.size.width - GESTURERECOGNIZERSPACE;
    if (frame.size.height > screenFrame.size.height)  frame.size.height = screenFrame.size.height;
    
    __slipView.frame = CGRectMake(-frame.size.width, (screenFrame.size.height - frame.size.height) / 2, frame.size.width, frame.size.height);
}
@end
