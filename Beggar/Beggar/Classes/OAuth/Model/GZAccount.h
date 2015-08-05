//
//  GZAccount.h
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFOAuth1Client.h"

@interface GZAccount : NSObject <NSCoding>

/**
 The OAuth token key.
 */
@property (nonatomic, copy) NSString *key;

/**
 The OAuth token secret.
 */
@property (nonatomic, copy) NSString *secret;

/**
 The OAuth token session.
 */
@property (nonatomic, copy) NSString *session;

/** 用户昵称 */
@property (copy, nonatomic) NSString *userName;

/** 用户ID */
@property (copy, nonatomic) NSString *userID;

+ (instancetype)accountWithDict:(AFOAuth1Token *)access_token;

@end
