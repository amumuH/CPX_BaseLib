//
//  CPXFreshViewController.h
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXCommonViewController.h"
#import "CPXNetworkManagerModel.h"
#import "CPXBaseTableView.h"
NS_ASSUME_NONNULL_BEGIN

/***********************************************************
              主要是针对数据的处理
 ***********************************************************/


@interface CPXDataViewController : CPXCommonViewController
@property (nonatomic,strong)NSMutableArray * dataArray;/**<所有带有列表的页面全部使用该数据项*/
@property (nonatomic,assign)BOOL isDownRefresh;/**< 是否是下拉刷新 默认NO*/
@property (nonatomic,assign)int page;/**<分页 默认为0*/
@property (nonatomic,assign)int pageSize;/**<每个分页的数据量长度*/
@property (nonatomic,strong)CPXBaseTableView *tableView;/**<默认tableview（采用懒加载形式创建）*/
@property(nonatomic,strong)CPXNetworkManagerModel *netConfigmodel;/**<网络请求配置model*/


@end

NS_ASSUME_NONNULL_END
