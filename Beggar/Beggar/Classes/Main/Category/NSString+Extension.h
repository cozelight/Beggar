//
//  NSString+Extension.h
//  15-QQ
//
//  Created by Madao on 15/6/9.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  计算当前文件/文件夹的内容大小
 *
 */
- (NSInteger)fileSize;

@end
