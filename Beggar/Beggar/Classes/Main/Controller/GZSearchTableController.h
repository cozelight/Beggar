//
//  GZSearchTableController.h
//  Beggar
//
//  Created by Madao on 15/8/7.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZSearchTableController : UITableViewController

/** 原始table数据 */
@property (strong, nonatomic) NSMutableArray *statusArray;

/** 搜索结果table数据 */
@property (strong, nonatomic) NSMutableArray *filteredStatuses;

@property(nonatomic, strong, readwrite) UISearchBar *searchBar;

/**
 *  status数组转statusFrame数组
 */
- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses;

@end
