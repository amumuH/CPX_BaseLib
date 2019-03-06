//
//  BaseController.m
//  BaseLibs
//
//  Created by CPX_22 on 2019/3/6.
//  Copyright © 2019 CPX. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configTable];
}

- (void)configTable {

    self.tableView = [[CPXBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = @"test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self chooseFunctionType:indexPath.row];
}


- (void)chooseFunctionType:(NSInteger)type {
    switch (type) {
        case 0:
            
            break;
            
        default:
            break;
    }
}






@end
