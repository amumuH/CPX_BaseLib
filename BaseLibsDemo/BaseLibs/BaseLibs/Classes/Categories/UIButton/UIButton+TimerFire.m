//
//  UIButton+TimerFire.m
//  PassCard
//
//  Created by apple on 16/7/2.
//  Copyright © 2016年 meiriyou. All rights reserved.
//

#import "UIButton+TimerFire.h"

@implementation UIButton (TimerFire)


-(void)fireForTimerWithTimeCount:(NSInteger)count
{
    self.count = (int)count;
    self.originTitle = self.titleLabel.text;
    NSTimer * timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerGo:) userInfo:nil repeats:YES];
    [timer fire];
    
    
    
}
-(void)timerGo:(NSTimer * )timer{
    if (self.count==0)
    {
        self.enabled = YES;
        self.titleLabel.text = [NSString stringWithFormat:@"%@",self.originTitle];
        [self setTitle:[NSString stringWithFormat:@"%@",self.originTitle] forState:UIControlStateNormal];
        [timer invalidate];
        return;
    }
    self.count--;
    self.enabled= NO;
    self.titleLabel.text = [NSString stringWithFormat:@"%ds",self.count];
    [self setTitle:[NSString stringWithFormat:@"%ds",self.count] forState:UIControlStateNormal];
    
    
}

static char countKey;
- (int)count {
    NSNumber *t = objc_getAssociatedObject(self, &countKey);
    return (int)[t integerValue];
    
    
}

- (void)setCount:(int)count {
    NSNumber *t = @(count);
    
    objc_setAssociatedObject(self, &countKey, t, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char originTitleKey;
-(NSString * )originTitle
{
    return objc_getAssociatedObject(self, &originTitleKey);
    
}
-(void)setOriginTitle:(NSString *)originTitle{
    objc_setAssociatedObject(self, &originTitleKey, originTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(void)setBorderColorAndTitleColor{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = Button_Border_Color.CGColor;
    self.layer.borderWidth = 0.5;
    [self setImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setTitleColor:Button_Border_Color forState:UIControlStateNormal];
}

@end
