//
//  CPXNetworkCache.h
//  CPXNetwork
//
//  Created by CPX on 2018/11/14.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPXNetworkManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CPXNetworkCache : NSObject


/**
 异步缓存网络数据,根据请求的 URL与parameters，做KEY存储数据, 这样就能缓存多级页面的数据
 
 @param httpData 服务器返回的数据
 @param URL 请求的URL地址
 @param parameters 请求的参数
 */
//FIXME:暂时废弃用parameters创建Key方法 网络层调用该方法存储数据后在调用setHttpCache 来存储数据，详细实现见.m文件
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(id)parameters;

+ (void)setHttpCache:(id)httpData Key:(NSString *)Key;
/**
 根据请求的 URL与parameters 同步取出缓存数据
 
 @param URL 请求的URL
 @param parameters 请求的参数
 @return 缓存的服务器数据
 */
+ (id)httpCacheForURL:(NSString *)URL parameters:(id)parameters;
+ (id)httpCacheForKey:(NSString *)Key;

/**
 删除对应的key的缓存
 
 @param URL url
 @param parameters 参数
 */
+ (void)removeHttpDataForURL:(NSString *)URL parameters:(id)parameters;
+ (void)removeHttpDataForKey:(NSString *)key;
/**
 获取网络缓存的总大小 bytes(字节)
 */
+ (NSInteger)getAllHttpCacheSize;

/**
 删除所有网络缓存
 */
+ (void)removeAllHttpCache;


@end

NS_ASSUME_NONNULL_END
