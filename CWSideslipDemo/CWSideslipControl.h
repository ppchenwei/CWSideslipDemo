//
//  CWSideslipControl.h
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/9.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWSideslipControl : NSObject

/**
 *  提供一个全局的实例
 */
+ (instancetype)shareInstance;

/**
 *  添加侧滑的视图
 *
 *  @param sideView         侧滑的视图
 *  @param viewController   控制器
 */
- (void)addSideView:(UIView *)sideView   toViewController:(UIViewController *)viewController;

/**
 *  隐藏侧滑视图
 *
 *  @param animation 是否需要动画
 */
- (void)moveToMinWithAnimation:(BOOL)animation;

/**
 *  弹出侧滑视图
 *
 *  @param animation 是否需要动画
 */
- (void)moveToMaxWithAnimation:(BOOL)animation;



@end
