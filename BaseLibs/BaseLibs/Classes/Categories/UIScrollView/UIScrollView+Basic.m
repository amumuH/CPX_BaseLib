//
//  UIScrollView+Basic.m
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "UIScrollView+Basic.h"
#import "CPXNetCofig.h"
#import <objc/runtime.h>


@implementation UIScrollView (Basic)


-(void)cpx_endRefresh{
    if (self.mj_header.refreshing == YES) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer.refreshing == YES) {
        [self.mj_footer endRefreshing];
    }
    
}
-(void)cpx_addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    [self cpx_addHeaderRefresh:refreshingBlock withModel:nil];
}
-(void)cpx_addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock withModel:(CPXNetworkManagerModel*)netModel{

    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (netModel) {
            netModel.isShowHub = NO;
            netModel.isFreshing = YES;
            netModel.ScrollView = self;
        }
        if (refreshingBlock) {
            refreshingBlock();

        }
    }];
}
-(void)cpx_addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    [self cpx_addFooterRefresh:refreshingBlock withModel:nil];
}
-(void)cpx_addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock withModel:(CPXNetworkManagerModel*)netModel{
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (netModel) {
            netModel.isShowHub = NO;
            netModel.isFreshing = YES;
            netModel.ScrollView = self;

        }
        if (refreshingBlock) {
            refreshingBlock();
            
        }
    }];
    #warning
    //    [footer setTitle:LWLocalzableString(@"我是有底线的",nil) forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

@end
