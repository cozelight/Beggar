//
//  GZDetailStatus.m
//  Beggar
//
//  Created by Madao on 15/8/8.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZDetailStatus.h"
#import "GZStatusFrame.h"
#import "GZStatus.h"
#import "GZUser.h"

@implementation GZDetailStatus

- (void)setStatus:(GZStatus *)status
{
    _status = status;
    self.statusFrame.status = status;
    
    // 1.计算微博具体内容（微博整体）
    [self setupDetailFrame];
    
    // 2.计算底部工具条
    [self setupToolbarFrame];
    
    // 3.计算cell的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame) + 2 * kGZStatusCellInsert;
}

/**
 *  计算微博具体内容（微博整体）
 */
- (void)setupDetailFrame
{
    GZStatusFrame *statusFrame = [[GZStatusFrame alloc] init];
    statusFrame.status = self.status;
    self.statusFrame = statusFrame;
}

/**
 *  计算底部工具条
 */
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.statusFrame.frame);
    CGFloat toolbarW = GZScreenW;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end
