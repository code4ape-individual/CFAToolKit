//
//  UIView+CFA.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "UIView+CFA.h"

@implementation UIView (CFA)

- (void)enableHideKeyboardWhenTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAction)];
    [self addGestureRecognizer:tap];
}


- (void)didTapAction
{
    [self endEditing:YES];
}

#pragma mark - Business
+(UIView *)createLine
{
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    
    return line;
}

@end
