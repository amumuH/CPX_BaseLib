//
//  ColorEx.h
//  扩展颜色的功能
//  将＃ffffff  or  oxfffffff转化为UIColor
//  将UIColor转为字符串
//  ...
//
//  Created by kugou on 2011/10/15.
//  Copyright 2011年 Kugou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (ColorEx)
///******************颜色与16进制RGB的转化*******************//

- (NSString *) stringFromColor;  
// stringToConvert格式为(r,g,b,a)
+ (UIColor *) colorWithString: (NSString *) stringToConvert;  

- (NSString *) hexStringFromColor;  

// 由外界释放返回的color
+ (UIColor *) colorWithHexStringBeta: (NSString *) stringToConvert;


+ (UInt32) RGBWithString: (NSString *) stringToRGB;


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
