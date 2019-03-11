//
//  commonUtls.m
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CommonUtls.h"
#import "NSDictionary+Basic.h"
@implementation CommonUtls


+(ZLPhotoActionSheet *)presentImagePickControllerWithImageNumber:(NSInteger)number type:(PhotoImagePickerStyle)style complet:(void (^)(NSArray<UIImage *> *__nullable imagesArray))selectImageBlock{
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //以下参数为自定义参数，均可不设置，有默认值
    //设置相册内部显示拍照按钮
    actionSheet.configuration.allowTakePhotoInLibrary = YES;
    //设置在内部拍照按钮上实时显示相机俘获画面
    actionSheet.configuration.showCaptureImageOnTakePhotoBtn = YES;
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = number;
    actionSheet.configuration.maxPreviewCount = 0;
    //设置照片cell弧度
    actionSheet.configuration.cellCornerRadio = 1;
    //单选模式是否显示选择按钮
    //    actionSheet.configuration.showSelectBtn = YES;
    //是否在选择图片后直接进入编辑界面
    actionSheet.configuration.editAfterSelectThumbnailImage = YES;
    //是否保存编辑后的图片
    actionSheet.configuration.saveNewImageAfterEdit = YES;
    //设置编辑比例
    //    actionSheet.configuration.clipRatios = @[GetClipRatio(7, 1)];
    //是否在已选择照片上显示遮罩层
    actionSheet.configuration.showSelectedMask = YES;
    //是否允许录制视频
    actionSheet.configuration.allowRecordVideo = NO;
    //颜色，状态栏样式
    //    actionSheet.configuration.selectedMaskColor = [UIColor purpleColor];
    //    actionSheet.configuration.navBarColor = [UIColor orangeColor];
    //    actionSheet.configuration.navTitleColor = [UIColor blackColor];
    //    actionSheet.configuration.bottomBtnsNormalTitleColor = kRGB(80, 160, 100);
    //    actionSheet.configuration.bottomBtnsDisableBgColor = kRGB(190, 30, 90);
    //    actionSheet.configuration.bottomViewBgColor = [UIColor blackColor];
    //    actionSheet.configuration.statusBarStyle = UIStatusBarStyleDefault;
    //是否允许框架解析图片
    actionSheet.configuration.shouldAnialysisAsset = YES;
    //框架语言

    //自定义多语言
    //    actionSheet.configuration.customLanguageKeyValue = @{@"ZLPhotoBrowserCameraText": @"没错，我就是一个相机"};
    //自定义图片
    //    actionSheet.configuration.customImageNames = @[@"zl_navBack"];
    
    //是否使用系统相机
    //    actionSheet.configuration.useSystemCamera = YES;
    //    actionSheet.configuration.sessionPreset = ZLCaptureSessionPreset1920x1080;
    //    actionSheet.configuration.exportVideoType = ZLExportVideoTypeMp4;
    //    actionSheet.configuration.allowRecordVideo = NO;
    //    actionSheet.configuration.maxVideoDuration = 5;
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = [self cpx_getCurrentDisplayController];
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        if (selectImageBlock) {
            selectImageBlock(images);
        }

    }];
    if (style == ShowChooseViewStyle) {
       // 显示ZLPhotoActionSheet选择照片视图
        [actionSheet showPreviewAnimated:YES];
    }else if (style == TakePhotoStyle){
        //直接开始照相
    }else if (style == ChooseFromAblumStyle){
        //直接进入相册
        [actionSheet showPhotoLibrary];

    }
    
 
    
    actionSheet.cancleBlock = ^{
        NSLog(@"取消选择图片");

    };
    return actionSheet;
}
//图片浏览器
+(void)showPhotoBrowserWithImages:(NSArray *)imageArray
                currentImageIndex:(NSInteger)index{
    if (imageArray.count==0) {
        return;
    }
//    // 1. 创建photoBroseView对象
//    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
//        // 2.1 设置图片源(UIImageView)数组
//    if ([imageArray[0] isKindOfClass:[UIImage class]]) {
//        photoBroseView.images = imageArray;//数组里面的是UIimage对象
//    }else if ([imageArray[0] isKindOfClass:[NSString class]]){
//        photoBroseView.imagesURL = imageArray;//数组里的是url字符串
//    }
//    
//    // 2.2 设置初始化图片下标（即当前点击第几张图片）
//    photoBroseView.currentIndex = index;
//    photoBroseView.hiddenDuration = 0;//隐藏时间
//    photoBroseView.showDuration = 0;//展示时间
//    // 3.显示(浏览)
//    [photoBroseView show];
}


+ (UIViewController *)cpx_getParentControllerFromView:(UIView *)view
{
    UIResponder *responder = [view nextResponder];
    while (responder)
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

+ (UIViewController *)cpx_getCurrentDisplayController {
    
    __block UIWindow *normalWindow = [[UIApplication sharedApplication] keyWindow];
    NSArray *windows = [[UIApplication sharedApplication] windows];
    if (normalWindow.windowLevel != UIWindowLevelNormal) {
        [windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.windowLevel == UIWindowLevelNormal) {
                normalWindow = obj;
                *stop        = YES;
            }
        }];
    }
    
    return [self cpx_getTopViewController:normalWindow.rootViewController];
}
+ (UIViewController *)cpx_getTopViewController:(UIViewController *)inViewController {
    while (inViewController.presentedViewController) {
        inViewController = inViewController.presentedViewController;
    }
    
    if ([inViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [self cpx_getTopViewController:((UITabBarController *)inViewController).selectedViewController];
        return selectedVC;
    } else if ([inViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *selectedVC = [self cpx_getTopViewController:((UINavigationController *)inViewController).visibleViewController];
        return selectedVC;
    } else {
        return inViewController;
    }
}

//获取当前控制器
+(UIViewController*)getCurrentViewController{
    UINavigationController *selectedNV = [self currentTabbarSelectedNavigationController];
    if (selectedNV.viewControllers.count > 0) {
        return [selectedNV.viewControllers lastObject];
    }
    return nil;
}
//获取当前导航栏
+(UINavigationController *)currentTabbarSelectedNavigationController
{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *rootVC = window.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootVC;
    }else if([rootVC isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabarController = [self currentTtabarController];
        UINavigationController *selectedNV = (UINavigationController *)tabarController.selectedViewController;
        if ([selectedNV isKindOfClass:[UINavigationController class]]) {
            return selectedNV;
        }
    }

    return nil;
}

//获取当前tabbar
+(UITabBarController *)currentTtabarController
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *tabbarController = window.rootViewController;
    if ([tabbarController isKindOfClass:[UITabBarController class]]) {
        return (UITabBarController *)tabbarController;
    }
    return nil;
}


//快速创建model属性
+(void)createModelWithDictionary:(NSDictionary *)dict
{
    dict = [NSDictionary cpx_safeDictionaryByObject:dict];//数组安全处理、防止传入类型不对引起崩溃
    if (dict.count == 0) {
        return;
    }
        for (NSString *key in dict) {
        NSString *type = ([dict[key] isKindOfClass:[NSNumber class]])?@"NSString":@"NSString";
        printf("@property (nonatomic,copy) %s *%s;\n",type.UTF8String,key.UTF8String);
    }
    printf("@end\n");
    
}

//获取当前app版本
+(NSString *)getcCurrentAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appCurVersionNum;
}
//获取UUID
+ (NSString *)getUUID {
    NSUUID *uuid = [UIDevice currentDevice].identifierForVendor;
    NSString *deviceUDID = [uuid UUIDString];
    return deviceUDID;
}
/**
 当前国家代码
 */

+ (NSString *)currentCountryCode{
    NSLocale *locale = [NSLocale currentLocale];
    if ([locale objectForKey:NSLocaleCountryCode]){
        NSString *countrycode = [locale objectForKey:NSLocaleCountryCode];
        return countrycode;
    }
    else{
        return  @"US";
    }
}


/**
 设置状态栏颜色
 */
+ (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
@end
