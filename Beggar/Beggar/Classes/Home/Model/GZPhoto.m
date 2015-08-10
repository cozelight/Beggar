//
//  GZPhoto.m
//  Beggar
//
//  Created by Madao on 15/8/5.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZPhoto.h"

@implementation GZPhoto

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"imageurl" : @"imageurl",
             @"thumburl" : @"thumburl",
             @"largeurl" : @"largeurl"
             };
}
@end
