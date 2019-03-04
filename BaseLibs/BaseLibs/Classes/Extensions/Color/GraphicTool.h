//
//  GraphicTool.h
//  取颜色的hsl等
//
//  Created by cheng lixing on 12-5-21.
//  Copyright (c) 2012年 kugou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define OUT

typedef unsigned char       BYTE;
typedef unsigned short      WORD;

#define LOBYTE(w)           ((BYTE)(((unsigned long)(w)) & 0xff))

/*
 bgra a为低位  png颜色格式
 argb b为低位  运算使用的格式
 以下为运算格式
 */
#define GetAValue(rgb)      (LOBYTE((rgb)>>24))
#define GetRValue(rgb)      (LOBYTE(rgb))
#define GetGValue(rgb)      (LOBYTE(((WORD)(rgb)) >> 8))
#define GetBValue(rgb)      (LOBYTE((rgb)>>16))

/*
 png格式
 bgra a为低位  png颜色格式
 */
#define GetAValue_PNG(rgb)      (LOBYTE(rgb))
#define GetBValue_PNG(rgb)      (LOBYTE((rgb)>>24))
#define GetGValue_PNG(rgb)      (LOBYTE((rgb)>>16))
#define GetRValue_PNG(rgb)      (LOBYTE(((WORD)(rgb)) >> 8))


//#define RGB(r,g,b)          ((UInt32)(((BYTE)(r)|((WORD)((BYTE)(g))<<8))|(((unsigned long)(BYTE)(b))<<16)))
// 转为运算格式argb
#define RGB2BGR(rgb) ((GetAValue_PNG(rgb)<<24) | (GetRValue_PNG(rgb)<<16) | (GetGValue_PNG(rgb)<<8) | GetBValue_PNG(rgb))
// 转为png格式bgra
#define BGR2RGB(bgr) ((GetBValue(bgr)<<24) | (GetGValue(bgr)<<16) | (GetRValue(bgr)<<8) | GetAValue(bgr))

@interface GraphicTool : NSObject

+ (float) calPowl: (float)source;

+ (void) rgb2HSL: (UInt32)targetCorlor OUT retH: (float*)retH
        OUT retS: (float*)retS OUT retL: (float*)retL;

+ (UInt32) calMergeColor: (UInt32)sourceColor powl: (float)powl selectH: (float)selectH
                 selectS: (float)selectS selectL: (float)selectL;

////////////////////////以下为私有函数
+ (void) rgbf2HSL: (float)r g: (float)g b: (float)b OUT retH: (float*)retH
        OUT retS: (float*)retS OUT retL: (float*)retL;

+ (void) hsl2RGB: (float)hh ss: (float)ss ll: (float)ll a: (WORD)a OUT retColor: (UInt32*)retColor;
+ (void) hsl2RGBF: (float)hh ss: (float)ss ll: (float)ll a: (WORD)a OUT retR: (float*)retR
        OUT retG: (float*)retG OUT retB: (float*)retB;

@end
