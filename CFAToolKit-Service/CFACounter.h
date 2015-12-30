//
//  CFACounter.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^countBlock)(NSInteger secondsLeft);

@interface CFACounter : NSObject

/// 计时时间
-(instancetype)initWithDurationWithMinute:(NSInteger)minutes block:(countBlock)block;

/// 从当前时间到目标时间的倒计时（未测试）
-(instancetype)initWithDate:(NSDate *)date block:(countBlock)block;

-(void)pause;
-(void)start;

@end
