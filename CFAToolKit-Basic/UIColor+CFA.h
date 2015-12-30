//
//  UIColor+CFA.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CFA)

#pragma mark - Basic
/// 16进制颜色
+(UIColor *)colorWithHex:(NSString *)hexColor;

/// 16进制颜色+透明度
+(UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha;

@end
