//
//  FirstViewController.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/6.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "FirstViewController.h"
#import "CWSideslipControl.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *slipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
    slipView.backgroundColor = [UIColor redColor];
    
    [[CWSideslipControl shareInstance] addSideView:slipView toViewController:self.tabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
