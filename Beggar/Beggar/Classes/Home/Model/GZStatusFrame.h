//
//  GZStatusFrame.h
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 昵称字体
#define GZStatusCellNameFont [UIFont boldSystemFontOfSize:15]
// 时间字体
#define GZStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define GZStatusCellSourceFont [UIFont systemFontOfSize:12]
// 正文字体
#define GZStatusCellContentFont [UIFont systemFontOfSize:14]

extern NSInteger const kGZStatusCellInsert;
extern NSInteger const kGZStatusIconWH;
extern NSInteger const kGZStatusPhotoWH;


@class GZStatus;

@interface GZStatusFrame : NSObject

/** 微博数据 */
@property (nonatomic, strong) GZStatus *status;

/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
