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

@end
