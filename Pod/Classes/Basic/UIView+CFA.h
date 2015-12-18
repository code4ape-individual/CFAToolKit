//
//  UIView+CFA.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^voidBlock)();

@interface UIView (CFA)

#pragma mark - Basic
// 给View添加点击事件，点击时隐藏所有键盘
- (void)enableHideKeyboardWhenTap;

//#warning 未实现，需要绑定block
//// 创建遮罩
//+ (UIView *)createMaskWithTapAction:(voidBlock)block;

#pragma mark - Business
/// 创建一条线
+(UIView *)createLine;

@end
