//
//  UITextView+Extension.m
//  WB-01
//
//  Created by Madao on 15/7/22.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)text
{
    return [self insertAttributedText:text settingBlock:nil];
}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 拼接之前的文字和图片
    [attributedText appendAttributedString:self.attributedText];
    
    // 拼接其它文字
    NSUInteger loc = self.selectedRange.location;
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    // 调用外面传进来的代码
    if (settingBlock) {
        settingBlock (attributedText);
    }
    
    self.attributedText = attributedText;
    
    // 移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

@end
