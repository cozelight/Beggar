//
//  GZUser.h
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface GZUser : MTLModel<MTLJSONSerializing>

/** id string	用户id */
@property (copy, nonatomic) NSString *userID;

/** string	用户姓名 */
@property (copy, nonatomic) NSString *name;

/** string	用户昵称 */
@property (copy, nonatomic) NSString *screen_name;

/**	string	用户地址 */
@property (copy, nonatomic) NSString *location;

/**	string	用户性别 */
@property (copy, nonatomic) NSString *gender;

/**	string	用户生日信息 */
@property (copy, nonatomic) NSString *birthday;

/** description	string	用户自述 */
@property (copy, nonatomic) NSString *selfDescription;

/**	string	用户头像地址 */
@property (copy, nonatomic) NSString *profile_image_url;

/**	string	用户高清头像地址 */
@property (copy, nonatomic) NSString *profile_image_url_large;

/**	string	用户页面地址 */
@property (copy, nonatomic) NSString *url;

/** protected boolean 用户是否设置隐私保护 */
@property (assign, nonatomic) BOOL isProtected;

/**	int	用户关注用户数 */
@property (assign, nonatomic) int followers_count;

/**	int	用户好友数 */
@property (assign, nonatomic) int friends_count;

/**	int	用户收藏消息数 */
@property (assign, nonatomic) int favourites_count;

/**	int	用户消息数 */
@property (assign, nonatomic) int statuses_count;

/**	boolean	该用户是被当前登录用户关注 */
@property (assign, nonatomic) BOOL following;

/**	boolean	当前登录用户是否已对该用户发出关注请求 */
@property (assign, nonatomic) BOOL notifications;

/**	string	用户注册时间 */
@property (copy, nonatomic) NSString *created_at;

@end
