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
#import "GZAccountTool.h"
#import "NSString+Extension.h"

static GZStatusTool *defaultInstance = nil;

NSString *const shareDbLock = @"shareDbLock";

@implementation GZStatusTool {
    FMDatabase *_db;
    NSString *_tableName;
}

+ (GZStatusTool *)sharedInstance {
    @synchronized(shareDbLock) {
        if (defaultInstance == nil) {
            defaultInstance = [[GZStatusTool alloc] init];
        }
        return defaultInstance;
    }
}

+ (void)releaseInstance {
    @synchronized(shareDbLock) {
        if (defaultInstance != nil) {
            [defaultInstance closeDBConnection];
            defaultInstance = nil;
        }
    }
}

- (void)closeDBConnection
{
    if (_db) {
        [_db close];
    }
    _db = nil;
    _tableName = nil;
}

- (instancetype)init {
    
    if ((self = [super init])) {
        
        // 1.打开数据库
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
        _db = [FMDatabase databaseWithPath:path];
        [_db open];
        
        GZAccount *account = [GZAccountTool account];
        _tableName = [NSString stringWithFormat:@"%@_t_status",account.secret.md5];
        
        // 2.创表
        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY, status blob NOT NULL, rawid integer NOT NULL, content text NOT NULL, user_name text NOT NULL);",_tableName];
        [_db executeUpdate:sql];
        
    }
    return self;
}

- (NSArray *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"since_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE rawid > %@ ORDER BY rawid DESC LIMIT 20;",_tableName, params[@"rawid"]];
    } else if (params[@"max_id"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE rawid <= %@ ORDER BY rawid DESC LIMIT 20;",_tableName, params[@"rawid"]];
    } else {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY rawid DESC LIMIT 20;", _tableName];
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

- (NSArray *)searchStatusesWithText:(NSString *)text
{
    if (!text) return nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE content LIKE '%%%@%%' OR user_name LIKE '%%%@%%' ORDER BY rawid DESC;",_tableName,text,text];
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    return statuses;
}

- (void)saveStatuses:(NSArray *)statuses
{
    if (!statuses.count) return;
    
    @synchronized(shareDbLock) {
        
        [_db beginTransaction];
        BOOL success = YES;
        
        // 要将一个对象存进数据库的blob字段,最好先转为NSData
        // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
        for (NSDictionary *status in statuses) {
            
            NSDictionary *user = status[@"user"];
            
            // NSDictionary --> NSData
            NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
            
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(status, rawid, content, user_name) VALUES (?, ?, ?, ?);", _tableName];
            success &= [_db executeUpdate:sql, statusData, status[@"rawid"], status[@"text"], user[@"name"]];
            
            if (NO == success
                &&
                SQLITE_CONSTRAINT == [_db lastErrorCode]) {
                success = YES;
            }
        }
        
        if (success) {
            [_db commit];
        } else {
            [_db rollback];
        }
    }
}

@end
