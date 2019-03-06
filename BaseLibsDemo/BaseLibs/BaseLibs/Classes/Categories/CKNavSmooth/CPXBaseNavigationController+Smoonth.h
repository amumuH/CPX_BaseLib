//
//  HMNavigationController+Smoonth.h
//  HMFoundationWork
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 amumu. All rights reserved.
//

#import "CPXBaseNavigationController.h"
#import "CPXBaseViewController.h"
////******************平滑处理导航栏侧滑渐变效果*****************************//

@interface CPXBaseNavigationController (Smoonth)

@end
@interface UIViewController (Smoonth)

@property (nonatomic, assign) CGFloat navBarBgAlpha;//设置导航栏透明度

@property (nonatomic, strong) UIColor *navBarTintColor;//导航栏背景色
@end
