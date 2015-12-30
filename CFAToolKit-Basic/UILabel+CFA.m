//
//  UILabel+CFA.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "UILabel+CFA.h"

@implementation UILabel (CFA)

+(UILabel *)createLabelWithText:(NSString *)text font:(UIFont *)font
{
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = font;
    label.textColor = [UIColor whiteColor];
    
    return label;
}

@end
