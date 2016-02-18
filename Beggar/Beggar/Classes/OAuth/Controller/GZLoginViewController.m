//
//  GZLoginViewController.m
//  Beggar
//
//  Created by Madao on 16/2/18.
//  Copyright © 2016年 GanZhen. All rights reserved.
//

#import "GZLoginViewController.h"
#import "GZOAuthViewController.h"

@interface GZLoginViewController ()

@end

@implementation GZLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
}
- (IBAction)loginBtnDidClick:(id)sender {
    
    GZOAuthViewController *oauthVC = [[GZOAuthViewController alloc] init];
    [self.navigationController pushViewController:oauthVC animated:YES];
}


@end
