//
//  GZDetailStatusCell.h
//  Beggar
//
//  Created by Madao on 15/8/8.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZDetailStatus;

@interface GZDetailStatusCell : UITableViewCell

@property (strong, nonatomic) GZDetailStatus *detailStatus;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
