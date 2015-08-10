//
//  GZComposeTextView.h
//  Beggar
//
//  Created by Madao on 15/8/10.
//  Copyright (c) 2015年 GanZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZComposeTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
