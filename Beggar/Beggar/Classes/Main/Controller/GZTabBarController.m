//
//  GZTabBarController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZTabBarController.h"
#import "GZNavigationController.h"
#import "GZHomeViewController.h"
#import "GZMessageViewController.h"
#import "GZDiscoverViewController.h"
#import "GZProfileViewController.h"

@interface GZTabBarController ()

@end

@implementation GZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化子控制器
    GZHomeViewController *home = [[GZHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"home_tab_icon_1" selectedImage:@"home_tab_icon_1_selected"];
    
    GZMessageViewController *message = [[GZMessageViewController alloc] init];
    [self addChildVc:message title:@"消息" image:@"home_tab_icon_2" selectedImage:@"home_tab_icon_2_selected"];
    
    GZDiscoverViewController *discover = [[GZDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"探索" image:@"home_tab_icon_3" selectedImage:@"home_tab_icon_3_selected"];
    
    GZProfileViewController *profile = [[GZProfileViewController alloc] init];
    [self addChildVc:profile title:@"个人" image:@"home_tab_icon_4" selectedImage:@"home_tab_icon_4_selected"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = GZColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = GZColor(20, 97, 237);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    GZNavigationController *nav = [[GZNavigationController alloc] initWithRootViewController:childVc];
    
    // 添加为子控制器
    [self addChildViewController:nav];
}

@end
