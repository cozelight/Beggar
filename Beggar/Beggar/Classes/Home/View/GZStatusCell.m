//
//  GZStatusCell.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZStatusCell.h"
#import "GZStatusFrame.h"
#import "GZStatus.h"
#import "GZUser.h"
#import "GZPhoto.h"
#import "GZIconView.h"
#import "UIImageView+WebCache.h"
#import "GZTextView.h"

@interface GZStatusCell ()

/** 头像 */
@property (nonatomic, weak) GZIconView *iconView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) GZTextView *contentLabel;

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
        
        // 初始化微博
        [self setupStatus];
    }
    return self;
}

- (void)setupStatus
{
    // 头像
    GZIconView *iconView = [[GZIconView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = GZStatusCellNameFont;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = GZStatusCellTimeFont;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 正文
    GZTextView *contentLabel = [[GZTextView alloc] init];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 配图
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.contentMode = UIViewContentModeScaleAspectFill;
    photoView.clipsToBounds = YES;
    [self addSubview:photoView];
    self.photoView = photoView;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = GZStatusCellSourceFont;
    sourceLabel.textColor = [UIColor grayColor];
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
}

- (void)setStatusFrame:(GZStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    GZStatus *status = statusFrame.status;
    GZUser *user = status.user;
    
    // 头像
    self.iconView.user = user;
    self.iconView.frame = statusFrame.iconViewF;
    
    // 昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    // 时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.textColor = status.timeColor ? GZAppearTextColor : [UIColor grayColor];
    CGSize timeS = [status.created_at sizeWithFont:GZStatusCellTimeFont];
    CGFloat timeX = GZScreenW - timeS.width - kGZStatusCellInsert;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) - timeS.height;
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeS};
    
    // 正文
    self.contentLabel.attributedText = status.attributedText;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    // 配图
    if (status.photo) { // 有图
        
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.photo.imageurl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.frame = statusFrame.photosViewF;
        
    } else { // 无图
        self.photoView.hidden = YES;
    }
    
    // 来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
}

@end
