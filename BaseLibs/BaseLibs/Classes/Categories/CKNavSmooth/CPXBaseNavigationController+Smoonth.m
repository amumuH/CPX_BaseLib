//
//  HMNavigationController+Smoonth.m
//  HMFoundationWork
//
//  Created by Apple on 2017/11/24.
//  Copyright © 2017年 amumu. All rights reserved.
//
#import "CPXBaseNavigationController+Smoonth.h"
#import <objc/runtime.h>
@interface CPXBaseNavigationController()<UINavigationBarDelegate>

@end
@implementation CPXBaseNavigationController (Smoonth)
+ (void)initialize
{
    if (self == [CPXBaseNavigationController self]) {
        NSArray *arr = @[@"_updateInteractiveTransition:",@"popToViewController:animated:",@"popToRootViewControllerAnimated:"];
        for (NSString *str in arr) {
            NSString *new_str = [[@"et_" stringByAppendingString:str] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method A = class_getInstanceMethod(self, NSSelectorFromString(str));
            Method B = class_getInstanceMethod(self, NSSelectorFromString(new_str));
            method_exchangeImplementations(A, B);
        }
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.topViewController.preferredStatusBarStyle) {
        return self.topViewController.preferredStatusBarStyle;
    }
    return UIStatusBarStyleDefault;
}

#pragma mark 交换的方法
- (void)et_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *topVC = self.topViewController;
    if ([topVC isKindOfClass:[CPXBaseViewController class]]) {
        id <UIViewControllerTransitionCoordinator> transitionContext = topVC.transitionCoordinator;
        UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        CGFloat fromAlpha = fromVc.navBarBgAlpha;
        CGFloat toAlpha = toVc.navBarBgAlpha;
        CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha)*percentComplete;
        
        dispatch_async(dispatch_get_main_queue(),^{
            [self setNeedsNavigationBackgroundAlpha:newAlpha];
            
        });
        
        [self et_updateInteractiveTransition:percentComplete];
        
    }
    
}

- (NSArray<UIViewController *> *)et_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(),^{
        [self setNeedsNavigationBackgroundAlpha:viewController.navBarBgAlpha];
        
    });
    return [self et_popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)et_popToRootViewControllerAnimated:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(),^{
        [self setNeedsNavigationBackgroundAlpha:self.viewControllers[0].navBarBgAlpha];
        //        self.navigationBar.tintColor = self.viewControllers[0].navBarTintColor;
    });
    
    return [self et_popToRootViewControllerAnimated:animated];
}

#pragma mark 代理
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *topVc = self.topViewController;
    id<UIViewControllerTransitionCoordinator> coor = topVc.transitionCoordinator;
    if (topVc && coor && coor.initiallyInteractive) {
        if (@available(iOS 10.0, *)) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                [self dealInteractionChanges:context];
            }];
        }
        else{
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealInteractionChanges:context];
                }];
            } else {
                // Fallback on earlier versions
            }
        }
        return  YES;
    }
    
    int n = self.viewControllers.count >= navigationBar.items.count ? 2 : 1;
    UIViewController *popToVc = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVc animated:YES];
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item
{
    dispatch_async(dispatch_get_main_queue(),^{
        [self setNeedsNavigationBackgroundAlpha:self.topViewController.navBarBgAlpha];
        //        self.navigationBar.tintColor = self.topViewController.navBarTintColor;
    });
    
    return YES;
}

- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations)(NSString *key) = ^(NSString *key){
        CGFloat nowAlpha = [context viewControllerForKey:key].navBarBgAlpha;
        dispatch_async(dispatch_get_main_queue(),^{
            [self setNeedsNavigationBackgroundAlpha:nowAlpha];
        });
        
    };
    
    if (context.isCancelled) {
        NSTimeInterval cancaleDuration = context.transitionDuration * context.percentComplete;
        [UIView animateWithDuration:cancaleDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }
    else{
        NSTimeInterval finishDuration = context.transitionDuration * (1 - context.percentComplete);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}


#pragma mark 私有方法
- (UIColor *)averageColorFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat nowRed = fromRed + (toRed - fromRed) * percent;
    CGFloat nowGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat nowBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    
    return [UIColor colorWithRed:nowRed green:nowGreen blue:nowBlue alpha:nowAlpha];
    
}

- (void)setNeedsNavigationBackgroundAlpha:(CGFloat)alpha
{
    //导航栏透明层
    UIView *barBackgroundView;
    if ([self.navigationBar subviews].count>0) {
        barBackgroundView  = [[self.navigationBar subviews] objectAtIndex:0];
    }
    UIView *shadowView = [barBackgroundView valueForKey:@"_shadowView"];
    if (shadowView) {
         shadowView.alpha = alpha;
//        shadowView.alpha = 0; //导航栏下面的分割线透明度
    }
    
    if (!self.navigationBar.isTranslucent) {
        barBackgroundView.alpha = alpha;
        return;
    }
    
    if (iOS10_Beyond) {
        UIView *backgroundEffectView = [barBackgroundView valueForKey:@"_backgroundEffectView"];
        if (backgroundEffectView != nil && [self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault] == nil) {
            backgroundEffectView.alpha = alpha;
        }
    }
    else{
        UIView *daptiveBackdrop = [barBackgroundView valueForKey:@"_adaptiveBackdrop"];
        UIView *backdropEffectView = [daptiveBackdrop valueForKey:@"_backdropEffectView"];
        if (daptiveBackdrop != nil && backdropEffectView != nil ) {
            daptiveBackdrop.alpha = alpha;
        }
    }
}



@end
@implementation UIViewController (Smooth)


- (void)setNavBarBgAlpha:(CGFloat)navBarBgAlpha
{
    objc_setAssociatedObject(self, @selector(navBarBgAlpha), @(navBarBgAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    dispatch_async(dispatch_get_main_queue(),^{
        [(CPXBaseNavigationController*)self.navigationController setNeedsNavigationBackgroundAlpha:navBarBgAlpha];
    });
    
}

- (CGFloat)navBarBgAlpha
{
    CGFloat alpha = [objc_getAssociatedObject(self, @selector(navBarBgAlpha)) floatValue];
    return alpha;
}

- (void)setNavBarTintColor:(UIColor *)navBarTintColor
{
    //    navbar背景色
    [self.navigationController.navigationBar setBarTintColor:navBarTintColor];
    objc_setAssociatedObject(self, @selector(navBarTintColor), navBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)navBarTintColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(navBarTintColor));
    return color ? color : [UIColor whiteColor];
}
@end
