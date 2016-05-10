//
//  PushViewController.m
//  CWSideslipDemo
//
//  Created by 陈威 on 16/5/10.
//  Copyright © 2016年 陈威. All rights reserved.
//

#import "PushViewController.h"
#import "CWSideslipControl.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Push";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(onLeftBarButtonItem:)];
   // [[CWSideslipControl shareInstance] setCanMove:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onLeftBarButtonItem:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
