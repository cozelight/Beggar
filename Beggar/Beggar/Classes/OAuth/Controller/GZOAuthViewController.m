//
//  GZOAuthViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZOAuthViewController.h"
#import "GZHttpTool.h"
#import "GZTabBarController.h"

@interface GZOAuthViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation GZOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnAction)];
    
    self.navigationItem.rightBarButtonItem = nil;
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
    
//     2.用webView加载登陆页面
    [[GZHttpTool shareHttpTool] acquireOAuthRequestTokenWithSuccess:^(NSURL *reqUrl) {
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:reqUrl];
        [webView loadRequest:request];
        
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.webView.frame = self.view.bounds;
}

- (void)cancelBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}


// accessToken.key
// 574927-8f21c93a337d7753578e2f097f6052b3

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.检测URL类型
    NSString *url = request.URL.absoluteString;
    
    NSRange range = [url rangeOfString:@"localhost"];
    if (range.location != NSNotFound) {
        
        [[GZHttpTool shareHttpTool] acquireOAuthAccessTokenWithSuccess:^{
            
            // 2.切换控制器
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[GZTabBarController alloc] init];
            
        } failure:^(NSError *error) {
            
        }];
        return NO;
    }
    return YES;
}

@end
