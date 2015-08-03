//
//  GZMessageViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZMessageViewController.h"

@implementation GZMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = GZRandomColor;
    
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.x = self.view.centerX;
    switchView.y = self.view.centerY;
    [self.view addSubview:switchView];
    
}

@end
