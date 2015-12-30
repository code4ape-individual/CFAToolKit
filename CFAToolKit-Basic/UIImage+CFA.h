//
//  UIImage+CFA.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CFA)

#pragma mark - Basic
/// 创建可拉伸图片
+(UIImage *)createResizeImage:(NSString *)imageName;

/// 水平拉伸
+(UIImage *)createHorizontalResizeImage:(NSString *)imageName;

/// 垂直拉伸
+(UIImage *)createVerticalResizeImage:(NSString *)imageName;

/// 创建纯色图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

/// 创建纯色图片
+ (UIImage*)createImageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark - Business

@end
