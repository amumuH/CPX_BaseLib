//
//  HJCornerRadius.h
//  HJImageViewDemo
//
//  Created by haijiao on 16/3/10.
//  Copyright © 2016年 olinone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HJCornerRadius)

/**
高效设置imageView的圆角，避免maskTobounds
 */

@property (nonatomic, assign) CGFloat aliCornerRadius;

@end
