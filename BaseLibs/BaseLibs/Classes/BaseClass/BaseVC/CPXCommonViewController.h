//
//  CPXCommonViewController.h
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/***********************************************************
       规定最底层的一些公用方法，以及对公用导航栏和返回按钮的设置  
***********************************************************/

@interface CPXCommonViewController : UIViewController
/**
 状态栏是否高亮
 */
@property (nonatomic) BOOL statusBarIsLight;

/**
 UI初始
 */
- (void)initUI;

/**
 初始化数据源
 */
-(void)initDataSource;
/**
 加载数据
 */
- (void)loadData;


/**
 初始化方法第二级，默认放在initUI下
 */


/**
 初始化View
 */
- (void)initViews;

/**
 初始化导航
 */
//- (void)initNavigation;

/**
 初始化其他View
 */
- (void)initOtherViews;


/**
 默认导航栏初始化
 */
//- (void)initDefaultNavigation;

/**
 初始化导航返回按钮
 */
//- (void)initLeftBackNaviButton;


/**
 导航栏返回按钮的点击事件
 */
-(void)defaultNavBackItemAction;



@end

NS_ASSUME_NONNULL_END
