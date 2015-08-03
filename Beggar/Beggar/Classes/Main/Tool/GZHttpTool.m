//
//  GZHttpTool.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZHttpTool.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"

@implementation GZHttpTool

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    // 1.创建client
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:url]];
    
    // 2.创建请求
    NSURLRequest *request = [client requestWithMethod:method path:nil parameters:params];
    
    // 3.发送请求
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (json[@"error"]) {
            if (failure) {
                NSError *error = [NSError errorWithDomain:json[@"error"] code:[json[@"error_code"] intValue] userInfo:json];
                failure(error);
            }
//            [MBProgressHUD showError:json[@"error"] toView:nil];
            [SVProgressHUD showErrorWithStatus:json[@"error"]];
        } else if (success) {
            success(json);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
        
//        [MBProgressHUD showError:error.domain toView:nil];
        [SVProgressHUD showErrorWithStatus:error.domain];
    }];
    [operation start];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    [self requestWithMethod:@"GET" url:url params:params success:success failure:failure];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    [self requestWithMethod:@"POST" url:url params:params success:success failure:failure];
}

@end
