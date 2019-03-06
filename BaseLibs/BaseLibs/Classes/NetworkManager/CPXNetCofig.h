//
//  CPXNetCofig.h
//  demo
//
//  Created by CPX on 2018/11/19.
//  Copyright © 2018 CPX. All rights reserved.
//

#ifndef CPXNetCofig_h
#define CPXNetCofig_h

#define kIsNetwork     [CPXNetworkHelper isNetwork]  // 一次性判断是否有网的宏
#endif

#ifndef kIsWWANNetwork
#define kIsWWANNetwork [CPXNetworkHelper isWWANNetwork]  // 一次性判断是否为手机网络的宏
#endif

#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork [CPXNetworkHelper isWiFiNetwork]  // 一次性判断是否为WiFi网络的宏

#define kNetWorkTimeOut 7.f                 //网络请求超时
#define kNetRetryTimes 1         //网络请求retry次数



//************************缓存key*************************//
#define timeKey @"timeKey"



#endif /* CPXNetCofig_h */
