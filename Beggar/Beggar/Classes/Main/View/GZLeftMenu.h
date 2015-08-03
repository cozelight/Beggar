//
//  GZLeftMenu.h
//  Beggar
//
//  Created by Madao on 15/8/3.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GZLeftMenu, GZLeftMenuButton;

@protocol GZLeftMenuDelegate <NSObject>

@optional
- (void)leftMenu:(GZLeftMenu *)menu didSelectedBtnFromIndex:(NSInteger)fromIndex toInex:(NSInteger)toIndex;

- (void)leftMenu:(GZLeftMenu *)menu didClickIconBtn:(GZLeftMenuButton *)iconBtn;

@end

@interface GZLeftMenu : UIView

@property (weak, nonatomic) id<GZLeftMenuDelegate> delegate;

@end
