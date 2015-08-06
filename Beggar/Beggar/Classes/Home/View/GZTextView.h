//
//  GZTextView.h
//  Beggar
//
//  Created by Madao on 15/8/6.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZTextView : UITextView

/** 所有的特殊字符串(里面存放着HWSpecial) */
@property (nonatomic, strong) NSArray *specials;

@end
