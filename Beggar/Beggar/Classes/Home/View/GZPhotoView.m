//
//  GZPhotoView.m
//  Beggar
//
//  Created by Madao on 15/8/9.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZPhotoView.h"
#import "GZPhoto.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation GZPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(tapPhoto:)];
        [self addGestureRecognizer:recognizer];
        
    }
    return self;
}

- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    MJPhoto *photo = [[MJPhoto alloc] init];
    // 设置图片的路径
    photo.url = [NSURL URLWithString:self.photo.largeurl];
    // 设置来源于哪一个UIImageView
    photo.srcImageView = self;
    
     NSArray *photos = [NSArray arrayWithObjects:photo, nil];
    
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}

@end
