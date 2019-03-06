//
//  CPXBaseTableView.m
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXBaseTableView.h"

@implementation CPXBaseTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self BasicConfig];
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);


    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self BasicConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self BasicConfig];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self BasicConfig];

}



//基本配置
-(void)BasicConfig{
    self.tableFooterView = [UIView new];
    self.backgroundColor = kAppBackGroundColor;
    self.separatorStyle = 0;//取消分割线
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInset = UIEdgeInsetsMake(kNavigation_height, 0, 0, 0);
    }else{
        self.frame = CGRectMake(0, kNavigation_height, kScreenWidth, kScreenHeight-kNavigation_height);

    }

}



@end
