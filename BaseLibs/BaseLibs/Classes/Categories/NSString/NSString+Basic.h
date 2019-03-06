//
//  NSString+categories.h
//  CPX
//
//  Created by CPX on 2017/5/22.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 *时间戳 转时间
 */


@interface NSString (Basic)



/*
 *不安全的字符串转换为安全字符串
 */
+(NSString*)cpx_safetyStringByObject:(id)unsafeObj;






//获取字符串的宽高

/**
 获取字符串的size

 */
- (CGSize)cpx_sizeWithFont:(UIFont *)font
                   maxSize:(CGSize)maxSize;

- (CGSize)cpx_sizeWithFontSize:(CGFloat )fontSize
                       maxSize:(CGSize)maxSize;

/**
 字典转字json符串

 */
+ (NSString*)cpx_stringWithJsonDictionary:(NSDictionary *)dic;


/**
 数组转json字符串

 */
+ (NSString *)cpx_StringWithArray:(NSArray *)array;


/**
 json字符串转数组

 */
+ (NSDictionary *)cpx_dictionaryWithJsonString:(NSString *)jsonString;


/**
 json字符串转数组

 */
+ (NSArray*)cpx_arrayWithJsonString:(NSString*)jsonString;

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)cpx_pinyin;


/**
 生成带有下划线的富文本
 
 @return 富文本
 */
-(NSAttributedString*)cpx_underLineStyleSingle;

/**
 生成带有中划线的富文本

 @return 富文本
 */
-(NSMutableAttributedString*)cpx_centerLineStyleSingle;


/**
 美国千分位数字
 
 @param number nsnumber
 */
+(NSString * )cpx_americaMoneyFormatter:(NSNumber * )number;

/**
 图片urlEncode
 
 @param url_origin 原始url 连接
 */
+(NSString *)cpx_urlEncode:(NSString * )url_origin;

@end
