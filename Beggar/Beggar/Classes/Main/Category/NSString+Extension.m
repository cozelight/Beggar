//
//  NSString+Extension.m
//  15-QQ
//
//  Created by Madao on 15/6/9.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 *  计算文本框尺寸
 *
 *  @param maxSize 文本框最大尺寸
 *  @param font    文本字体
 *
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
 
    NSDictionary *attrs = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes: attrs context:nil].size;
    
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

@end
