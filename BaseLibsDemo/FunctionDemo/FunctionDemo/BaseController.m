//
//  BaseController.m
//  BaseLibs
//
//  Created by CPX_22 on 2019/3/6.
//  Copyright © 2019 CPX. All rights reserved.
//

#import "BaseController.h"
#import "DemoBaseController.h"

@interface BaseController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSMutableArray *titleArray;

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"演示Demo";
    [self configData];
    [self configTable];
}

- (void)configData {
    NSArray *array = [NSArray arrayWithObjects:@"网络缓存",@"test",@"test",nil];
    [self.titleArray addObjectsFromArray:array];
}

- (void)configTable {  
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    NSString *title = [NSString cpx_safetyStringByObject:self.titleArray[indexPath.row]];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self chooseFunctionType:indexPath.row];
}


- (void)chooseFunctionType:(NSInteger)type {
    switch (type) {
        case 0:{
            DemoBaseController *vc = [[DemoBaseController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}


#pragma mark - getter setter
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}





@end
