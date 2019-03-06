//
//  UILabel+init.m
//  BaseLib
//
//  Created by CPX on 2018/11/28.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import "UILabel+init.h"

@implementation UILabel (init)

+(UILabel *)cpx_LabelWithText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label =[[UILabel alloc]init];
    label.textAlignment = textAlignment;
    label.text = text;
    label.backgroundColor = backgroundColor;
    label.frame= frame;
    label.font = font;
    label.textColor = textColor;
    return label;
}

+(UILabel *)cpx_LabelWithTextNoFrameText:(NSString *)text textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label =[[UILabel alloc]init];
    label.textAlignment = textAlignment;
    label.text = text;
    label.backgroundColor = backgroundColor;
    label.font = font;
    label.textColor = textColor;
    return label;
}

+(UILabel *)cpx_LabelWithTextNoFrameText:(NSString *)text backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label =[[UILabel alloc]init];
    label.textAlignment = textAlignment;
    label.text = text;
    label.backgroundColor = backgroundColor;
    label.textColor = textColor;
    label.font = font;
    return label;
}


@end
