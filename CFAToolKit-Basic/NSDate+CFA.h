//
//  NSDate+CFA.h
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CFA)

#pragma mark - Basic
// 获取年月日时分
- (NSUInteger)getDay;
- (NSUInteger)getMonth;
- (NSUInteger)getYear;
- (NSInteger)getHour;
- (NSInteger)getMinute;
- (NSUInteger)getWeekday;   // 星期几
- (NSUInteger)weekOfMonth;  // 在当月的第几个星期
- (NSUInteger)weekOfYear;   // 在当年的第几个星期

- (NSDate *)dateAfterMinutes:(NSInteger)minutes;    // 返回minutes分钟后的时间
- (NSDate *)dateAfterDay:(NSInteger)day;            // 返回day天后的日期
- (NSDate *)dateafterMonth:(NSInteger)month;        // 返回month月后的日期

- (NSDate *)firstDateInThisMonth;   // 当月第一天
- (NSDate *)endDateInThisMonth;     // 当月最后一天

- (NSUInteger)weeksInThisMonth;     // 当月有几个星期

@end
