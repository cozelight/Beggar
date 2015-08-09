//
//  GZDetailStatus.h
//  Beggar
//
//  Created by Madao on 15/8/8.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZStatusFrame.h"

@interface GZDetailStatus : NSObject

/** 微博数据 */
@property (strong, nonatomic) GZStatus *status;
/** 微博Frame数据 */
@property (strong, nonatomic) GZStatusFrame *statusFrame;
/** toolBar */
@property (nonatomic, assign) CGRect toolbarFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
