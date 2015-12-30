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
- (NSInteger)getYear;
- (NSInteger)getMonth;
- (NSInteger)getDay;
- (NSInteger)getHour;
- (NSInteger)getMinute;

- (NSInteger)getWeekday;   // 星期几
- (NSInteger)weekOfMonth;  // 在当月的第几个星期
- (NSInteger)weekOfYear;   // 在当年的第几个星期

- (NSDate *)dateAfterYear:(NSInteger)year;
- (NSDate *)dateAfterMonth:(NSInteger)month;        // 返回month月后的日期
- (NSDate *)dateAfterDay:(NSInteger)day;            // 返回day天后的日期
- (NSDate *)dateAfterMinutes:(NSInteger)minutes;    // 返回minutes分钟后的时间

- (NSDate *)firstDateInThisMonth;   // 当月第一天
- (NSDate *)endDateInThisMonth;     // 当月最后一天

- (NSInteger)weeksInThisMonth;      // 当月有几个星期

@end
