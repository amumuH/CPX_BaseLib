//
//  NSString+timer.h
//  HMFoundationWork
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 amumu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    timeStampTypeYMDHMS  = 0,   //年月日时分秒
    timeStampTypeYMD,           //年月日
    timeStampTypeHMS,            //时分秒
    timeStampTypeHM    //时
} timeStampType;


@interface NSString (timer)
/**
 时间戳转时间
 @param timeString 需要转换的时间戳
 @return 转换成时间格式 yyyy-MM-dd HH:mm
 */
+ (NSString *)cpx_timeWithTimeIntervalString:(NSString *)timeString;

/**
 时间戳转时间(自定义样式)
 
 @param timeStampStr 时间戳字符串
 @param timeStampType 需要转换的时间格式
 @return 时间字符串
 */
+ (NSString *)cpx_getTimeWithTimeIntervalStr:(NSString *)timeStampStr
                               timeStampType:(timeStampType)timeStampType;


/**
 当前日期转时间戳（日期NSDate 转 时间戳NSString）
 */
+ (NSString *)cpx_timeToTurnTheTimestamp;

/**
 获取当前时间字符串

 @return yyyy-MM-dd HH:mm:ss 格式的时间字符串
 */
+(NSString *)cpx_getCureentTime;

+ (NSTimeInterval)cpx_getCurrentTimeValue;

/**
 获取当前时间字符串（需传入时间样式）


 @param timeStampType 时间样式
 @return 当前时间字符串
 */
+(NSString *)cpx_getCureentTimeWithFormatter:(timeStampType)timeStampType;


/**
 日期字符串转时间戳（NSString转时间戳NSString）
 */
+(NSString *)cpx_turnTheTimestampString:(NSString*) timeStr;




/**
 计算两个日期的相差月数，并返回中间间隔的月份
 
 @param fromDate 开始时间
 */
+(NSMutableArray *)cpx_caculateDiffreceMonthFromDate:(NSString *)fromDate;
/**
 获取昨天的日期
 @return 返回日期字符串
 */
+(NSString *)cpx_getYestodayDate;

//将时间(s)转换成时间戳(MM:ss)
+(NSString *)cpx_timeStrChangeWithTime:(NSInteger)timeNum;



@end
