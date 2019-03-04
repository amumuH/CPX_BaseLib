//
//  commonUtls.h
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN



typedef NS_ENUM(NSUInteger, PhotoImagePickerStyle) {
    /// 展示底部选择试图（选择是照相还是选择相册）
      ShowChooseViewStyle,
    ///直接照相
     TakePhotoStyle,
    /// 直接进入相册
    ChooseFromAblumStyle,

};


/**
 公用的一些工具
 */
@interface CommonUtls : NSObject

/**
 调起相册或相机进行图片选择
参考链接：https://github.com/longitachi/ZLPhotoBrowser
 @param number 图片选择的张数
 @param selectImageBlock 图片选择成功的回调
 */
+(void)presentImagePickControllerWithImageNumber:(NSInteger)number type:(PhotoImagePickerStyle)style complet:(void (^)(NSArray<UIImage *> *__nullable imagesArray))selectImageBlock;

/**
 图片浏览器（可选择样式）
参考链接：https://github.com/CoderXLLau/XLPhotoBrowser
 @param imageArray 图片数组(数组里面可以是url字符串，NSurl对象，image对象、)
 @param index 当前页数
 */
+(void)showPhotoBrowserWithImages:(NSArray *)imageArray
                currentImageIndex:(NSInteger)index;



/**
 获取的当前显示的控制器
  */
+ (UIViewController *)cpx_getCurrentDisplayController;
+ (UIViewController *)cpx_getParentControllerFromView:(UIView *)view;


/**
 获取当前TabBarController
 */
+(UITabBarController *)currentTtabarController;

/**
 获取当前TabBarController持有的NavigationController
 */
+(UINavigationController *)currentTabbarSelectedNavigationController;

/**
 获取当前导航栏持有的控制器
 */
+(UIViewController*)getCurrentViewController;


/**
 快速创建model属性（快速创建网络请求返回的字典的属性）

 @param dict 网络请求返回的字典
 */
+(void)createModelWithDictionary:(NSDictionary *)dict;


/**
 获取当前app版本号

 */
+(NSString *)getcCurrentAppVersion;


/**
 获取UUID
 */
+ (NSString *)getUUID;
/**
 当前国家代码

 */
+(NSString *)currentCountryCode;

/**
 设置状态栏颜色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
