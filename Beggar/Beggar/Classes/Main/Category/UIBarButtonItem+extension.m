//
//  UIBarButtonItem+extension.m
//  WB-01
//
//  Created by Madao on 15/7/10.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import "UIBarButtonItem+extension.h"

@implementation UIBarButtonItem (extension)

+ (UIBarButtonItem *)itemAddTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)hightlightImage
{
    // 1.创建button
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 2.设置button图片
    [Btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:hightlightImage] forState:UIControlStateHighlighted];
    Btn.size = Btn.currentBackgroundImage.size;
    
    // 3.创建buttonItem
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
}

@end
