//
//  GZUser.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZUser.h"

@implementation GZUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"userID" : @"id",
             @"name" : @"name",
             @"screen_name" : @"screen_name",
             @"location" : @"location",
             @"gender" : @"gender",
             @"birthday" : @"birthday",
             @"selfDescription" : @"description",
             @"profile_image_url" : @"profile_image_url",
             @"profile_image_url_large" : @"profile_image_url_large",
             @"url" : @"url",
             @"isProtected" : @"protected",
             @"followers_count" : @"followers_count",
             @"friends_count" : @"friends_count",
             @"favourites_count" : @"favourites_count",
             @"statuses_count" : @"statuses_count",
             @"following" : @"following",
             @"notifications" : @"notifications",
             @"created_at" : @"created_at"
             };
}

@end
