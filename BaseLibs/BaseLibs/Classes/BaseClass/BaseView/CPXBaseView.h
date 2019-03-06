//
//  CPXBaseView.h
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPXBaseViewController;
NS_ASSUME_NONNULL_BEGIN

@interface CPXBaseView : UIView


/**
 获取当前的父控制器

 @return 父控制器
 */
-(CPXBaseViewController*)getViewcontrollerView;


@end

NS_ASSUME_NONNULL_END
