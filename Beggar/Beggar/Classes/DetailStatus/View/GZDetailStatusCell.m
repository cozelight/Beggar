//
//  GZDetailStatusCell.m
//  Beggar
//
//  Created by Madao on 15/8/8.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZDetailStatusCell.h"
#import "GZDetailStatus.h"
#import "GZOriginalView.h"
#import "GZStatusToolbar.h"

@interface GZDetailStatusCell ()

@property (weak, nonatomic) GZOriginalView *originalView;
@property (weak, nonatomic) GZStatusToolbar *toolbar;

@end

@implementation GZDetailStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"detailStatusCell";
    GZDetailStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[GZDetailStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化微博
        [self setupStatus];
    }
    return self;
}

- (void)setupStatus
{
    // 1.添加微博具体内容
    GZOriginalView *originalView = [[GZOriginalView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    // 2.添加工具条
    GZStatusToolbar *toolbar = [[GZStatusToolbar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;

}

- (void)setDetailStatus:(GZDetailStatus *)detailStatus
{
    _detailStatus = detailStatus;
    
    // 1.微博具体内容的frame数据
    self.originalView.statusFrame = detailStatus.statusFrame;
    self.originalView.y += kGZStatusCellInsert;
    
    // 2.底部工具条的frame数据
    self.toolbar.frame = detailStatus.toolbarFrame;
    self.toolbar.y += kGZStatusCellInsert;
}

@end
