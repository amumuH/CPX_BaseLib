//
//  CPXNetworkManagerModel.m
//  Api
//
//  Created by CPX on 2018/10/31.
//

#import "CPXNetworkManagerModel.h"
#import "CPXNetCofig.h"
#import "CommonUtls.h"
@interface CPXNetworkManagerModel ()

@end

@implementation CPXNetworkManagerModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self config];
    }

    return self;
}
//配置默认参数
-(void)config{
    self.expirationTime = 60 * 10;
    self.showNetworkActivityIndicator = YES;//默认开启菊花转圈
    self.retryCount = kNetRetryTimes;//默认重发次数
    if ([CommonUtls getCurrentViewController]) {
        self.showView = [CommonUtls cpx_getCurrentDisplayController].view;
    }else{
        self.showView = ROOTVC;
        
    }
    self.retryTimeOut = kNetWorkTimeOut;
    self.retryDelay = 0.01;
    self.errorStyle = ErrorShowWithHub;
    self.showCodeMsg = YES;
}


- (void)setIsFreshing:(BOOL)isFreshing {
    _isFreshing = isFreshing;
    _retryCount = kNetRetryTimes;//默认重发次数

}

@end
