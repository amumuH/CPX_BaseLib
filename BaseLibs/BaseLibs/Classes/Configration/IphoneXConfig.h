//
//  IphoneXConfig.h
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

#ifndef IphoneXConfig_h
#define IphoneXConfig_h
///*******************************IphoneX适配*****************************//

// 判断 iPhone X
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// Status bar height.
#define  kStatusBarHeight      (iPhoneX ? 44.f : 20.f)
#define  kStatusHeight      (iPhoneX ? 24.f : 0.f)
// Navigation bar height.
#define  kNavBarHeight  44.f
// Tabbar height.
#define  kTabbarHeight         (iPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  lTabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  kNavigation_height  (iPhoneX ? 88.f : 64.f)
#endif /* IphoneXConfig_h */
