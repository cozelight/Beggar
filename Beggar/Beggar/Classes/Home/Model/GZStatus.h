//
//  GZStatus.h
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GZUser, GZPhoto;

@interface GZStatus : NSObject

/**	string	消息发送时间 */
@property (copy, nonatomic) NSString *created_at;

/**	string	消息发送时间是否有颜色 */
@property (assign, nonatomic) BOOL timeColor;

/** id	string	消息id */
@property (copy, nonatomic) NSString *msgID;

/**	int	消息序列号（可用于排序） */
@property (assign, nonatomic) int rawid;

/**	string	消息内容 */
@property (copy, nonatomic) NSString *text;

/**	string	消息内容 -- 带有属性的(特殊文字会高亮显示)*/
@property (nonatomic, copy, readonly) NSAttributedString *attributedText;

/**	string	消息来源 */
@property (copy, nonatomic) NSString *source;

/**	boolean	消息是否被截断 */
@property (assign, nonatomic) BOOL truncated;

/**	string	回复的消息id */
@property (copy, nonatomic) NSString *in_reply_to_status_id;

/**	string	回复的用户id */
@property (copy, nonatomic) NSString *in_reply_to_user_id;

/**	string	转发的消息id */
@property (copy, nonatomic) NSString *repost_status_id;

/**	object	转发的消息详细信息 */
@property (copy, nonatomic) NSString *repost_status;

/**	string	转发的用户id */
@property (copy, nonatomic) NSString *repost_user_id;

/**	string	消息的位置，格式可能是"北京 朝阳区"也可能是"234.333,47.9" */
@property (copy, nonatomic) NSString *location;

/**	boolean	消息是否被登录用户收藏 */
@property (assign, nonatomic) BOOL favorited;

/**	string	回复用户的昵称 */
@property (copy, nonatomic) NSString *in_reply_to_screen_name;

/**	object	发送此消息之用户信息 */
@property (strong, nonatomic) GZUser *user;

/**	object	消息中图片信息 */
@property (strong, nonatomic) GZPhoto *photo;


@end
