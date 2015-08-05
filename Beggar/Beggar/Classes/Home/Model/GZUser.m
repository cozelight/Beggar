//
//  GZUser.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZUser.h"
#import "MJExtension.h"

@implementation GZUser

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"userID" : @"id",
             @"selfDescription" : @"description",
             @"isProtected" : @"protected"
             };
}

@end
