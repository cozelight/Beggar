//
//  GZStatusCell.h
//  Beggar
//
//  Created by Madao on 15/8/4.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZStatusFrame;

@interface GZStatusCell : UITableViewCell

@property (strong, nonatomic) GZStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
