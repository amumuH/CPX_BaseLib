//
//  CPXBaseAlertView.h
//  Api
//
//  Created by CPX on 2018/12/3.
//

#import "CPXBaseView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 弹框基类
 */
@interface CPXBaseAlertView : CPXBaseView
//@property(nonatomic,strong)UIView *bgView;
@property (nonatomic) BOOL removeOnTouchOutside; ///<default NO
@property (nonatomic,copy)void(^sureActionBtn)(void);//按钮block
@property (nonatomic,copy)void(^cancelActionBtnBlock)(void);//取消按钮block（点击空白处取消）

-(void)show:(BOOL)animate;
-(void)show:(BOOL)animate withShowView:(UIView*)view;
-(void)dissmis:(BOOL)animate;


@end

NS_ASSUME_NONNULL_END
