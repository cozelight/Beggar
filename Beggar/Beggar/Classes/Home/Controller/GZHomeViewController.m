//
//  GZHomeViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZHomeViewController.h"
#import "GZMessageViewController.h"
#import "GZHttpTool.h"
#import "GZUser.h"
#import "GZPhoto.h"
#import "GZStatus.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "GZAccountTool.h"
#import "GZStatusCell.h"
#import "GZStatusFrame.h"

@interface GZHomeViewController ()

@property (strong, nonatomic) NSMutableArray *statusArray;

@end

@implementation GZHomeViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置导航栏
    [self setupNav];
    
    // 2.获取用户信息
    [self setupUserInfo];
    
    // 3.集成下拉刷新控件
    [self setupDownRefresh];
    
    // 4.集成上拉加载更多控件
    [self setupUpRefresh];
}

- (NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [[NSMutableArray alloc] init];
    }
    return _statusArray;
}

#pragma makr - 设置导航栏
- (void)setupNav
{
    // 设置右上角发送按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemAddTarget:self action:@selector(sendClick) image:@"mask_timeline_top_icon" highlightImage:nil];

    // 设置标题
    GZAccount *account = [GZAccountTool account];
    self.navigationItem.title = account.userName ? account.userName : @"首页";
    
}

- (void)sendClick
{
    GZLog(@"sendClick");
}

#pragma mark - 获取用户信息
- (void)setupUserInfo
{
    [[GZHttpTool shareHttpTool] getWithURL:kGZUserShow params:nil success:^(id json) {
        
        GZUser *user = [GZUser objectWithKeyValues:json];
        GZAccount *account = [GZAccountTool account];
        account.userName = user.name;
        account.userID = user.userID;
        
        self.navigationItem.title = user.name;
        
        [GZAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
    }];
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
    }
    
    [[GZHttpTool shareHttpTool] getWithURL:kGZHomeTimeLine params:params success:^(id json) {
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *statuses = [GZStatus objectArrayWithKeyValuesArray:json];
        
        // 将 GZStatus数组 转为 GZStatusFrame数组
        NSArray *statusFrames = [self statusFramesWithStatuses:statuses];
        
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, statusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusArray insertObjects:statusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        // 显示最新微博的数量
        
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
        [self.tableView.header endRefreshing];
    }];
}

- (NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *statusFrames = [NSMutableArray array];
    for (GZStatus *status in statuses) {
        GZStatusFrame *statusFrame = [[GZStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrames addObject:statusFrame];
    }
    return statusFrames;
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
    }
    
    [[GZHttpTool shareHttpTool] getWithURL:kGZHomeTimeLine params:params success:^(id json) {
        
        NSArray *statuses = [GZStatus objectArrayWithKeyValuesArray:json];
        NSArray *statusFrames = [self statusFramesWithStatuses:statuses];
        
        [self.statusArray addObjectsFromArray:statusFrames];
        
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
        [self.tableView.footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZStatusCell *cell = [GZStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZStatusFrame *statusFrame = self.statusArray[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GZMessageViewController *vc = [[GZMessageViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"测试消息---%zd",indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end