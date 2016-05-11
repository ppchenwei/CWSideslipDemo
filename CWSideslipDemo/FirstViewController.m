//
//  FirstViewController.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/6.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "FirstViewController.h"
#import "CWSideslipControl.h"
#import "CWSideViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CWSideViewController *vc = [[CWSideViewController alloc] init];
    
    [[CWSideslipControl shareInstance] addSideView:vc.view toViewController:self.tabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[CWSideslipControl shareInstance] setSideslipEnable:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[CWSideslipControl shareInstance] setSideslipEnable:NO];
}

@end
