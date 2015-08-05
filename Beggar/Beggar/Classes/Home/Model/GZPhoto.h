//
//  GZPhoto.h
//  Beggar
//
//  Created by Madao on 15/8/5.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZPhoto : NSObject

/**	string	图片地址 */
@property (copy, nonatomic) NSString *imageurl;

/**	string	缩略图地址 */
@property (copy, nonatomic) NSString *thumburl;

/**	string	图片原图地址 */
@property (copy, nonatomic) NSString *largeurl;

@end
