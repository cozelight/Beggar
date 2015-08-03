//
//  NSDate+Extension.m
//  WB-01
//
//  Created by Madao on 15/7/18.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *createStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    NSDate *createDate = [fmt dateFromString:createStr];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *creatStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [nowStr isEqualToString:creatStr];
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *cmps = [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    return !cmps.year;
}

@end
