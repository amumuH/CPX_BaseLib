//
//  UIBarButtonItem+SXCreate.m
//  UINavigation-SXFixSpace
//
//  Created by charles on 2017/9/8.
//  Copyright © 2017年 None. All rights reserved.
//

#import "UIBarButtonItem+SXCreate.h"

@implementation UIBarButtonItem (SXCreate)

+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(UIImage *)image {
    return [self cpx_itemWithTarget:target action:action nomalImage:image higeLightedImage:nil imageEdgeInsets:UIEdgeInsetsZero];
}

+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(UIImage *)image
                       imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    return [self cpx_itemWithTarget:target action:action nomalImage:image higeLightedImage:nil imageEdgeInsets:imageEdgeInsets];
}

+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[nomalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    if (higeLightedImage) {
        [button setImage:higeLightedImage forState:UIControlStateHighlighted];
    }
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 ;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
    if (button.bounds.size.height > 40) {
        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
        button.bounds = CGRectMake(0, 0, 40, height);
    }
    button.imageEdgeInsets = imageEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                Image:(UIImage *)Image
                                title:(NSString *)title
                                  font:(UIFont *)font
                           layoutStyle:(MKButtonEdgeInsetsStyle)style
                       imageTitleSpace:(CGFloat)space
                            titleColor:(UIColor *)titleColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font?font:nil;
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:Image forState:UIControlStateNormal];
    [button sizeToFit];
    [button cpx_layoutButtonWithEdgeInsetsStyle:style imageTitleSpace:space];

//    if (button.bounds.size.width < 40) {
//        CGFloat width = 40 ;
//        button.bounds = CGRectMake(0, 0, width, 40);
//    }
//    if (button.bounds.size.height > 40) {
//        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
//        button.bounds = CGRectMake(0, 0, 40, height+space);
//    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
}



+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 title:(NSString *)title {
    return [self cpx_itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:UIEdgeInsetsZero];
}

+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 title:(NSString *)title
                       titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    return [self cpx_itemWithTarget:target action:action title:title font:nil titleColor:nil highlightedColor:nil titleEdgeInsets:titleEdgeInsets];
}

+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font?font:[UIFont systemFontOfSize:14];
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor?highlightedColor:nil forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    if (button.bounds.size.width < 40) {
        CGFloat width = 40 ;
        button.bounds = CGRectMake(0, 0, width, 40);
    }
//    if (button.bounds.size.height > 40) {
//        CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
//        button.bounds = CGRectMake(0, 0, 40, height);
//    }
    button.titleEdgeInsets = titleEdgeInsets;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)cpx_fixedSpaceWithWidth:(CGFloat)width {
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
