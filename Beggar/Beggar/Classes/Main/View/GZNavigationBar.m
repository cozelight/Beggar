//
//  GZNavigationBar.m
//  Beggar
//
//  Created by Madao on 15/8/5.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import "GZNavigationBar.h"

@implementation GZNavigationBar

NSInteger const GZBarButtonItemMargin = 5;

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIButton *button in self.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        if (button.centerX < self.width * 0.5) { // 左边的按钮
            button.x = 3 * GZBarButtonItemMargin;
        } else if (button.centerX > self.width * 0.5) { // 右边的按钮
            button.x = self.width - button.width - GZBarButtonItemMargin;
        }
    }
}

@end
