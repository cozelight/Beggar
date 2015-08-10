//
//  GZMessageTool.h
//  Beggar
//
//  Created by Madao on 15/8/10.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZMessageTool : NSObject

/**
 *  根据请求参数去沙盒中加载缓存的微博数据
 *
 *  @param params 请求参数
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;

/**
 *  存储微博数据到沙盒中
 *
 *  @param statuses 需要存储的微博数据
 */
+ (void)saveStatuses:(NSArray *)statuses;

/**
 *  查询数据库中包含text关键字的内容
 *
 *  @param text 关键字
 *
 *  @return 返回stauses数据
 */
+ (NSArray *)searchStatusesWithText:(NSString *)text;

@end
