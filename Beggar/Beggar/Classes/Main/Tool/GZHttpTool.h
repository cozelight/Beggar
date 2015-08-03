//
//  GZHttpTool.h
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpRequestSuccess)(id json);
typedef void (^HttpRequestFailure)(NSError *error);

@interface GZHttpTool : NSObject

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

@end
