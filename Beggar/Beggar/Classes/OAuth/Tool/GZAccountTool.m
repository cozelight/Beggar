//
//  GZAccountTool.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZAccountTool.h"

#define GZAccountPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation GZAccountTool

+ (void)saveAccount:(GZAccount *)account
{
    // 将返回的账号字典数据 --> 模型, 存进沙盒
    [NSKeyedArchiver archiveRootObject:account toFile:GZAccountPath];
}

+ (GZAccount *)account
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:GZAccountPath];
}

@end
