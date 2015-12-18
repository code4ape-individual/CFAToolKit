//
//  UIImage+CFA.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "UIImage+CFA.h"

@implementation UIImage (CFA)

+(UIImage *)createResizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat halfWidth = image.size.width * 0.5;
    CGFloat halfHeight = image.size.height * 0.5;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight-1, halfWidth-1)];
    return image;
}

+(UIImage *)createHorizontalResizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat halfWidth = image.size.width * 0.5;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, halfWidth, 0, halfWidth-1)];
    return image;
}

+(UIImage *)createVerticalResizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat halfHeight = image.size.height * 0.5;
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, 0, halfHeight-1, 0)];
    return image;
}



+ (UIImage *)createImageWithColor:(UIColor *)color
{
    return [self createImageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage*)createImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
