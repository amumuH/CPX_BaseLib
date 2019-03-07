//
//  TipViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "TipViewController.h"
#import "YZBottomSelectView.h"
#import "YBViewController.h"


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
    self.titleArray = @[@"成功提示",@"错误提示",@"警告提示",@"一般提示信息",@"loding",@"系统弹框",@"底部弹出框(仿微信)",@"类似QQ微信的弹框"];
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
        case 4:{
          MBProgressHUD *hub  =  [CPXAlertUtils loading];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [CPXAlertUtils stopLoading:hub message:@"stopLoading"];
            });
        }
            break;
        case 5:
            [CPXAlertUtils alertTitle:@"我是一个弹窗" andMsg:@"我是弹窗信息" buttonName:@[@"第一个按钮",@"第二个按钮"] fistAction:^{
                [CPXAlertUtils message:@"点击了第一个按钮"];
            } secondAction:^{
                [CPXAlertUtils message:@"点击了第二个按钮"];

            }];
            break;
        case 6:
            [YZBottomSelectView showBottomSelectViewWithTitle:@"选择的标题" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除（红色）" otherButtonTitles:@[@"JAVA", @"Objective-C", @"Python"] handler:^(YZBottomSelectView *bootomSelectView, NSInteger index) {
                NSLog(@"Yan -> 按钮index说明：取消：0，删除：-1，其他按钮：1、2、3...");
                NSString *logStr = [NSString stringWithFormat:@"Yan -> 当前点击按钮的index为：%ld", index];
                [CPXAlertUtils message:logStr];

            }];
            break;
        case 7:{
            YBViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TipViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
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
