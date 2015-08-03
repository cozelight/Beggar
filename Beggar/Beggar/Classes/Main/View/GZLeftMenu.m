//
//  GZLeftMenu.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZLeftMenu.h"
#import "GZLeftMenuButton.h"

@interface GZLeftMenu ()

@property (weak, nonatomic) GZLeftMenuButton *selectedButton;

@end

@implementation GZLeftMenu

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = GZRandomColor;
        
        CGFloat alpha = 0.2;
        
        // 初始化按钮
        [self setupBtnWithTitle:@"全部消息" bgColor:GZColorRGBA(202, 68, 73, alpha)];
        [self setupBtnWithTitle:@"收藏" bgColor:GZColorRGBA(190, 111, 69, alpha)];
        [self setupBtnWithTitle:@"照片" bgColor:GZColorRGBA(76, 132, 190, alpha)];
        [self setupBtnWithTitle:@"草稿" bgColor:GZColorRGBA(170, 172, 73, alpha)];
    
        // 设置头像
        [self setupIcon];
        
    }
    return self;
}

- (void)setDelegate:(id<GZLeftMenuDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选择第一个按钮
    [self buttonClick:[self.subviews firstObject]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnW = self.width;
    
    // 设置头像frame
    GZLeftMenuButton *iconBtn = [self.subviews lastObject];
    iconBtn.height = 0.4 * self.height;
    iconBtn.width = btnW;
    iconBtn.y = 0;
    
    // 设置按钮frame
    NSInteger btnCount = self.subviews.count - 1;
    CGFloat btnH = 0.4 * self.height / btnCount;
    for (int i = 0; i<btnCount; i++) {
        GZLeftMenuButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = CGRectGetMaxY(iconBtn.frame) + i * btnH;
    }
}

#pragma mark - 私有方法

/**
 *  添加按钮
 *
 *  @param title   标题
 *  @param bgColor 选择背景色
 *
 */
- (GZLeftMenuButton *)setupBtnWithTitle:(NSString *)title bgColor:(UIColor *)bgColor
{
    GZLeftMenuButton *btn = [[GZLeftMenuButton alloc] init];
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // 设置标题和背景色
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
    return btn;
}

/**
 *  监听按钮点击
 *
 */
- (void)buttonClick:(GZLeftMenuButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelectedBtnFromIndex:toInex:)]) {
        [self.delegate leftMenu:self didSelectedBtnFromIndex:self.selectedButton.tag toInex:button.tag];
    }
    
    // 2.切换按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

/**
 *  初始化头像按钮
 */
- (void)setupIcon
{
    GZLeftMenuButton *btn = [[GZLeftMenuButton alloc] init];
    [btn addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // 设置图片
    [btn setImage:[UIImage imageWithColor:GZRandomColor] forState:UIControlStateNormal];
    
    // 设置高亮的时候不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    
}

/**
 *  监听头像按钮点击
 *
 */
- (void)iconClick:(GZLeftMenuButton *)iconBtn
{
    if ([self.delegate respondsToSelector:@selector(leftMenu:didClickIconBtn:)]) {
        [self.delegate leftMenu:self didClickIconBtn:iconBtn];
    }
}

@end
