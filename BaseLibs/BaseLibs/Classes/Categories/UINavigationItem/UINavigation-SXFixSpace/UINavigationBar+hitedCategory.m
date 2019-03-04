//
//  UINavigationBar+category.m
//  zclife4.0
//
//  Created by zcsh on 2017/8/16.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import "UINavigationBar+hitedCategory.h"

@implementation UINavigationBar (hitedCategory)



-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if ([self pointInside:point withEvent:event]) {
        self.userInteractionEnabled = YES;
    } else {
        self.userInteractionEnabled = NO;
    }
    
    return [super hitTest:point withEvent:event];
}


@end
