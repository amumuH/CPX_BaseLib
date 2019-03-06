//
//  TipViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "TipViewController.h"

@interface TipViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray  *titleArray;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initDataSource];
}
-(void)initUI{
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellone"];
    
}
- (void)initDataSource{
    self.titleArray = @[@"window加载弹窗",@"view加载弹窗",@"window展示信息",@"view展示信息",@"成功展示弹窗",@"警告展示弹窗",@"错误展示弹窗",@"信息展示弹窗"];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cellone" forIndexPath:indexPath];
    cell.textLabel.text =self.titleArray[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [CPXAlertUtils success:@"成功提示"];
            break;
        case 1:
            [CPXAlertUtils error:@"错误提示"];
            
            break;
        case 2:
            [CPXAlertUtils warning:@"警告提示"];
            break;
        case 3:
            [CPXAlertUtils message:@"一般提示信息"];
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
            
        default:
            break;
    }
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}

-(void)dismiss
{
    
    
}
@end
