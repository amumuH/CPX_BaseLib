//
//  UIView+tool.m
//  HMFoundationWork
//
//  Created by wx on 2018/7/5.
//  Copyright © 2018年 amumu. All rights reserved.
//

#import "UIView+Basic.h"
#import <objc/runtime.h>
@implementation UIView (Basic)

-(UIImage *)cpx_screenShotViewWith:(CGRect)rect{
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 判断View是否显示在屏幕上
- (BOOL)cpx_isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}



-(void)cpx_addPathCorner:(UIRectCorner)corner
             cornerRadis:(CGFloat)cornerRadis{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadis, cornerRadis)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
-(void)cpx_setCorner:(CGFloat)cornerRadis{
    self.layer.cornerRadius = cornerRadis;
    self.layer.masksToBounds = YES;
}

- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self.layer cpx_roundedCornerWithRadius:radius cornerColor:color];
}

- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self.layer cpx_roundedCornerWithRadius:radius cornerColor:color corners:corners];
}

- (void)cpx_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self.layer cpx_roundedCornerWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}


//渐变色
-(void)cpx_addGradientColorWithColor_begin:(UIColor * )color_begin
                                  colorEnd:(UIColor * )color_end
                         gradientDirection:(GradientDirection)direction{
    
    CGPoint startPoint,endPoint;
    if (direction == GradientDirectionHorizontal){
        startPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(1, 0);
    }
    else{
        startPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(0, 1);
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)color_begin.CGColor, (__bridge id)color_end.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.frame;
    //    [self.layer addSublayer:gradientLayer];
    
    //Convert our CALayer to a UIImage object
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIColor * backGroundColor = [UIColor colorWithPatternImage:backgroundColorImage];;
    self.backgroundColor = backGroundColor;
    
    
    
    
    
    
}


@end

@implementation NSObject (_cpxAdd)

+ (void)cpx_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)cpx_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cpx_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)cpx_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation UIImage (cpxAddForRoundedCorner)

+ (UIImage *)cpx_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)cpx_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage cpx_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}


@end



static void *const _cpxMaskCornerRadiusLayerKey = "_cpxMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;

@implementation CALayer (cpxAddForRoundedCorner)

+ (void)load{
    [CALayer cpx_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_cpx_layoutSublayers)];
}

- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage{
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self cpx_roundedCornerWithRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)cpx_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self cpx_roundedCornerWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)cpx_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    if (!color) return;
    CALayer *cornerRadiusLayer = [self cpx_getAssociatedValueForKey:_cpxMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self cpx_setAssociateValue:cornerRadiusLayer withKey:_cpxMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer cpx_setAssociateValue:color withKey:"_cpx_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer cpx_removeAssociateWithKey:"_cpx_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer cpx_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_cpx_cornerRadiusImageRadius"];
    [cornerRadiusLayer cpx_setAssociateValue:@(corners) withKey:"_cpx_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer cpx_setAssociateValue:borderColor withKey:"_cpx_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer cpx_removeAssociateWithKey:"_cpx_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer cpx_setAssociateValue:@(borderWidth) withKey:"_cpx_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _cpx_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)_cpx_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self cpx_getAssociatedValueForKey:_cpxMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj cpx_getAssociatedValueForKey:"_cpx_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage cpx_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image cpx_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_cpx_cornerRadiusImageSize"];
        [image cpx_setAssociateValue:color withKey:"_cpx_cornerRadiusImageColor"];
        [image cpx_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_cpx_cornerRadiusImageRadius"];
        [image cpx_setAssociateValue:@(corners) withKey:"_cpx_cornerRadiusImageCorners"];
        if (borderColor) {
            [image cpx_setAssociateValue:color withKey:"_cpx_cornerRadiusImageBorderColor"];
        }
        [image cpx_setAssociateValue:@(borderWidth) withKey:"_cpx_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)_cpx_layoutSublayers{
    [self _cpx_layoutSublayers];
    CALayer *cornerRadiusLayer = [self cpx_getAssociatedValueForKey:_cpxMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _cpx_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}


@end

