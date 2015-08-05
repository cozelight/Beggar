//
//  GZStatus.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZStatus.h"
#import "GZUser.h"
#import "GZPhoto.h"
#import "MJExtension.h"

@implementation GZStatus

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"msgID" : @"id"};
}

@end
