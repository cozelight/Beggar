//
//  GZComposeController.m
//  Beggar
//
//  Created by Madao on 15/8/10.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZComposeController.h"
#import "GZHttpTool.h"
#import "XMGStatusBarHUD.h"
#import "GZAccountTool.h"
#import "GZComposeTextView.h"

@interface GZComposeController () <UITextViewDelegate>

/** 输入控件 */
@property (nonatomic, weak) GZComposeTextView *textView;

@end

@implementation GZComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    [GZNotificationCenter removeObserver:self];
}

/**
 * 设置导航栏内容
 */
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    NSString *name = [GZAccountTool account].userName;
    NSString *prefix = @"发消息";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        // 自动换行
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        // 创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        // 添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attrStr.length)];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}

/**
 * 添加输入控件
 */
- (void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    GZComposeTextView *textView = [[GZComposeTextView alloc] init];
    // 垂直方向上永远可以拖拽（有弹簧效果）
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 文字改变的通知
    [GZNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

- (void)send
{
    [XMGStatusBarHUD showLoading:@"正在发送"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    
    [[GZHttpTool shareHttpTool] postWithURL:kGZStatusUpdate params:params success:^(id json) {
        
        [XMGStatusBarHUD showSuccess:@"发送成功"];
        
    } failure:^(NSError *error) {
        [XMGStatusBarHUD showError:@"发送失败"];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
