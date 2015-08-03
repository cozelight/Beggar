//
//  UITextView+Extension.h
//  WB-01
//
//  Created by Madao on 15/7/22.
//  Copyright (c) 2015年 Madao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)text;

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
