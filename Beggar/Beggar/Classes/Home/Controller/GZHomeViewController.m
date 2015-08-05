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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
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

/*
 
 location = 福建,
	birthday = 1991-00-00,
	statuses_count = 1041,
	status = {
	source = 网页,
	truncated = 0,
	id = BUHL7ef-EYU,
	created_at = Mon Aug 03 17:58:07 +0000 2015,
	rawid = 185473038,
	in_reply_to_lastmsg_id = ,
	text = 哈哈哈哈, 折腾了一天, 弄到现在, 总算踏出了第一步! 现在肚子饿的呱呱叫,
	favorited = 0,
	in_reply_to_screen_name = ,
	in_reply_to_user_id =
 },
	url = ,
	profile_sidebar_fill_color = #000000,
	profile_sidebar_border_color = #006fa6,
	notifications = 0,
	friends_count = 4,
	name = Elfen_Madao,
	screen_name = Elfen_Madao,
	utc_offset = 28800,
	profile_background_color = #000000,
	id = fairright,
	gender = 男,
	protected = 0,
	profile_background_image_url = http://avatar.fanfou.com/b0/00/hh/ef_1299405272.jpg,
	profile_image_url_large = http://avatar2.fanfou.com/l0/00/hh/ef.jpg?1290746754,
	profile_background_tile = 0,
	profile_image_url = http://avatar2.fanfou.com/s0/00/hh/ef.jpg?1290746754,
	followers_count = 35,
	following = 0,
	profile_text_color = #4b585e,
	created_at = Fri Nov 26 04:36:44 +0000 2010,
	favourites_count = 1,
	profile_link_color = #3a9dcf,
	description = 每一个优秀的人，都有一段沉默的时光。
 
 付出了很多努力，忍受孤单和寂寞。
 
 不抱怨，不诉苦。
 
 最后，渡过了这段感动自己的时光。
 
 如果你无法忍受孤独，就不要追逐梦想。
 
 Fight。
 }
 
 */