//
//  GZIconView.m
//  Beggar
//
//  Created by Madao on 15/8/6.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZIconView.h"
#import "GZUser.h"
#import "UIImageView+WebCache.h"
#import "GZPersonalController.h"

@implementation GZIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(tapIcon:)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

- (void)tapIcon:(UITapGestureRecognizer *)recognizer
{
    // 处理点击
    GZPersonalController *msgVc = [[GZPersonalController alloc] init];
    msgVc.title = self.user.name;
    
    [self.getCurrentVC.navigationController pushViewController:msgVc animated:YES];
    
}


- (void)setUser:(GZUser *)user
{
    _user = user;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView sd_setImageWithURL:[NSURL URLWithString:self.user.profile_image_url_large] placeholderImage:[UIImage imageNamed:@"timeline_item_pic_icon"]];

    self.image = [iconView.image circleImageWithBorderWidth:0.2 borderColor:[UIColor blackColor]];
    
}

@end
