//
//  BaseController.m
//  BaseLibs
//
//  Created by CPX_22 on 2019/3/6.
//  Copyright © 2019 CPX. All rights reserved.
//

#import "BaseController.h"
#import "DemoBaseController.h"
#import "TipViewController.h"
#import "MainViewController.h"
#import "NaviDemoViewController.h"
#import "LoginShareViewController.h"

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
    NSArray *array = [NSArray arrayWithObjects:@"网络请求/断点下载",@"各种提示框",@"空白试图占位图",@"导航栏的处理",@"三方登录与分享",@"相册选择与图片编辑",nil];
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
    UIViewController *vc;
    switch (type) {
        case 0:{
             vc = [[DemoBaseController alloc] init];
        }
            
            break;
        case 1:{
            vc = [[TipViewController alloc] init];
        }
            
            break;
        case 2:{
            vc = [[MainViewController alloc] init];
        }
            
            break;
        case 3:{
            vc = [[NaviDemoViewController alloc]init];
        }
            break;
        case 4:{
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginShareViewController"];
        }
            break;
        case 5:{
            [CommonUtls presentImagePickControllerWithImageNumber:20 type:0 complet:^(NSArray<UIImage *> * _Nullable imagesArray) {
                
            }];
            return;
        }
            break;
        default:
            break;
    }
    
    vc.navigationItem.title =self.titleArray[type];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - getter setter
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] init];
    }
    return _titleArray;
}





@end
