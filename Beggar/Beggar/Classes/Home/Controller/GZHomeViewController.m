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

@implementation GZHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [GZHttpTool getWith:@"http://api.fanfou.com/statuses/home_timeline.json" success:^(id json) {
        
        GZLog(@"%@",json);
        
    } failure:^(NSError *error) {
        GZLog(@"%@",error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试消息---%zd",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GZMessageViewController *vc = [[GZMessageViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"测试消息---%zd",indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
