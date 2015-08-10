//
//  GZDetialStatusController.m
//  Beggar
//
//  Created by Madao on 15/8/8.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZDetialStatusController.h"
#import "GZDetailStatus.h"
#import "GZStatusFrame.h"
#import "GZStatus.h"
#import "GZUser.h"
#import "GZDetailStatusCell.h"
#import "GZStatusCell.h"
#import "GZHttpTool.h"

@interface GZDetialStatusController ()

@property (strong, nonatomic) NSArray *statusArray;

@end

@implementation GZDetialStatusController

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详细";
    
    self.tableView.backgroundColor = GZColor(240, 240, 240);
    
}

- (NSArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [[NSArray alloc] init];
    }
    return _statusArray;
}

- (void)setStatus:(GZStatus *)status
{
    _status = status;
    if (status.in_reply_to_status_id.length) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"id"] = status.msgID;
        
        [[GZHttpTool shareHttpTool] getWithURL:kGZContextTimeLine params:params success:^(id json) {
            
            // 将 "微博字典"数组 转为 "微博模型"数组
            NSArray *statuses = [MTLJSONAdapter modelsOfClass:GZStatus.class fromJSONArray:json error:nil];
            
            // 将 GZStatus数组 转为 GZDetailStatus数组
            self.statusArray = [self detailStatusesWithStatuses:statuses];
            
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            GZLog(@"%@",error);
        }];
        
    } else {
        NSArray *statuses = [NSArray arrayWithObject:status];
        self.statusArray = [self detailStatusesWithStatuses:statuses];
        [self.tableView reloadData];
    }
}

- (NSArray *)detailStatusesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *detailStatuses = [NSMutableArray array];
    for (GZStatus *status in statuses) {
        GZDetailStatus *detailStatus = [[GZDetailStatus alloc] init];
        detailStatus.status = status;
        [detailStatuses addObject:detailStatus];
    }
    return detailStatuses;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZDetailStatus *detailStatus = self.statusArray[indexPath.row];
    
    if ([self.status.msgID isEqualToString:detailStatus.status.msgID]) {
        GZDetailStatusCell *cell = [GZDetailStatusCell cellWithTableView:tableView];
        cell.detailStatus = detailStatus;
        return cell;
    } else {
        GZStatusCell *cell = [GZStatusCell cellWithTableView:tableView];
        cell.statusFrame = detailStatus.statusFrame;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZDetailStatus *detailStatus = self.statusArray[indexPath.row];
    if ([self.status.msgID isEqualToString:detailStatus.status.msgID]) {
        
        return detailStatus.cellHeight;
        
    } else {
        return detailStatus.statusFrame.cellHeight;
    }
}

@end
