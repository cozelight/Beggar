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


// 通知
// 头像被选中通知
extern NSString * const GZIconDidSelectNotification;
extern NSString * const GZSelectIconKey;

// 消息中链接被点击通知
extern NSString * const GZSpecialTextDidSelectNotification;
extern NSString * const GZSelectSpecialTextKey;


// API请求网站
/** 返回好友或未设置隐私用户的信息 */
extern NSString * const kGZUserShow;
/** 显示指定用户及其好友的消息 */
extern NSString * const kGZHomeTimeLine;
/** 返回未读的mentions, direct message 以及关注请求数量 */
extern NSString * const kGZNotification;
/** 按照时间先后顺序显示消息上下文 */
extern NSString * const kGZContextTimeLine;
/** 返回某条消息详细内容 */
extern NSString * const kGZStatusShow;
/** 显示回复/提到当前用户的20条消息 */
extern NSString * const kGZStatusMentions;
