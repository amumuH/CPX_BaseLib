//
//  UIBarButtonItem+SXCreate.h
//  UINavigation-SXFixSpace
//
//  Created by charles on 2017/9/8.
//  Copyright © 2017年 None. All rights reserved.
//

#import <UIKit/UIKit.h>

///************************处理自定义导航栏按钮带来的偏移以及点击范围等问题*********************//

@interface UIBarButtonItem (SXCreate)

/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(UIImage *)image;
/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(UIImage *)image
                       imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 根据图片生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param nomalImage nomalImage
 @param higeLightedImage higeLightedImage
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;



/**
 图片与文字
 @param target target对象
 @param action 响应方法
 @param Image image
 @param title title
 @param font font
 @param style / Organization 布局方式
 @param space 间隔
 @param titleColor 颜色
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 Image:(UIImage *)Image
                                 title:(NSString *)title
                                  font:(UIFont *)font
                           layoutStyle:(MKButtonEdgeInsetsStyle)style
                       imageTitleSpace:(CGFloat)space
                            titleColor:(UIColor *)titleColor;

/**
 根据文字生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title title
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title title
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                                action:(SEL)action
                                 title:(NSString *)title
                       titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

/**
 根据文字生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title title
 @param font font
 @param titleColor 字体颜色
 @param highlightedColor 高亮颜色
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)cpx_itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;


/**
 用作修正UIBarButtonItem的位置

 @param width 修正宽度
 @return 修正位置的UIBarButtonItem
 */
+(UIBarButtonItem *)cpx_fixedSpaceWithWidth:(CGFloat)width;

@end
