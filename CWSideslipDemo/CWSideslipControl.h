//
//  CWSideslipControl.h
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/9.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWSideslipControl : NSObject


+ (instancetype)shareInstance;

/**
 *  添加侧滑的视图到tabbarController中去
 *
 *  @param sideView         侧滑的视图
 *  @param tabbarController 控制器
 */
- (void)addSideView:(UIView *)sideView   toViewController:(UIViewController *)viewController;

/**
 *  回收侧滑菜单
 *
 *  @param animation 是否需要动画
 */
- (void)moveToMinWithAnimation:(BOOL)animation;

/**
 *  弹开侧滑菜单
 *
 *  @param animation 是否需要动画
 */
- (void)moveToMaxWithAnimation:(BOOL)animation;

/**
 *  是否可以移动弹出侧滑菜单,默认为YES
 */
@property (assign, nonatomic) BOOL canMove;
@end
