//
//  GZStatusCell.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZStatusCell.h"
#import "GZOriginalView.h"

@interface GZStatusCell ()

@property (weak, nonatomic) GZOriginalView *originalView;

@end

@implementation GZStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"statusCell";
    GZStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[GZStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
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
        GZOriginalView *originalView = [[GZOriginalView alloc] init];
        self.originalView = originalView;
        [self addSubview:originalView];
    }
    return self;
}

- (void)setStatusFrame:(GZStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    self.originalView.statusFrame = statusFrame;
}

@end
