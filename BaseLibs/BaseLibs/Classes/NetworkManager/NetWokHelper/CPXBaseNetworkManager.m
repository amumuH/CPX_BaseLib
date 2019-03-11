//
//  CPXBaseNetworkManager.m
//  demo
//
//  Created by CPX on 2018/11/19.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "CPXBaseNetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "CPXNetCofig.h"
#define hubTag 99999  //菊花的tag


@implementation CPXBaseNetworkManager

+ (void)CPXBaseRequestWithNetworkModel:(CPXNetworkManagerModel *)model
                               success:(CPXHttpRequestSuccess)success
                               failure:(CPXHttpRequestFailed)failure{
     //    为了适应手动控制缓存
        CPXHttpRequestCache responseCache;
        [self CPXBaseRequestWithNetworkModel:model responseCache:model.isCache?nil:responseCache success:success failure:failure];
    
}

+ (void)CPXBaseRequestWithNetworkModel:(CPXNetworkManagerModel *)model
                         responseCache:(CPXHttpRequestCache)responseCache
                               success:(CPXHttpRequestSuccess)success
                               failure:(CPXHttpRequestFailed)failure{

  //    设置网络超时时间
    [self setRequestTimeoutInterval:model.retryTimeOut];
    if (model.isShowHub) {
     //判断是否加载Hub菊花(避免retry的时候重复添加)
        MBProgressHUD *hub  = [model.showView viewWithTag:hubTag];
        if (!hub) {
            hub = [CPXAlertUtils loading:@"Loading" toView:model.showView];
            hub.tag = hubTag;
        }
    }
    if (model.showNetworkActivityIndicator) {
        //是否打开状态栏加载小菊花
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
    __weak typeof(self)weakSelf = self;
    [CPXBaseNetworkManager setValue:@"9" forHTTPHeaderField:@"fromType"];
    [self RequestWithNetworkModel:model responseCache:responseCache success:^(id  _Nonnull responseObject) {
        success(responseObject);
        [weakSelf stopNetWModel:model];

    } failure:^(NSError * _Nonnull error) {

        //这里，-1001是AFN的超时error ，超时retry
        //error.code == -1001 (暂时取消这块判断)
        if (model.retryCount > 0)
        {
            model.retryCount--;
            //retry
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(model.retryDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  [weakSelf CPXBaseRequestWithNetworkModel:model responseCache:responseCache success:success failure:failure];
            });
          
        }
        else  //处理错误信息
        {
            failure(error);
            [weakSelf stopNetWModel:model];
            [weakSelf deallfailure:model andError:error];//处理网络请求失败
        }
       
    }];
}

/**
 处理网络请求成功后的界面交互问题
 @param model scroview
 */
+(void)stopNetWModel:(CPXNetworkManagerModel*)model{
    MBProgressHUD *hub = [model.showView viewWithTag:hubTag];
    if (hub) {
        [CPXAlertUtils stopLoading:hub];
    }
    if (model.ScrollView) {
        [model.ScrollView cpx_endRefresh];  //结束一切刷新动作
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    
}
//处理网络请求失败
+(void)deallfailure:(CPXNetworkManagerModel*)model andError:(NSError * )error{
 
    if (model.errorStyle == ErrorShowWithHub) {
        [CPXAlertUtils error:[NSString stringWithFormat:@"%@",error.localizedDescription] duration:2 toView:model.showView];
    }    
}

@end
