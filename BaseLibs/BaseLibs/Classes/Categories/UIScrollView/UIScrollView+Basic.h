 //
//  UIScrollView+Basic.h
//  demo
//
//  Created by CPX on 2018/11/15.
//  Copyright © 2018 CPX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
 
NS_ASSUME_NONNULL_BEGIN



@interface UIScrollView (Basic)

/**
 取消scrollview刷新
 */
-(void)cpx_endRefresh;



/**
 添加头部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)

 @param refreshingBlock  freshBlock
 @param netModel 网络请求model(有缓存的时候必传，不需要缓存的时候可以为nil)
 */
-(void)cpx_addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock withModel:(CPXNetworkManagerModel*)netModel;
-(void)cpx_addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 添加尾部刷新(自动处理网络请求配置model，关闭菊花的开关以及打开是手动刷新)

 @param refreshingBlock freshBlock
 @param netModel 网络请求model(有缓存的时候必传，不需要缓存的时候可以为nil)
 */
-(void)cpx_addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock withModel:(CPXNetworkManagerModel*)netModel;
-(void)cpx_addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock;


@end

NS_ASSUME_NONNULL_END
