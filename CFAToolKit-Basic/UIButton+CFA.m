//
//  UIButton+CFA.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "UIButton+CFA.h"

@implementation UIButton (CFA)

+(UIButton *)createButtonWithImage:(UIImage *)image tag:(NSInteger)tag target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton new];
    btn.tag = tag;
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+(UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton new];
    btn.tag = tag;
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
