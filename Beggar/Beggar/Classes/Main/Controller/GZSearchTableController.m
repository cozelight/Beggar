//
//  GZSearchTableController.m
//  Beggar
//
//  Created by Madao on 15/8/7.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//
#import "GZSearchTableController.h"
#import "GZHttpTool.h"
#import "GZUser.h"
#import "GZPhoto.h"
#import "GZStatus.h"
#import "GZStatusCell.h"
#import "GZStatusFrame.h"
#import "GZStatusTool.h"

@interface GZSearchTableController () <UISearchBarDelegate, UISearchDisplayDelegate>


@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;

@end

@implementation GZSearchTableController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = GZColor(240, 240, 240);
    
    // 1.添加搜索栏
    [self setupSearchBar];
    
}

- (NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [[NSMutableArray alloc] init];
    }
    return _statusArray;
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

- (void)dealloc
{
    [GZNotificationCenter removeObserver:self];
}

#pragma mark - 添加搜索栏
- (void)setupSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.delegate = self;

    [self.searchBar sizeToFit];
    
    self.strongSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.delegate = self;
    
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.contentOffset = CGPointMake(0, CGRectGetHeight(self.searchBar.bounds));
}

#pragma mark - Search Delegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.filteredStatuses = self.statusArray;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.filteredStatuses = nil;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString.length) {
        NSArray *resultStatus = [GZStatusTool searchStatusesWithText:searchString];
        
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [MTLJSONAdapter modelsOfClass:GZStatus.class fromJSONArray:resultStatus error:nil];
        
        // 将 GZStatus数组 转为 GZStatusFrame数组
        self.filteredStatuses = (NSMutableArray *)[self statusFramesWithStatuses:newStatuses];
    }
    return YES;
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.statusArray.count;
    } else {
        return self.filteredStatuses.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GZStatusCell *cell = [GZStatusCell cellWithTableView:tableView];
    if (tableView == self.tableView) {
        cell.statusFrame = self.statusArray[indexPath.row];
    } else {
        cell.statusFrame = self.filteredStatuses[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        GZStatusFrame *statusFrame = self.statusArray[indexPath.row];
        return statusFrame.cellHeight;
    } else {
        GZStatusFrame *statusFrame = self.filteredStatuses[indexPath.row];
        return statusFrame.cellHeight;
    }
    
}

@end
