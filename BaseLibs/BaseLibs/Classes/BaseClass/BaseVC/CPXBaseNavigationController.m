//
//  CPXBaseNavigationController.m
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXBaseNavigationController.h"

@interface CPXBaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>


@end

@implementation CPXBaseNavigationController
//处理app可能出现假死的情况

-(void)dealloc
{
    self.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (id)self;
    //导航栏字体
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:kNaviBarTitleColor,NSFontAttributeName:kNaviBarTitleFont}];
    //导航栏背景图
    self.navigationBar.shadowImage = [UIImage new];
    UIImage  * bg_corner_navi =[[UIImage imageNamed:@"bg_navibar_bottom_corner"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 30, 30) resizingMode:UIImageResizingModeStretch];
    [self.navigationBar setBackgroundImage:bg_corner_navi forBarMetrics:UIBarMetricsDefault];
    
    
    __weak typeof (self)weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  
    
    
    return [super popViewControllerAnimated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //pushj跳转（隐藏首冲view）
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushViewController" object:nil];
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{    [self.navigationBar endEditing:YES];
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationBar endEditing:YES];
    
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (self.viewControllers.count <= 1){
        //(显示首冲view)
        [[NSNotificationCenter defaultCenter]postNotificationName:@"popViewControllerDismiss" object:nil];
    }
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        [self.navigationBar endEditing:YES];
        
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }
    
    return YES;
}

@end
