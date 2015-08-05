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
    titleAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [bar setTitleTextAttributes:titleAttrs];
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
        
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(back) image:@"navigationbar_back" highlightImage:@"navigationbar_back_highlighted"];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(more) image:@"navigationbar_more" highlightImage:@"navigationbar_more_highlighted"];
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
