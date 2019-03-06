//
//  UIView+tool.h
//  HMFoundationWork
//
//  Created by wx on 2018/7/5.
//  Copyright © 2018年 amumu. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 渐变色方向
 
 - GradientDirectionHorizontal: 水品方向
 - GradientDirectionVertical: 垂直方向
 */
typedef NS_ENUM(NSInteger,GradientDirection) {
    GradientDirectionHorizontal = 0,
    GradientDirectionVertical
    
    
};
@interface UIView (Basic)


/**
 截屏
 */
-(UIImage *)cpx_screenShotViewWith:(CGRect)rect;


/**
 判断view是否在屏幕上

 */
- (BOOL)cpx_isDisplayedInScreen;

/**
 添加贝塞尔圆角--自动布局必须完成布局才能调用
 
 @param corner UIRectCornerTopRight | UIRectCornerTopLeft
 @param cornerRadis 圆角度
 */
-(void)cpx_addPathCorner:(UIRectCorner)corner cornerRadis:(CGFloat)cornerRadis;

/**
 普通方式切圆角
  */
-(void)cpx_setCorner:(CGFloat)cornerRadis;

/**
 设置一个四角圆角
 
 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角
 
 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角
 
 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)cpx_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
/**
 添加渐变色 --- 添加backgourdcolor的形式
 
 @param color_begin 开始颜色
 @param color_end 终点颜色
 @param direction 渐变方向
 */
-(void)cpx_addGradientColorWithColor_begin:(UIColor * )color_begin
                              colorEnd:(UIColor * )color_end
                     gradientDirection:(GradientDirection)direction;

@end

@interface CALayer (cpxAddForRoundedCorner)

@property (nonatomic, strong) UIImage *contentImage;//contents的便捷设置

/**如下分别对应UIView的相应API*/

- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)cpx_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;




@end

