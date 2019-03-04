//
//  CPXFreshViewController.m
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXDataViewController.h"

@interface CPXDataViewController ()

@end

@implementation CPXDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark -  customMethod

-(void)initDataSource{
    _page = 0;
    _pageSize = 0;
}

#pragma mark - lazy
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(CPXBaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [CPXBaseTableView new];
        
    }
    return _tableView;
}

-(CPXNetworkManagerModel *)netConfigmodel{
    if (!_netConfigmodel) {
        _netConfigmodel = [CPXNetworkManagerModel new];
    }
    return _netConfigmodel;
}
@end
