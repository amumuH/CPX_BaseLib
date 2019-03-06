//
//  CPXCommonViewController.m
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXCommonViewController.h"

@interface CPXCommonViewController ()

@end

@implementation CPXCommonViewController


#pragma mark - system
-(void)dealloc
{
    NSLog(@"%@控制器------已被释放",NSStringFromClass([self class]));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self baseInitializedUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStatusBarLight:self.statusBarIsLight animate:NO];//改变状态栏颜色
    if (self.navBarBgAlpha == 0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    
}
//基本初始化
-(void)baseInitializedUI{
    self.view.backgroundColor = kAppBackGroundColor;
    [self initDefaultNavigation];
    [self initNavigation];

}

#pragma mark - customMethod
-(void)initUI{
}

- (void)initViews{
   
}
- (void)loadData{
    
}

- (void)initOtherViews{
    
}
- (void)initNavigation{
    //设置返回按钮
    if(self.navigationController.viewControllers.count > 1){
        [self initLeftBackNaviButton];
    }
    
}






- (void)initDefaultNavigation{
    self.navBarBgAlpha = 1;//设置导航栏透明度
    self.navBarTintColor = [UIColor redColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];//去除导航栏下方阴影
}



- (void)initLeftBackNaviButton{
 self.navigationItem.leftBarButtonItem = [UIBarButtonItem cpx_itemWithTarget:self action:@selector(defaultNavBackItemAction) image:[UIImage imageNamed:default_nav_back_img] imageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0) ];
    
}

//设置状态栏状态
- (void)setStatusBarLight:(BOOL)isLight animate:(BOOL)isAnimate{
    [[UIApplication sharedApplication] setStatusBarStyle:isLight?UIStatusBarStyleLightContent:UIStatusBarStyleDefault animated:isAnimate];
}



#pragma mark -  evntsAction

//返回按钮的点击事件
-(void)defaultNavBackItemAction
{

    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
