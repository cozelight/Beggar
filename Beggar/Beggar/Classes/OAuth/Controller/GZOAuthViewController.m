//
//  GZOAuthViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZOAuthViewController.h"
#import "GZHttpTool.h"
#import "AFOAuth1Client.h"

NSString * const kGZRequestTokenUrl = @"http://fanfou.com/oauth/request_token";
NSString * const kGZAccessTokenUrl = @"http://fanfou.com/oauth/access_token";
NSString * const kGZAuthorizeUrl = @"http://fanfou.com/oauth/authorize";
NSString * const kGZConsumerKey = @"628995bdd46948e469a34742c88210fe";
NSString * const kGZConsumerSecret = @"1f61c472c6f51d3c02bd98e21b804e79";

@interface GZOAuthViewController () <UIWebViewDelegate>

@property (strong, nonatomic) AFOAuth1Client *OAuthClient;

@property (strong, nonatomic) AFOAuth1Token *reqToken;

@end

@implementation GZOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.用webView加载登陆页面
    
    NSURL *baseURL = [NSURL URLWithString:kGZRequestTokenUrl];
    AFOAuth1Client *OAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:baseURL key:kGZConsumerKey secret:kGZConsumerSecret];
    self.OAuthClient = OAuth1Client;
    
    NSURL *callbackURL = [NSURL URLWithString:@"http:///success"];
    [OAuth1Client acquireOAuthRequestTokenWithPath:kGZRequestTokenUrl callbackURL:callbackURL accessMethod:@"GET" scope:nil success:^(AFOAuth1Token *requestToken, id responseObject) {
        
        self.reqToken = requestToken;
        
        NSString *reqStr = [NSString stringWithFormat:@"http://m.fanfou.com/oauth/authorize?oauth_token=%@&oauth_callback=http://",self.reqToken.key];
        NSURL *reqUrl = [NSURL URLWithString:reqStr];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:reqUrl];
        [webView loadRequest:request];
        
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
    }];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.检测URL类型
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"localhost"];
    if (range.location != NSNotFound) {
//         2.获得accessToken
        [self.OAuthClient acquireOAuthAccessTokenWithPath:kGZAccessTokenUrl requestToken:self.reqToken accessMethod:@"GET" success:^(AFOAuth1Token *accessToken, id responseObject) {
            
            GZLog(@"%@",accessToken.key);
            
//            3.保存账号
//            
//            4.切换控制器
            
        } failure:^(NSError *error) {
            GZLog(@"%@",error);
        }];
        
        return NO;
    }
    return YES;
}

@end
