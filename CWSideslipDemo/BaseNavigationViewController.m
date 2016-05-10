//
//  BaseNavigationViewController.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/9.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "CWSideslipControl.h"
#import "CWSideViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CWSideViewController *vc = [[CWSideViewController alloc] init];
    
    [[CWSideslipControl shareInstance] addSideView:vc.view toViewController:self];
    
    
    self.navigationItem.title = @"first";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"弹开侧滑菜单" style:UIBarButtonItemStyleDone target:self action:@selector(onLeftBarButtonItem:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLeftBarButtonItem:(id)sender
{
    [[CWSideslipControl shareInstance] moveToMaxWithAnimation:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
