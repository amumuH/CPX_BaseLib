//
//  NaviDemoViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "NaviDemoViewController.h"

@interface NaviDemoViewController ()

@end

/**
 主要处理导航栏添加按钮的处理（适配不同系统导致位置偏移以及响应热区的问题）,侧滑手势导航栏透明度渐变以及颜色渐变
 */
@implementation NaviDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}

-(void)initUI{
    UIBarButtonItem *item1 = [UIBarButtonItem cpx_itemWithTarget:self action:@selector(responsetoBtn) title:@"按钮1     " ];
    UIBarButtonItem *item2 = [UIBarButtonItem cpx_itemWithTarget:self action:@selector(responsetoBtn) title:@"按钮2"];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //导航栏颜色处理
    self.navBarTintColor = [UIColor blueColor];

}

-(void)responsetoBtn{
    CPXBaseViewController *vc = [CPXBaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        vc.navBarBgAlpha = 0.5;

    });

}




@end
