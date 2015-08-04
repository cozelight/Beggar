//
//  GZAccountTool.h
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GZAccount.h"

@interface GZAccountTool : NSObject

/**
*  存储账号信息
*
*  @param account 账号模型
*/
+ (void)saveAccount:(GZAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+ (GZAccount *)account;


@end
