//
//  CPXBaseView.m
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXBaseView.h"
#import "CPXBaseViewController.h"
@implementation CPXBaseView



-(void)dealloc
{
    NSLog(@"%@视图------已被释放",NSStringFromClass([self class]));
}

#pragma mark - 获取父控制器的方法
-(CPXBaseViewController*)getViewcontrollerView{
 
    return (CPXBaseViewController*)[self cpx_getSuperControllerOfTheView];

}

@end
