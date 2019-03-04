//
//  UIView+Storyboard.h
//  CPX
//
//  Created by Apple on 2017/6/12.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Storyboard)
//*************************给xib和SB增加额外的属性**********************//
@property (nonatomic) IBInspectable UIColor *borderColor;//边界颜色
@property (nonatomic) IBInspectable CGFloat borderWidth;//边界宽度
@property (nonatomic) IBInspectable CGFloat cornerRadius;//圆角

@end
