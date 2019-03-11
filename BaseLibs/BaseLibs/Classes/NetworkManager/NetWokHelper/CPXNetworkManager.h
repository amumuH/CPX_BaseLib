//
//  CPXNetworkManager.h
//  CPXNetwork
//
//  Created by CPX on 2018/11/14.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import "CPXNetworkHelper.h"
#import "CPXNetworkManagerModel.h"
NS_ASSUME_NONNULL_BEGIN

/**
 网络请求，主要处理缓存以及过期问题。对各种请求方法的整合
 */
@interface CPXNetworkManager : CPXNetworkHelper



/**
 不带缓存的网络请求

 @param model 配置model
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)RequestWithNetworkModel:(CPXNetworkManagerModel *)model
                           success:(CPXHttpRequestSuccess)success
                           failure:(CPXHttpRequestFailed)failure;
    
/**
 带缓存的网络请求

 @param model 配置model
 @param responseCache 缓存回调
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)RequestWithNetworkModel:(CPXNetworkManagerModel *)model
                     responseCache:(CPXHttpRequestCache)responseCache
                           success:(CPXHttpRequestSuccess)success
                           failure:(CPXHttpRequestFailed)failure;
@end

NS_ASSUME_NONNULL_END
