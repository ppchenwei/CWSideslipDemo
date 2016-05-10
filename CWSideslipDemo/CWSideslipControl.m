//
//  CWSideslipControl.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/9.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "CWSideslipControl.h"

#define BACKBUTTONTAG              2006

#define GESTURERECOGNIZERSPACE     68

static CWSideslipControl *sideslipControl;

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

@property (strong, nonatomic)UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation CWSideslipControl
@synthesize slipView = __slipView;

#pragma mark -------单例模式------------
+ (instancetype)shareInstance
{
    return [[self alloc] init];
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    
    @synchronized (self)
    {
        if (!sideslipControl)
        {
            sideslipControl = [super allocWithZone: zone];
        }
    }
    
    return sideslipControl;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return sideslipControl;
}

- (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return sideslipControl;
}
#pragma mark ------初始化视图和控制器----------
- (void)addSideView:(UIView *)sideView   toViewController:(UIViewController *)viewController
{
    if (sideView && viewController)
    {
        //初始化属性
        [self initProperrtys];
        
        self.slipView = sideView;
        self.viewController = viewController;
        //添加手势监控
        [self.viewController.view addGestureRecognizer:self.panGestureRecognizer];
        
        //添加边缘阴影
        self.viewController.view.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        self.viewController.view.layer.shadowRadius = 2.0;  //设置阴影的半径
        self.viewController.view.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        self.viewController.view.layer.shadowOpacity = 0.5; //设置阴影的不透明度
        
    }
}

- (void)initProperrtys
{
    [self.slipView removeFromSuperview];
    self.slipView = nil;
    [self.viewController.view removeGestureRecognizer:self.panGestureRecognizer];
    self.viewController = nil;
    
    self.canMove = YES;
}
#pragma mark ----------手势处理响应---------
- (void)handleOfPanGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (!self.canMove) return;
    
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

#pragma mark ---------视图位移处理--------------
- (void)moveToMinWithAnimation:(BOOL)animation
{
    if (self.viewController.view.frame.origin.x == 0) return;
    
    if ([self.viewController.view viewWithTag:BACKBUTTONTAG])
    {
        [[self.viewController.view viewWithTag:BACKBUTTONTAG] removeFromSuperview];
    }
    
    [UIView animateWithDuration:animation?0.2:0.0 animations:^{
        [self.viewController.view setX:0];
        [self.slipView setX:-self.slipView.frame.size.width / 2];
    }];
}

- (void)moveToPointX:(CGFloat)pointX
{
    [self.viewController.view setX:pointX];
    [self.slipView setX:pointX / 2 - self.slipView.frame.size.width / 2];
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

#pragma mark -------属性自定义set get方法----------
- (UIView *)slipView
{
    if (__slipView && ![__slipView.superview isKindOfClass:[UIWindow class]])
    {
        [self.viewController.view.window insertSubview:__slipView atIndex:0];
    }
    return __slipView;
}

- (void)setSlipView:(UIView *)slipView
{
    CGRect frame = slipView.frame;
    __slipView = slipView;
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    
    if (frame.size.width >= screenFrame.size.width)  frame.size.width = screenFrame.size.width - GESTURERECOGNIZERSPACE;
    if (frame.size.height > screenFrame.size.height)  frame.size.height = screenFrame.size.height;
    
    __slipView.frame = CGRectMake(-frame.size.width / 2, (screenFrame.size.height - frame.size.height) / 2, frame.size.width, frame.size.height);
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if (!_panGestureRecognizer)
    {
         _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfPanGestureRecognizer:)];
    }
    return _panGestureRecognizer;
}
@end
