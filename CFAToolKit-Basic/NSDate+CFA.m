//
//  NSDate+CFA.m
//  CFAToolKit
//
//  Created by Jack on 15/11/24.
//  Copyright © 2015年 code4ape-individual. All rights reserved.
//

#import "NSDate+CFA.h"

@implementation NSDate (CFA)


#pragma mark - 获取日期元素
//获取日
- (NSInteger)getDay
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    
    return [dayComponents day];
    
}

//获取月
- (NSInteger)getMonth
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    
    return [dayComponents month];
    
}

//获取年
- (NSInteger)getYear
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    
    return [dayComponents year];
    
}

//获取小时
- (NSInteger)getHour
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:self];
    
    NSInteger hour = [components hour];
    
    return (NSInteger)hour;
    
}

//获取分钟
- (NSInteger)getMinute
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:self];
    
    NSInteger minute = [components minute];
    
    return (NSInteger)minute;
    
}

// 星期几
- (NSInteger)getWeekday
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    
    return [weekdayComponents weekday];
}

// 在当月的第几个星期
- (NSInteger)weekOfMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekOfMonth) fromDate:self];
    
    return [weekdayComponents weekOfMonth];
}

-(NSInteger)weekOfYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date = self;
    
    NSInteger weekOfYear = [[calendar components:(NSCalendarUnitWeekOfYear) fromDate:date] weekOfYear];
    
    NSInteger weekOffset = 0;
    
    // 下一年的1号跟今年的12月31号在同一周，则12月31号算进下一年的第一个星期
    
    
    if ([self getMonth] == 12)
    {
        while (weekOfYear == 1)
        {
            weekOffset = 1;
            date = [date dateAfterDay:-1];
            weekOfYear = [[calendar components:(NSCalendarUnitWeekOfYear) fromDate:date] weekOfYear];
        }
    }
    
    return weekOfYear + weekOffset;
}

#pragma mark - 获取延时后的日期
// 返回day天后的日期，负数为day天前的日期
- (NSDate *)dateAfterYear:(NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setYear:year];
    NSDate *dateAfterYear = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterYear;
}

//month个月后的日期
- (NSDate *)dateAfterMonth:(NSInteger)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMonth;
}

- (NSDate *)dateAfterDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}

- (NSDate *)dateAfterMinutes:(NSInteger)minutes
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMinute:minutes];
    NSDate *dateAfterMinute = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMinute;
}


// 当月的第一天
- (NSDate *)firstDateInThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitTimeZone fromDate:self];
    components.day = 1;
    
    NSDate *firstDate = [calendar dateFromComponents:components];
    
    return firstDate;
}

// 当月最后一天
- (NSDate *)endDateInThisMonth
{
    return [[[self firstDateInThisMonth] dateAfterMonth:1] dateAfterDay:-1];
}


// 当月有几个星期
-(NSInteger)weeksInThisMonth
{
    return [[self endDateInThisMonth] weekOfYear] - [[self firstDateInThisMonth] weekOfYear] + 1;
}

@end
