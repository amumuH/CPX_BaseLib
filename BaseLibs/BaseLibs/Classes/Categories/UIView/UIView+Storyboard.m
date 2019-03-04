//
//  UIView+Storyboard.m
//  CPX
//
//  Created by Apple on 2017/6/12.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import "UIView+Storyboard.h"

@implementation UIView (Storyboard)
@dynamic borderColor,borderWidth,cornerRadius;

-(void)setBorderColor:(UIColor *)borderColor{
    [self.layer setBorderColor:borderColor.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];

}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
    self.layer.masksToBounds = YES;
    
}
@end
