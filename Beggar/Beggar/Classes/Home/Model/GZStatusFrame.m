//
//  GZStatusFrame.m
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZStatusFrame.h"
#import "GZStatus.h"
#import "GZUser.h"
#import "GZPhoto.h"

NSInteger const kGZStatusCellInsert = 10;
NSInteger const kGZStatusIconWH = 40;
NSInteger const kGZStatusPhotoWH = 80;

@implementation GZStatusFrame

- (void)setStatus:(GZStatus *)status
{
    _status = status;
    GZUser *user = status.user;
    
    // 头像
    CGFloat iconX = kGZStatusCellInsert;
    CGFloat iconY = kGZStatusCellInsert;
    CGFloat iconW = kGZStatusIconWH;
    CGFloat iconH = kGZStatusIconWH;
    self.iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat contentMaxW = GZScreenW - iconW - 3 * kGZStatusCellInsert;
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kGZStatusCellInsert;
    CGFloat nameY = iconY;
    CGSize nameS = [user.name sizeWithFont:GZStatusCellNameFont andMaxSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    self.nameLabelF = (CGRect){{nameX,nameY},nameS};
    
    // 时间
    CGSize timeS = [status.created_at sizeWithFont:GZStatusCellTimeFont];
    CGFloat timeX = GZScreenW - timeS.width - kGZStatusCellInsert;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) - timeS.height;
    self.timeLabelF = (CGRect){{timeX,timeY},timeS};
    
    // 配图
    CGFloat photoH = kGZStatusPhotoWH;
    CGFloat photoW = kGZStatusPhotoWH;
    CGFloat photoX = GZScreenW - photoW - kGZStatusCellInsert;
    CGFloat photoY = CGRectGetMaxY(self.nameLabelF) + kGZStatusCellInsert;
    self.photosViewF = CGRectMake(photoX, photoY, photoW, photoH);
    
    // 正文
    CGFloat contentX = nameX;
    CGFloat contentY = photoY;
    CGSize contentS;
    if (status.photo) { // 有图
        
        contentS = [status.text sizeWithFont:GZStatusCellContentFont andMaxSize:CGSizeMake(contentMaxW - photoW - kGZStatusCellInsert, MAXFLOAT)];
        
    } else { // 无图
        
        contentS = [status.text sizeWithFont:GZStatusCellContentFont andMaxSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    }
    self.contentLabelF = (CGRect){{contentX,contentY},contentS};
    
    // 来源
    CGFloat sourceX = nameX;
    CGFloat sourceY = CGRectGetMaxY(self.contentLabelF) + kGZStatusCellInsert;
    CGSize sourceS = [status.source sizeWithFont:GZStatusCellSourceFont andMaxSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceS};
    
    // cell高度
    if (status.photo) {
        self.cellHeight = MAX(CGRectGetMaxY(self.sourceLabelF), CGRectGetMaxY(self.photosViewF)) + kGZStatusCellInsert;
    } else {
        self.cellHeight = CGRectGetMaxY(self.sourceLabelF) + kGZStatusCellInsert;
    }
    
}

@end