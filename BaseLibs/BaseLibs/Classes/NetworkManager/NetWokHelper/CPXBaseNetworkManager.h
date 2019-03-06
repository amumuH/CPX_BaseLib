//
//  CPXBaseNetworkManager.h
//  demo
//
//  Created by CPX on 2018/11/19.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN


/**
 Base网络请求Manger（主要处理一些试图交互逻辑的处理）
 */
@interface CPXBaseNetworkManager : CPXNetworkManager

/**
 不带缓存的网络请求

 @param model 网络请求配置model
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)CPXBaseRequestWithNetworkModel:(CPXNetworkManagerModel *)model
                           success:(CPXHttpRequestSuccess)success
                           failure:(CPXHttpRequestFailed)failure;


/**
 带缓存的网络请求

 @param model 网络请求配置model
 @param responseCache 缓存的回调
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)CPXBaseRequestWithNetworkModel:(CPXNetworkManagerModel *)model
                     responseCache:(CPXHttpRequestCache)responseCache
                           success:(CPXHttpRequestSuccess)success
                           failure:(CPXHttpRequestFailed)failure;


@end

NS_ASSUME_NONNULL_END
