//
//  EmptyTestViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "EmptyTestViewController.h"

@interface EmptyTestViewController ()
@property(nonatomic,assign)BOOL isEmpty;
@end

/**
 一句话实现控制位图（网络请求有无数据、有无网络的空站位图，以及重新刷新按钮）
 */
@implementation EmptyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    [self.view addSubview:self.tableView];
     __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf refreaciton];
        });
    }];
    [self.tableView.mj_header beginRefreshing];
}
-(void)refreaciton{
    _isEmpty = !_isEmpty;
    [self.tableView.mj_header endRefreshing];
    CPXFOREmptyAssistantConfiger *configer  =[CPXFOREmptyAssistantConfiger creatCofigWithType:_isEmpty?FOREmptyAssistantTypeNormal:FOREmptyAssistantTypeNetError];
    [self.tableView emptyViewConfiger:configer];
    [configer setEmptyBtnClickBlock:^{
        [CPXAlertUtils message:@"我是提示信息"];
    }];
    [self.tableView reloadData];
}


@end
