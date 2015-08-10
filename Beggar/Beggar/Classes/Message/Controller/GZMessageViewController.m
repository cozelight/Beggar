//
//  GZMessageViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZMessageViewController.h"
#import "GZDetialStatusController.h"
#import "GZHttpTool.h"
#import "GZUser.h"
#import "GZPhoto.h"
#import "GZStatus.h"
#import "MJRefresh.h"
#import "GZAccountTool.h"
#import "GZStatusCell.h"
#import "GZStatusFrame.h"
#import "GZMessageTool.h"
#import "GZComposeController.h"

@implementation GZMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"@提到我的";
    
    // 1.集成下拉刷新控件
    [self setupDownRefresh];
    
    // 2.集成上拉加载更多控件
    [self setupUpRefresh];
    
    // 3.设置搜索栏显示文字
    self.searchBar.placeholder = @"@我的消息";
    
}


#pragma mark - 集成下拉刷新控件
- (void)setupDownRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    
    // 进入刷新状态
    [self.tableView.header beginRefreshing];
}

- (void)loadNewStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"] = @"20";
    
    GZStatusFrame *statusFrame = [self.statusArray firstObject];
    if (statusFrame) {
        params[@"since_id"] = statusFrame.status.msgID;
        params[@"rawid"] = @(statusFrame.status.rawid);
    }
    
    void (^dealingResult)(NSArray *) = ^(NSArray *statuses){
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [MTLJSONAdapter modelsOfClass:GZStatus.class fromJSONArray:statuses error:nil];
        
        // 将 GZStatus数组 转为 GZStatusFrame数组
        NSArray *statusFrames = [self statusFramesWithStatuses:newStatuses];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, statusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusArray insertObjects:statusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
    };
    
    NSArray *statuses = [GZMessageTool statusesWithParams:params];
    if (statuses.count) {
        dealingResult(statuses);
    } else {
        [[GZHttpTool shareHttpTool] getWithURL:kGZStatusMentions params:params success:^(id json) {
            
            // 存入数据库
            [GZMessageTool saveStatuses:json];
            
            dealingResult(json);
            
        } failure:^(NSError *error) {
            GZLog(@"%@",error);
            [self.tableView.header endRefreshing];
        }];
    }
}

#pragma mark - 集成上拉加载更多控件
- (void)setupUpRefresh
{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
}

- (void)loadMoreStatus
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"] = @"20";
    
    GZStatusFrame *statusFrame = [self.statusArray lastObject];
    if (statusFrame) {
        params[@"max_id"] = statusFrame.status.msgID;
        params[@"rawid"] = @(statusFrame.status.rawid - 1);
    }
    
    void (^dealingResult)(NSArray *) = ^(NSArray *statuses){
        NSArray *newStatuses = [MTLJSONAdapter modelsOfClass:[GZStatus class] fromJSONArray:statuses error:nil];
        NSArray *statusFrames = [self statusFramesWithStatuses:newStatuses];
        
        [self.statusArray addObjectsFromArray:statusFrames];
        
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
    };
    
    NSArray *statuses = [GZMessageTool statusesWithParams:params];
    if (statuses.count) {
        dealingResult(statuses);
    } else {
        [[GZHttpTool shareHttpTool] getWithURL:kGZStatusMentions params:params success:^(id json) {
            
            [GZMessageTool saveStatuses:json];
            dealingResult(json);
            
        } failure:^(NSError *error) {
            GZLog(@"%@",error);
            [self.tableView.footer endRefreshing];
        }];
    }
}

#pragma mark tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZDetialStatusController *detailStatus = [[GZDetialStatusController alloc] init];
    GZStatusFrame *statusFrame = self.statusArray[indexPath.row];
    
    if (tableView != self.tableView) {
        statusFrame = self.filteredStatuses[indexPath.row];
    }
    
    detailStatus.status = statusFrame.status;
    [self.navigationController pushViewController:detailStatus animated:YES];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length) {
        NSArray *resultStatus = [GZMessageTool searchStatusesWithText:searchString];
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [MTLJSONAdapter modelsOfClass:[GZStatus class] fromJSONArray:resultStatus error:nil];
        
        // 将 GZStatus数组 转为 GZStatusFrame数组
        self.filteredStatuses = (NSMutableArray *)[self statusFramesWithStatuses:newStatuses];
    }
    return YES;
}

@end
