//
//  GZIconView.m
//  Beggar
//
//  Created by Madao on 15/8/6.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZIconView.h"
#import "GZUser.h"
#import "UIImageView+WebCache.h"

@implementation GZIconView

- (void)setUser:(GZUser *)user
{
    _user = user;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView sd_setImageWithURL:[NSURL URLWithString:self.user.profile_image_url_large] placeholderImage:[UIImage imageNamed:@"timeline_item_pic_icon"]];

    self.image = [iconView.image circleImageWithBorderWidth:0.1 borderColor:[UIColor grayColor]];
    
}

@end
