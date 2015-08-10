//
//  GZConst.m
//  Beggar
//
//  Created by Madao on 15/8/5.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZConst.h"

// 账号信息
NSString * const kGZRequestTokenUrl = @"http://fanfou.com/oauth/request_token";
NSString * const kGZAccessTokenUrl = @"http://fanfou.com/oauth/access_token";
NSString * const kGZConsumerKey = @"628995bdd46948e469a34742c88210fe";
NSString * const kGZConsumerSecret = @"1f61c472c6f51d3c02bd98e21b804e79";
NSString * const kGZCallBackUrl = @"http:///success";

// 通知
// 头像被选中通知
NSString * const GZIconDidSelectNotification = @"GZIconDidSelectNotification";
NSString * const GZSelectIconKey = @"GZSelectIconKey";

// 消息中链接被点击通知
NSString * const GZSpecialTextDidSelectNotification = @"GZSpecialTextDidSelectNotification";
NSString * const GZSelectSpecialTextKey = @"GZSelectSpecialTextKey";

// API请求网址
NSString * const kGZUserShow = @"http://api.fanfou.com/users/show.json";
NSString * const kGZHomeTimeLine = @"http://api.fanfou.com/statuses/home_timeline.json";
NSString * const kGZNotification = @"http://api.fanfou.com/account/notification.json";
NSString * const kGZContextTimeLine = @"http://api.fanfou.com/statuses/context_timeline.json";
NSString * const kGZStatusShow = @"http://api.fanfou.com/statuses/show.json";
NSString * const kGZStatusMentions = @"http://api.fanfou.com/statuses/mentions.json";
NSString * const kGZStatusUpdate = @"http://api.fanfou.com/statuses/update.json";