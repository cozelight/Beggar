//
//  GZStatusTool.m
//  Beggar
//
//  Created by Madao on 15/8/7.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZStatusTool.h"
#import "FMDB.h"
#import "GZStatus.h"
#import "GZUser.h"
#import "MJExtension.h"


@implementation GZStatusTool

static FMDatabase *_db;

+ (void)openDataBase
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
}

+ (void)initialize
{
    // 1.打开数据库
    [GZStatusTool openDataBase];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, rawid text NOT NULL, content text NOT NULL, user_name text NOT NULL);"];
}

+ (NSArray *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE rawid > %@ ORDER BY rawid DESC LIMIT 20;", params[@"rawid"]];
    } else if (params[@"max_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE rawid <= %@ ORDER BY rawid DESC LIMIT 20;", params[@"rawid"]];
    } else {
        sql = @"SELECT * FROM t_status ORDER BY rawid DESC LIMIT 20;";
    }
    
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    return statuses;
}

+ (NSArray *)searchStatusesWithText:(NSString *)text
{
    [_db close];
    _db = nil;
    [GZStatusTool openDataBase];

    if (!text) return nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT status FROM t_status WHERE content LIKE '%%%@%%' OR user_name LIKE '%%%@%%' ORDER BY rawid DESC",text,text];
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    return statuses;
}

+ (void)saveStatuses:(NSArray *)statuses
{
    if (!statuses.count) return;
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    for (NSDictionary *status in statuses) {
        
        // 字典转行模型
        GZStatus *newStatus = [GZStatus objectWithKeyValues:status];
        
        // NSDictionary --> NSData
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO t_status(status, rawid, content, user_name) VALUES (%@, %@, %@, %@);", statusData, @(newStatus.rawid), newStatus.text, newStatus.user.name];
    }
}

@end
