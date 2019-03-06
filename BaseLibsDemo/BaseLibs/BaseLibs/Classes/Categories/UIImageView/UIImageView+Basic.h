//
//  UIImageView+ZCImageView.h
//  CPX
//
//  Created by Apple on 2017/7/12.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**此次封装的功能主要便于方便图片加载*/

@interface UIImageView (Basic)

/**
 *  异步加载图片(默认占位图)
 *
 *  @param urlStr    图片地址
 */
- (void)cpx_downloadImage:(NSString *)urlStr;

/**
 *  异步加载图片（手动设置占位图）
 *
 *  @param urlStr    图片地址
 *  @param imageName 占位图片名字
 */
- (void)cpx_downloadImage:(NSString *)urlStr placeholder:(NSString *)imageName;
- (void)cpx_downloadImage:(NSString *)urlStr placeholderImage:(UIImage *)image;


/**
  *  异步加载图片

 @param urlStr 图片链接
 @param imageSize 占位图大小
 */
-(void)cpx_downloadImage:(NSString *)urlStr placeholderSize:(CGSize)imageSize;

@end
