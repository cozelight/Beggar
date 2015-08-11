//
//  UIView+extension.h
//  WB-01
//
//  Created by Madao on 15/7/10.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extension)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;


/**
 *  获取当前屏幕显示的viewcontroller
 */
- (UIViewController *)getCurrentVC;

@end
