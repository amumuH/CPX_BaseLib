//
//  CPXNetworkCache.m
//  CPXNetwork
//
//  Created by CPX on 2018/11/14.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import "CPXNetworkCache.h"
#import "YYCache.h"
#import "CPXNetCofig.h"
static NSString *const CPXNetworkResponseCache = @"CPXNetworkResponseCache";

@implementation CPXNetworkCache
static YYCache *_dataCache;

+ (void)initialize {
    _dataCache = [YYCache cacheWithName:CPXNetworkResponseCache];
}
+ (void)setHttpCache:(id)httpData Key:(NSString *)Key{
    [_dataCache setObject:httpData forKey:Key withBlock:nil];

}
+ (void)setHttpCache:(id)httpData URL:(NSString *)URL parameters:(NSDictionary *)parameters {
    //数据存储地址key
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    
    //做两次存储操作 一次存数据 一次存对应数据的有效时间
    //1 存储数据 异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
    //2 存储对应数据存储时候的时间
    //时间存储处理
    NSTimeInterval currentTime = [NSString cpx_getCurrentTimeValue];
    NSString *storeTimeStr = [NSString stringWithFormat:@"%lf",currentTime];
    NSString *timeKeyStr = [self cacheKeyWithURL:[NSString stringWithFormat:@"%@%@",URL,timeKey] parameters:parameters];
    [_dataCache setObject:storeTimeStr forKey:timeKeyStr withBlock:nil];
}




+ (id)httpCacheForURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (id)httpCacheForKey:(NSString *)Key {
    return [_dataCache objectForKey:Key];
}

+ (NSInteger)getAllHttpCacheSize {
    return [_dataCache.diskCache totalCost];
}
+ (void)removeHttpDataForKey:(NSString *)key{
    [_dataCache removeObjectForKey:key];
}
+ (void)removeHttpDataForURL:(NSString *)URL parameters:(id)parameters{
    [_dataCache removeObjectForKey:[self cacheKeyWithURL:URL parameters:parameters]];
}

+ (void)removeAllHttpCache {
    [_dataCache removeAllObjects];
}

/**
 生成网络缓存存储地址
 
 @param URL 网络请求URL
 @param parameters 请求参数
 @return 生成的字符串cacheKey
 */
+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}


@end
