//
//  UIBarButtonItem+extension.h
//  WB-01
//
//  Created by Madao on 15/7/10.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (extension)

+ (UIBarButtonItem *)itemAddTarget:(id)target action:(SEL)action image:(NSString *)image highlightImage:(NSString *)hightlightImage;

@end
