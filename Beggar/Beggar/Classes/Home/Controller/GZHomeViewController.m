//
//  GZHomeViewController.m
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZHomeViewController.h"
#import "GZDetialStatusController.h"
#import "GZHttpTool.h"
#import "GZUser.h"
#import "GZPhoto.h"
#import "GZStatus.h"
#import "MJRefresh.h"
#import "GZAccountTool.h"
#import "GZStatusCell.h"
#import "GZStatusFrame.h"
#import "GZStatusTool.h"
#import "GZComposeController.h"

@interface GZHomeViewController ()

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
    
    // 5.设置搜索栏显示文字
    self.searchBar.placeholder = @"搜索时间轴";
    
    // 6.获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:560 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
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
    GZComposeController *composeVc = [[GZComposeController alloc] init];
    [self.navigationController pushViewController:composeVc animated:YES];
}

#pragma mark - 获取用户信息
- (void)setupUserInfo
{
    [[GZHttpTool shareHttpTool] getWithURL:kGZUserShow params:nil success:^(id json) {
        
        GZUser *user = [MTLJSONAdapter modelOfClass:GZUser.class fromJSONDictionary:json error:nil];
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
    
    NSArray *statuses = [GZStatusTool statusesWithParams:params];
    if (statuses.count) {
        dealingResult(statuses);
    } else {
        [[GZHttpTool shareHttpTool] getWithURL:kGZHomeTimeLine params:params success:^(id json) {
            
            //        GZLog(@"%@",json);
            // 存入数据库
            [GZStatusTool saveStatuses:json];
            
            dealingResult(json);
            
            // 显示最新微博的数量
            NSArray *statusArray = (NSArray *)json;
            [self showNewStatusCount:statusArray.count];
            
        } failure:^(NSError *error) {
            GZLog(@"%@",error);
            [self.tableView.header endRefreshing];
        }];
    }
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
- (void)showNewStatusCount:(NSUInteger)count
{
    // 刷新成功(清空图标数字)
    self.tabBarItem.badgeValue = nil;
    
    // 1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = GZAppearColor;
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    // 2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的消息，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd条新的消息", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    // 3.添加
    label.y = 64 - label.height;
    // 将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 4.动画
    // 先利用1s的时间，让label往下移动一段距离
    CGFloat duration = 1.0; // 动画的时间
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        // 延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay = 1.0; // 延迟1s
        // UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
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
        NSArray *newStatuses = [MTLJSONAdapter modelsOfClass:GZStatus.class fromJSONArray:statuses error:nil];
        NSArray *statusFrames = [self statusFramesWithStatuses:newStatuses];
        
        [self.statusArray addObjectsFromArray:statusFrames];
        
        [self.tableView.footer endRefreshing];
        [self.tableView reloadData];
    };
    
    NSArray *statuses = [GZStatusTool statusesWithParams:params];
    if (statuses.count) {
        dealingResult(statuses);
    } else {
        [[GZHttpTool shareHttpTool] getWithURL:kGZHomeTimeLine params:params success:^(id json) {
            
            [GZStatusTool saveStatuses:json];
            dealingResult(json);
            
        } failure:^(NSError *error) {
            GZLog(@"%@",error);
            [self.tableView.footer endRefreshing];
        }];
    }
}

#pragma mark - 获得未读消息数
- (void)setupUnreadCount
{
    [[GZHttpTool shareHttpTool] getWithURL:kGZNotification params:nil success:^(id json) {
        
        NSString *mentions = [json[@"mentions"] description];
        GZLog(@"json = %@, mentions = %@",json,mentions);
        if ([mentions isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
        } else { // 非0情况
            self.tabBarItem.badgeValue = mentions;
        }
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
    }];
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

@end