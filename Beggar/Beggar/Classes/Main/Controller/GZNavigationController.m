//
//  GZNavigationController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZNavigationController.h"
#import "GZNavigationBar.h"

@interface GZNavigationController ()

@end

@implementation GZNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
    UIImage *image = [UIImage imageNamed:@"timeline_nav_bg"];
//    [bar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [bar setBarTintColor:[UIColor colorWithPatternImage:image]];
    
    NSMutableDictionary *titleAttrs = [NSMutableDictionary dictionary];
    titleAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    titleAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:titleAttrs];
    
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *btnItem = [UIBarButtonItem appearance];
    
    // 设置普通状态
    NSMutableDictionary *btnAttrs = [NSMutableDictionary dictionary];
    btnAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    btnAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [btnItem setTitleTextAttributes:btnAttrs forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    disableTextAttrs[NSFontAttributeName] = btnAttrs[NSFontAttributeName];
    [btnItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 替换自定义导航栏
    [self setValue:[[GZNavigationBar alloc] init] forKeyPath:@"navigationBar"];
}

/**
 *  重写这个方法目的:能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 自动显示和隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(back) image:@"button_back" highlightImage:nil];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(more) image:@"button_icon_group" highlightImage:nil];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
