//
//  GZOAuthViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZOAuthViewController.h"
#import "GZHttpTool.h"

@interface GZOAuthViewController () <UIWebViewDelegate>

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
    
//    获取未授权的Request Token
//    请求参数
//    oauth_consumer_key	饭否应用的API Key
//    oauth_signature_method	签名方法，目前只支持HMAC-SHA1
//    oauth_signature	签名值，签名方法见[[OAuthSignature]]
//    oauth_timestamp	时间戳，取当前时间
//    oauth_nonce	单次值，随机的字符串，防止重复请求
    
    NSString *baseURL = @"http://fanfou.com/oauth/request_token";

//    key:@"628995bdd46948e469a34742c88210fe" secret:@"1f61c472c6f51d3c02bd98e21b804e79"];
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"oauth_consumer_key"] = @"628995bdd46948e469a34742c88210fe";
//    params[@"oauth_signature_method"] = @"HMAC-SHA1";
//    params[@"oauth_signature"] = @"";
//    params[@"oauth_timestamp"] = [@(floor([[NSDate date] timeIntervalSince1970])) stringValue];
//    params[@"oauth_nonce"] = AFNounce();
    
    
}



@end
