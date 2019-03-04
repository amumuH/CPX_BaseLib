//
//  UIImage+Color.h
//  CPX
//
//  Created by CPX on 2017/5/16.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 color转image

 @param color color
 @return image对象
 */
+ (UIImage *)cpx_imageWithColor:(UIColor *)color;

/**
 image转color

 @param image image
 @param rect 设置的颜色的大小
 @return color
 */
+(UIColor *)cpx_imageTocolor:(UIImage *)image
                    withrect:(CGRect)rect;



/**
 调整图片方向
UIImagePickerController返回的照片带有方向信息，如果直接上传到服务器的话，可能造成旋转了90°（当手机竖直拍照）的情况。而且如果直接取其jpeg数据，或者将UIImage保存到本地的话，就会丢失这个方向信息，导致下一次读取出来图片就是颠倒的。
 @param aImage 传入的image
 @return 调整好的image
 */
+ (UIImage*)cpx_fixOrientation:(UIImage*)aImage;


/**
 图片无损压缩

 @param sourceImage 资源图片
 @param maxImageSize 最大分辨率
 @param maxSize 最大裁剪KB数
 @return  图片资源
 */
+ (NSData *)cpx_reSizeImageData:(UIImage *)sourceImage
                   maxImageSize:(CGFloat)maxImageSize
                  maxSizeWithKB:(CGFloat) maxSize;

/**
 *  压缩图片到指定文件大小(kb)
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
+(NSData *)cpx_compressOriginalImage:(UIImage *)image
                 toMaxDataSizeKBytes:(CGFloat)size;
/**
 将图片裁剪到制定像素
 
 @return 返回Imgae
 */

+ (UIImage*)cpx_imageByScalingAndCroppingForImage:(UIImage *)sourceImage
                                             Size:(CGSize)targetSize;

/**
 传入需要的占位图尺寸 获取占位图
 
 @param size 需要的站位图尺寸
 @return 占位图
 */
+ (UIImage *)cpx_placeholderImageWithSize:(CGSize)size;

+ (UIImage *)cpx_placeholderImageWithSize:(CGSize)size ImageSize:(CGSize )imageSize;
@end
