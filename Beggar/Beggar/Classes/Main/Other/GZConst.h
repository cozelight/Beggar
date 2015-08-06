//
//  GZConst.h
//  Beggar
//
//  Created by Madao on 15/8/5.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 账号信息
extern NSString * const kGZRequestTokenUrl;
extern NSString * const kGZAccessTokenUrl;
extern NSString * const kGZConsumerKey;
extern NSString * const kGZConsumerSecret;
extern NSString * const kGZCallBackUrl;

// API请求网站
/** 返回好友或未设置隐私用户的信息 */
extern NSString * const kGZUserShow;
/** 显示指定用户及其好友的消息 */
extern NSString * const kGZHomeTimeLine;
/** 返回未读的mentions, direct message 以及关注请求数量 */
extern NSString * const kGZNotification;
