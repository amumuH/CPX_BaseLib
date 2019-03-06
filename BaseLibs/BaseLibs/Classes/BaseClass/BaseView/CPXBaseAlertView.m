//
//  CPXBaseAlertView.m
//  Api
//
//  Created by CPX on 2018/12/3.
//

#import "CPXBaseAlertView.h"
#import "UIConfig.h"

@interface CPXBaseAlertView ()

@property (nonatomic,strong)UIButton *backBtn;

@end
@implementation CPXBaseAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0,kScreenWidth ,kScreenHeight);
        [self initBaseAlertView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        [self initBaseAlertView];
    }
    return  self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0,kScreenWidth ,kScreenHeight);
    [self initBaseAlertView];

}

-(void)initBaseAlertView{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [self addSubview:self.backBtn];
    [self sendSubviewToBack:self.backBtn];
}



- (void)setRemoveOnTouchOutside:(BOOL)removeOnTouchOutside {
    _removeOnTouchOutside = removeOnTouchOutside;
    self.backBtn.userInteractionEnabled = _removeOnTouchOutside;
}

-(void)show:(BOOL)animate{
    [self show:animate withShowView:ROOTVC];
}
- (void)onGesture{
    if (self.removeOnTouchOutside) {
        [self dissmis:YES];
    }
}

-(void)show:(BOOL)animate withShowView:(UIView*)view{
//    [self addSubview:_bgView];
    [view?view:ROOTVC addSubview:self];
    __weak typeof(self)weakSelf = self;
    if (animate) {
        self.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.alpha = 1;
        }];
    }
}
-(void)dissmis:(BOOL)animate{
    if (animate) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf dissmiss];
        }];
    }else{
        [self dissmiss];
    }
    
}
-(void)dissmiss{
    if (self.cancelActionBtnBlock) {
        self.cancelActionBtnBlock();
    }
    [self removeFromSuperview];

}
-(void)respontocancle{
    
    [self dissmis:YES];
   
    
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [_backBtn addTarget:self action:@selector(respontocancle) forControlEvents:UIControlEventTouchUpInside];
        _backBtn.userInteractionEnabled = YES;
    }
    return _backBtn;
}

@end
