//
//  CPXNetworkManager.m
//  CPXNetwork
//
//  Created by CPX on 2018/11/14.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import "CPXNetworkManager.h"
#import "CPXNetCofig.h"
#import "AFNetworking.h"
@implementation CPXNetworkManager


+ (void)RequestWithNetworkModel:(CPXNetworkManagerModel *)model success:(CPXHttpRequestSuccess)success failure:(CPXHttpRequestFailed)failure {

    [self RequestWithNetworkModel:model responseCache:nil success:success failure:failure];
}

+ (void)RequestWithNetworkModel:(CPXNetworkManagerModel *)model
                     responseCache:(CPXHttpRequestCache)responseCaches
                           success:(CPXHttpRequestSuccess)success
                           failure:(CPXHttpRequestFailed)failure {
    
    /**
        网络框架缓存逻辑
        通过Model里面的参数来控制
        1 首先判断缓存时间是否过期并且responseCaches不为空（调用该方法则不为空）
        2 所有的缓存数据都是通过success这个Block进行回调传值（通过判断缓存时间是否过期并且是否有网来进行数据读取回调）
     */
    
    //判断缓存是否过期 NO 有效 YES 无效  （并判断是否为主动刷新数据）
    BOOL isExpired = [self isExpiredWithModel:model];
 
    //没有网的时候不用判断是否是下拉刷新
    if (!isExpired && ![self isNetwork]&&responseCaches) {
        id cacheData = [CPXNetworkCache httpCacheForURL:model.urlStr parameters:model.params];
        success(cacheData);
    }else if (!isExpired && model.isFreshing == NO&&responseCaches) {//有效 直接去读取缓存
        id cacheData = [CPXNetworkCache httpCacheForURL:model.urlStr parameters:model.params];
        success(cacheData);
    }else if(model.bodyDic.allKeys.count>0){
        NSArray *methodArray = @[@"GET",@"POST",@"PUT",@"PATCH",@"DELETE"];
        //body请求
        [self HTTPBody:model.urlStr prams:model.params body:model.bodyDic requestMethod:methodArray[model.requestMethod] responseCache:responseCaches success:success failure:failure];
    }else{
        switch (model.requestMethod) {
            case CPXRequestMethodGET:
                [self GET:model.urlStr parameters:model.params responseCache:responseCaches success:success failure:failure];
                break;
            case CPXRequestMethodPOST:
                [self POST:model.urlStr parameters:model.params responseCache:responseCaches success:success failure:failure];
                break;
            case CPXRequestMethodPUT:
                [self PUT:model.urlStr parameters:model.params responseCache:responseCaches success:success failure:failure];
                break;
            case CPXRequestMethodPATCH:
                [self PATCH:model.urlStr parameters:model.params responseCache:responseCaches success:success failure:failure];
                break;
            case CPXRequestMethodDELETE:
                [self DELETE:model.urlStr parameters:model.params responseCache:responseCaches success:success failure:failure];
                break;
            default:
                break;
        }
    }
}

#pragma mark -- 缓存相关
+ (BOOL)isExpiredWithModel:(CPXNetworkManagerModel *)model {
    
    //时间存储处理
    //先判断是否存了东西
    NSString *timeStoreKey = [NSString stringWithFormat:@"%@%@",model.urlStr,timeKey];
    id timeData = [CPXNetworkCache httpCacheForURL:timeStoreKey parameters:model.params];
    if (![timeData isKindOfClass:[NSString class]] ) {
        return YES;
    }
    //之前存储的有效时间
    double endTime = [timeData doubleValue] + model.expirationTime;
//    YES 有效 NO 无网 无网的状态下 缓存时效性延长30天
    if (!kIsNetwork) {
//        endTime = [timeData doubleValue] + (24 * 60 * 60 * 30);
        id cacheData = [CPXNetworkCache httpCacheForURL:model.urlStr parameters:model.params];
        if (cacheData) {
            return NO;
        }else{
            return YES;
        }
    }
    
    //FIXME:这里时间判断有待商榷 时间换算成秒数值太大 有可能无法比较
    NSTimeInterval nowTime = [NSString cpx_getCurrentTimeValue];
    if (endTime > nowTime) {
        //有效
        return NO;
    }
    

    
    return YES;
}


@end
