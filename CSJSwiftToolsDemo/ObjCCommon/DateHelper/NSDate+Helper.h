//
//  NSDate+Helper.h
//  Sell
//
//  Created by iceesj on 12-10-20.
//  Copyright (c) 2012年 iceesj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Helper)

- (NSString *)getFormatYearMonthDay;

- (int )getWeekNumOfMonth;//返回当前月一共有几周(可能为4,5,6)
- (int )getWeekOfYear;//该日期是该年的第几周
- (NSDate *)dateAfterDay:(NSInteger)day;//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateafterMonth:(int)month;//month个月后的日期
- (NSUInteger)getDay;//获取日
- (NSUInteger)getMonth;//获取月
- (NSUInteger)getYear;//获取年
- (int )getHour;//获取小时
- (int)getMinute;//获取分钟
- (int )getHour:(NSDate *)date;
- (int)getMinute:(NSDate *)date;
- (NSUInteger)daysAgo;//在当前日期前几天
- (NSUInteger)daysAgoAgainstMidnight;//午夜时间距今几天
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)weekday;//返回一周的第几天(周末为第一天)
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)string;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
- (NSDate *)beginningOfWeek;//返回周日的开始时间
- (NSDate *)beginningOfDay;//返回当前天的年月日.
- (NSDate *)beginningOfMonth;//返回该月的第一天
- (NSDate *)endOfMonth;//该月的最后一天
- (NSDate *)endOfWeek;//返回当前周的周末

+ (NSDate *)dateFromString:(NSString *)string;//转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

@end
