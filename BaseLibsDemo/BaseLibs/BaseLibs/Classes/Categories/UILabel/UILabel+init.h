//
//  UILabel+init.h
//  BaseLib
//
//  Created by CPX on 2018/11/28.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (init)

/**
 创建Label
 
 @param text 文本
 @param textColor 字体颜色
 @param backgroundColor Label背景颜色
 @param frame label frame
 @param font 字体大小
 @param textAlignment 字体排列位置 中间 左边 右边
 @return label
 */
+(UILabel *)cpx_LabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/**
 创建Label
 
 @param text 文本
 @param textColor 字体颜色
 @param backgroundColor Label背景颜色
 @param font 字体大小
 @param textAlignment 字体排列位置 中间 左边 右边
 @return label
 */
+(UILabel *)cpx_LabelWithTextNoFrameText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

/**
 创建Label 无frame
 
 @param text 文本
 @param backgroundColor Label背景颜色
 @param font 字体大小
 @param textAlignment 字体排列位置 中间 左边 右边
 @return label
 */
+(UILabel *)cpx_LabelWithTextNoFrameText:(NSString *)text backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
