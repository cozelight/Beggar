//
//  AppDelegate.m
//  Beggar
//
//  Created by Madao on 15/7/24.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "AppDelegate.h"
#import "GZTabBarController.h"
#import "GZLoginViewController.h"
#import "GZNavigationController.h"
#import "GZAccountTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建window
    
    self.window = [[UIWindow alloc] initWithFrame:GZScreenF];
    
    [self.window makeKeyAndVisible];
    
    // 2.设置根控制器
    GZAccount *account = [GZAccountTool account];
    if (account) {
        self.window.rootViewController = [[GZTabBarController alloc] init];
    } else {
        GZLoginViewController *loginVC = [[GZLoginViewController alloc] init];
        self.window.rootViewController = [[GZNavigationController alloc] initWithRootViewController:loginVC];
    }
    
    // 设置状态栏属性
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
