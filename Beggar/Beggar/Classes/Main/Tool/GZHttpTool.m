//
//  GZHttpTool.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZHttpTool.h"
#import "GZAccountTool.h"
#import "AFNetworking.h"

@interface GZHttpTool ()

@property (strong, nonatomic) AFOAuth1Client *OAuthClient;
@property (strong, nonatomic) AFOAuth1Token *requestToken;

@end

// 用来保存唯一的单例对象
static id _instance;

@implementation GZHttpTool

#pragma mark - 初始化单例

+ (instancetype)shareHttpTool
{
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[GZHttpTool alloc] init];
        }
        return _instance;
    }
}

+ (void)releaseInstance {
    @synchronized(self) {
        if (_instance != nil) {
            [_instance releaseOAuthClient];
            _instance = nil;
        }
    }
}

#pragma mark - OAuth

- (void)releaseOAuthClient {
    self.OAuthClient = nil;
    self.requestToken = nil;
}

- (AFOAuth1Client *)OAuthClient
{
    if (_OAuthClient == nil) {
        
        NSURL *baseURL = [NSURL URLWithString:kGZRequestTokenUrl];
        _OAuthClient = [[AFOAuth1Client alloc] initWithBaseURL:baseURL key:kGZConsumerKey secret:kGZConsumerSecret];
    }
    return _OAuthClient;
}

- (void)acquireOAuthRequestTokenWithSuccess:(void (^)(NSURL *))success failure:(void (^)(NSError *))failure
{
    NSURL *callbackURL = [NSURL URLWithString:kGZCallBackUrl];
    [self.OAuthClient acquireOAuthRequestTokenWithPath:kGZRequestTokenUrl callbackURL:callbackURL accessMethod:@"GET" scope:nil success:^(AFOAuth1Token *requestToken, id responseObject) {
        
        self.requestToken = requestToken;
        
        NSString *reqStr = [NSString stringWithFormat:@"http://m.fanfou.com/oauth/authorize?oauth_token=%@&oauth_callback=http://",requestToken.key];
        NSURL *reqUrl = [NSURL URLWithString:reqStr];
        if (success) {
            success(reqUrl);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)acquireOAuthAccessTokenWithSuccess:(void (^)())success failure:(void (^)(NSError *))failure
{
    
    [self.OAuthClient acquireOAuthAccessTokenWithPath:kGZAccessTokenUrl requestToken:self.requestToken accessMethod:@"GET" success:^(AFOAuth1Token *accessToken, id responseObject) {
        if (success) {
            
            // 将返回的账号字典数据 --> 模型，存进沙盒
            GZAccount *account = [GZAccount accountWithDict:accessToken];
            
            [GZAccountTool saveAccount:account];
            
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 网络请求

- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    GZAccount *account = [GZAccountTool account];
    AFOAuth1Token *accessToken = [[AFOAuth1Token alloc] initWithKey:account.key secret:account.secret session:account.session expiration:nil renewable:NO];
    
    self.OAuthClient.accessToken = accessToken;
    
    [self.OAuthClient getWith:url params:params  success:^(id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    GZAccount *account = [GZAccountTool account];
    AFOAuth1Token *accessToken = [[AFOAuth1Token alloc] initWithKey:account.key secret:account.secret session:account.session expiration:nil renewable:NO];
    
    self.OAuthClient.accessToken = accessToken;
    
    [self.OAuthClient postWith:url params:params success:^(id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)postWithURL:(NSString *)url params:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure
{
    GZAccount *account = [GZAccountTool account];
    AFOAuth1Token *accessToken = [[AFOAuth1Token alloc] initWithKey:account.key secret:account.secret session:account.session expiration:nil renewable:NO];
    
    self.OAuthClient.accessToken = accessToken;
    [self.OAuthClient postWith:url params:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (block) {
            block(formData);
        }
    } success:^(id responseObject) {
        id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            GZLog(@"%@",error);
            failure(error);
        }
    }];
    
}

@end
