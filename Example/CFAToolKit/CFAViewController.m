//
//  CFAViewController.m
//  CFAToolKit
//
//  Created by dengjunjie on 12/18/2015.
//  Copyright (c) 2015 dengjunjie. All rights reserved.
//

#import "CFAViewController.h"

#import <CFAToolKit/CFABasic.h>
#import <CFAToolKit/CFAService.h>

@interface CFAViewController ()

@end

@implementation CFAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self testDateCategory];
    
    [self testCounter];
    
}

#pragma mark - Basic测试
- (void)testDateCategory
{
    NSLog(@"-----NSDate+CFA-----");
    NSLog(@"%ld",[[NSDate date] getDay]);
}

#pragma mark - Service测试
- (void)testCounter
{
    NSLog(@"-----CFACounter-----");
    
    CFACounter *counter = [[CFACounter alloc] initWithDurationWithMinute:1 block:^(NSInteger secondsLeft) {
        NSLog(@"----%ld",secondsLeft);
    }];
    
    [counter start];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [counter pause];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [counter start];
    });
}

@end
