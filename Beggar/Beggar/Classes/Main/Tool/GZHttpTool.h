//
//  GZHttpTool.h
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth1Client.h"

typedef void (^HttpRequestSuccess)(id json);
typedef void (^HttpRequestFailure)(NSError *error);

@interface GZHttpTool : NSObject

+ (instancetype)shareHttpTool;

- (void)acquireOAuthRequestTokenWithSuccess:(void (^)(NSURL *reqUrl))success failure:(void (^)(NSError *error))failure;

- (void)acquireOAuthAccessTokenWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;

- (void)getWithURL:(NSString *)url success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;

@end
