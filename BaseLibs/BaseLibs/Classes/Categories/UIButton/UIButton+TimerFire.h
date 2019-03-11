//
//  UIButton+TimerFire.h
//  PassCard
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 meiriyou. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用于展示倒计时按钮（获取验证码按钮
 */
@interface UIButton (TimerFire)


-(void)fireForTimerWithTimeCount:(NSInteger)count;



/**
 设置按钮边框颜色和圆角、title

 */
-(void)setBorderColorAndTitleColor;

@end
