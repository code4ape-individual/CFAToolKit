//
//  CFACounter.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "CFACounter.h"

#import "NSDate+CFA.h"

@interface CFACounter ()

@property (nonatomic,copy) countBlock block;
@property (nonatomic,assign) NSInteger seconds;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation CFACounter

-(instancetype)initWithDurationWithMinute:(NSInteger)minutes block:(countBlock)block
{
    if (self = [super init])
    {
        self.block = block;
        self.seconds = minutes * 60;
    }
    return self;
}

/// 从当前时间到目标时间的倒计时（未测试）
-(instancetype)initWithDate:(NSDate *)date block:(countBlock)block
{
    if (self = [super init])
    {
        self.block = block;
        
        NSDate *now = [NSDate date];
        
        // 当前时间大于等于目标时间
        if ([now compare:date] != NSOrderedAscending)
        {
            self.seconds = 0;
        }
        // 当期时间小于目标时间
        else
        {
            self.seconds = [date timeIntervalSinceNow];
        }
    }
    return self;
}


-(void)start
{
    if (self.timer)
    {
        [self.timer invalidate];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)pause
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)timerHandler
{
    if (self.seconds == 0)
    {
        if (self.block)
        {
            self.block(self.seconds);
        }
        
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        if (self.block)
        {
            self.block(self.seconds);
        }
        self.seconds--;
    }
}

@end
