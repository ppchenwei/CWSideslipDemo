//
//  TabBarController.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/6.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "TabBarController.h"

#define BACKBUTTONTAG              2006

@implementation UIView (Frame)

- (void)setX:(CGFloat )originX
{
    CGRect rect = self.frame;
    
    rect.origin.x = originX;
    
    self.frame = rect;
}
@end

@interface TabBarController ()
{
    BOOL _bMove;
}

@property (strong,nonatomic) UIView *sideView;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfPanGestureRecognizer:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleOfPanGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint pointView = [gestureRecognizer locationInView:self.view];
    CGPoint pointWindow = [gestureRecognizer locationInView:self.view.window];
    UIGestureRecognizerState state = gestureRecognizer.state;
    
    if (state == UIGestureRecognizerStateBegan)
    {
        if (pointView.x > 30) _bMove = NO;
        else _bMove = YES;
    }
    else if (state == UIGestureRecognizerStateChanged)
    {
        if ( !_bMove) return;
        
        if (pointWindow.x <= self.sideView.frame.size.width )
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
        
        if (self.view.frame.origin.x > self.sideView.frame.size.width / 2)
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
    if (self.view.frame.origin.x == 0) return;
    
    if ([self.view viewWithTag:BACKBUTTONTAG])
    {
        [[self.view viewWithTag:BACKBUTTONTAG] removeFromSuperview];
    }
    
    [UIView animateWithDuration:animation?0.2:0.0 animations:^{
        [self.view setX:0];
        [self.sideView setX:-self.sideView.frame.size.width];
    }];
}

- (void)moveToPointX:(CGFloat)pointX
{
    [self.view setX:pointX];
    [self.sideView setX:pointX - self.sideView.frame.size.width];
}

- (void)moveToMaxWithAnimation:(BOOL)animation
{
    if (self.sideView.frame.origin.x == 0) return;
    
    if (![self.view viewWithTag:BACKBUTTONTAG])
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:self.view.bounds];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(onBackButton:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = BACKBUTTONTAG;
        [self.view addSubview:backButton];
    }
    
    
    [UIView animateWithDuration:animation?0.2:0.0 animations:^{
        [self.view setX:self.sideView.frame.size.width];
        [self.sideView setX:0];
    }];
}

- (UIView *)sideView
{
    if (!_sideView)
    {
        CGRect screenRect = [UIScreen mainScreen].bounds;
        _sideView = [[UIView alloc] initWithFrame:CGRectMake(-screenRect.size.width * 4 / 5, 0, screenRect.size.width * 4 / 5, screenRect.size.height)];
        _sideView.backgroundColor = [UIColor redColor];
         [self.view.window addSubview:self.sideView];
    }
    return _sideView;
}

- (void)onBackButton:(id)sender
{
    UIButton *backButton = (UIButton *)sender;
    [backButton removeFromSuperview];
    [self moveToMinWithAnimation:YES];
}
@end
