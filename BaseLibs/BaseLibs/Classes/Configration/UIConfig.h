//
//  UIConfig.h
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

///*******************************全局UI配置*****************************//

#ifndef UIConfig_h
#define UIConfig_h

//********************    颜色设置    ************************//
#define RGBAlpha(A,B,C,a) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:a]
#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
#define HEX(A)     [UIColor colorWithHexString:A]

//********************   app view通用背景颜色   *******************//
#define kAppBackGroundColor  HEX(@"#f4f4f4")

//********************   navigationBar颜色   ****************//
#define kNavBarColor HEX(@"#FFDB56")

//************************  APP主题色   ***********************//
#define kMainStyleColor HEX(@"#24b88c")

//**********************  navbar返回按钮 以及文字颜色  ********************//
#define kNaviBarBackItemColor [UIColor blackColor]

//**********************  navbar tittle 字体 以及颜色  *********************//
#define kNaviBarTitleColor [UIColor blackColor]

//**********************   navbar 字体   **********************************//
#define kNaviBarTitleFont [UIFont boldSystemFontOfSize:18]

//**********************  tabBarItem 点击以前的文字颜色 **********************//
#define kTabBarItemTextColorNormal RGB(155, 157, 176)
//**********************     tabBarItem 点击之后文字颜色   **********************//
#define kTabBarItemTextColorSelected RGB(38, 184, 242)

//**********************    主调色   ********************** //
#define kMainColor HEX(@"27C0DC")

//**********************    设置字体  ********************** //
#define Font(A) [UIFont systemFontOfSize:A]

//**********************    屏幕适配    *************************//
// UIScreen width.
#define  kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight  [UIScreen mainScreen].bounds.size.height

//**********************    按屏幕比例缩放    *************************//

#define AUTO_HEIGTH_BASE_IPHONE_5(x) ((kScreenWidth/320.0) * (x))
#define AUTO_HEIGTH_BASE_IPHONE_6(x) ((kScreenWidth/375.0) * (x))
#define ROOTVC [UIApplication sharedApplication].keyWindow



#define UINAVI_COLOR                    HEX(@"#FFDB56")
#define UIMAINNAVI_COLOR                HEX(@"#FFDB56")
#define UIMAIN_VIEW_COLOR               HEX(@"#F4F4F4")

#define NAVIITEM_COLOR                  HEX(@"#666666")
#define CATEGORY_COLOR_UNSELECTED       HEX(@"#666666")
#define CATEGORY_COLOR_SELECTED         HEX(@"#333333")
#define BARCODE_NUMBER_COLOR            HEX(@"#000000")
#define MAIN_TITLE_COLOR                HEX(@"#333333")
#define SUB_TITLE_COLOR                 HEX(@"#666666")
#define CELLTITLE_COLOR                 HEX(@"#999999")

#define Button_Border_Color             HEX(@"#fe523a")
#define BUTTON_BACKGROUND_COLOR         HEX(@"#9E64F9")

/**
 黑色边框颜色
 */
#define Border_Black_Color        UIColorFromRGBWithAlpha(0x291500, 1.0)
#define MAIN_VIEW_BACKGROUNDCOLOR UIColorFromRGBWithAlpha(0xEFF0F1, 1.0)
#define SINGLE_LINE_COLOR         UIColorFromRGBWithAlpha(0xcccccc, 1.0)
#define MAIN_TEXT_COLOR           UIColorFromRGBWithAlpha(0x3d4244, 1)

#define UI_IS_IPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4           (kScreenHeight < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && kScreenHeight == 568.0 && kScreenWidth == 320.0)
#define IS_IPHONE_6 (IS_IPHONE && kScreenHeight == 667.0 && kScreenWidth == 375.0)
#define IS_IPHONE_6P (IS_IPHONE && kScreenHeight == 736.0 && kScreenWidth == 414.0)

#endif /* UIConfig_h */
