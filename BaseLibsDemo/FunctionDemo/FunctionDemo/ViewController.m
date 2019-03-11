//
//  ViewController.m
//  FunctionDemo
//
//  Created by CPX_22 on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "ViewController.h"
#import "DMPagingScrollView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    NSInteger selectedIndex;
    CGFloat itemWidth;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    itemWidth = 1000;
}

- (void)initUI{
    DMPagingScrollView *DMtableview = [DMPagingScrollView new];
    DMtableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    DMtableview.delegate = self;
    DMtableview.dataSource = self;
    DMtableview.rowHeight = 1000;
    DMtableview.pageHeight = 1000;
    DMtableview.pagingEnabled = YES;
    //    self.tableView.pagingEnabled = YES;
    [DMtableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:DMtableview];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    self.tableView.rowHeight = 1000;
////    self.tableView.pagingEnabled = YES;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    [cell setBackgroundColor:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]];
   
    return cell;
}

//主要代码
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
//    CGFloat x = targetContentOffset->x;
//    CGFloat pageWidth = itemWidth + 20;
//    CGFloat movedX = x - pageWidth * selectedIndex;
//    if (movedX < -pageWidth * 0.5) {
//        // Move left
//        selectedIndex--;
//    } else if (movedX > pageWidth * 0.5) {
//        // Move right
//        selectedIndex++;
//    }
//
//    if (ABS(velocity.x) >= 2){
//        targetContentOffset->x = pageWidth * selectedIndex;
//    } else {
//        targetContentOffset->x = scrollView.contentOffset.x;
//        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, itemWidth * selectedIndex) animated:YES];
//    }
//    NSLog(@"%ld",selectedIndex);
//}


@end
