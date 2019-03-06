//
//  NSString+timer.m
//  HMFoundationWork
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 amumu. All rights reserved.
//

#import "NSString+timer.h"

@implementation NSString (timer)



//时间戳转时间

+ (NSString *)cpx_getTimeWithTimeIntervalStr:(NSString *)timeStampStr
                           timeStampType:(timeStampType)timeStampType
{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeStampStr doubleValue]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if(timeStampType == timeStampTypeYMDHMS){
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (timeStampType == timeStampTypeYMD){
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
    }else if (timeStampType == timeStampTypeHMS){
        [dateFormat setDateFormat:@"HH:mm:ss"];
    }
    
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [dateFormat setTimeZone:timeZone];
    return [dateFormat stringFromDate:currentDate];
}
#pragma mark - 时间戳转时间
+ (NSString *)cpx_timeWithTimeIntervalString:(NSString *)timeString
{
    NSDate *nd = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[timeString doubleValue]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    // [dateFormat setDateFormat:@"HH:mm:ss"];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [dateFormat setTimeZone:timeZone];
    
    
    NSString *dateString = [dateFormat stringFromDate:nd];
    return dateString;
}

//当前日期转时间戳（日期NSDate 转 时间戳NSString）

+(NSString *)cpx_timeToTurnTheTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return timeString;
}
//日期字符串转时间戳（NSString转时间戳NSString）
+(NSString *)cpx_turnTheTimestampString:(NSString*) timeStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    return  timeString;
}
//将nsstring转换为nsdate
+(NSDate*)cpx_stringToDate:(NSString *)dateStr{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd"];
    NSDate* date = [formater dateFromString:dateStr];
    NSLog(@"%@", date);
    return date;}

/**
 计算两个日期的相差月数，并返回中间间隔的月份
 
 @param fromDates 开始时间
 */
+(NSArray *)cpx_caculateDiffreceMonthFromDate:(NSString *)fromDates {
    
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//指定日历算法
    [calendar setFirstWeekday:2];
    NSDate *fromDate = [self cpx_stringToDate:fromDates];//将字符串转化成时间格式
    NSDate *toDate = [NSDate date];//结束时间
    NSInteger ZCYear = [[fromDates substringToIndex:4] integerValue];//开始时间的年份
    NSRange range = NSMakeRange(5, 2);
    NSInteger ZCMonth = [[fromDates substringWithRange:range] integerValue];//开始时间的月份
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    NSInteger year = components.year; //相差的年数
    NSInteger month = components.month;//相差的月数
    //    NSInteger day = components.day;//相差的天数
    NSMutableArray *array = [NSMutableArray array]; //用来存放月份的数组(2015年7月)
    for (NSInteger months = 0; months<=year*12+month; months++) {
        NSLog(@"%ld",months);
        ZCMonth = (ZCMonth+1);
        if (ZCMonth>12) {
            ZCMonth = ZCMonth %12;
            ZCYear ++;
        }
        NSString *str;
        if (ZCMonth<10) {
            str = [NSString stringWithFormat:@"%ld年0%ld月",ZCYear,ZCMonth];
        }else{
            str = [NSString stringWithFormat:@"%ld年%ld月",ZCYear,ZCMonth];
        }
        [array insertObject:str atIndex:0];
    }
    
    return array;
}



/**
 获取昨天的日期
 
 @return 返回日期字符串
 */
+(NSString *)cpx_getYestodayDate{
    //再获取的时间date减去24小时的时间（昨天的这个时候）
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-(24*60*60)];
    return [self cpx_dateTonString:yesterday];
    
}


/**
 date转string
 
 @param date date
 @return string
 */
+(NSString *)cpx_dateTonString:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+(NSString *)cpx_timeStrChangeWithTime:(NSInteger)timeNum{

    NSInteger sec = timeNum % 60;
    NSInteger min = timeNum / 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
}

//获取当前时间
+(NSString *)cpx_getCureentTime{
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
//
//    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setTimeZone:zone];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateTime = [formatter stringFromDate:date];
    
    return dateTime;
}
//获取当前时间
+ (NSTimeInterval)cpx_getCurrentTimeValue {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSTimeInterval currentTime = [now timeIntervalSince1970];
    
    return currentTime;
    
}


//获取当前时间
+(NSString *)cpx_getCureentTimeWithFormatter:(timeStampType)timeStampType{
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
//
//    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if(timeStampType == timeStampTypeYMDHMS){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (timeStampType == timeStampTypeYMD){
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }else if (timeStampType == timeStampTypeHMS){
        [formatter setDateFormat:@"HH:mm:ss"];
    }
    
    [formatter setTimeZone:zone];
    
    [formatter setDateStyle:NSDateFormatterFullStyle];
        
    NSString *dateTime = [formatter stringFromDate:date];
    
    return dateTime;
}

@end
