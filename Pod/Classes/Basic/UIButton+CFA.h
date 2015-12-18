//
//  UIButton+CFA.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CFA)

#pragma mark - Basic

/// 创建文字按钮
+(UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag target:(id)target selector:(SEL)selector;

/// 创建图片按钮
+(UIButton *)createButtonWithImage:(UIImage *)image tag:(NSInteger)tag target:(id)target selector:(SEL)selector;

#pragma mark - Business

@end
