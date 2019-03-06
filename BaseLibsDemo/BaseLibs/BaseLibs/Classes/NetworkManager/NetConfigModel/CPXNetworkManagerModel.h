//
//  CPXNetworkManagerModel.h
//  Api
//
//  Created by CPX on 2018/10/31.
//
/*************************************************************
 * Copyright (c)  成都魔力百聚科技有限公司
 * All rights reserved.
 *
 * 文件名称:        网络请求管理类Model
 * 文件标识:        Model
 * 摘要说明:        此Model用于进行网络请求前的配置，具体用法请看参数说明
 *
 * 当前版本:        1.0.0
 * 作    者:       CPX
 * 更新日期:
 * 整理修改:
 *
 ***************************************************************/
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CPXNetWorkReliability) {
    //如果没有发送成功，再次请求
    CPXNetWorkReliabilityRetry = 0,
    //必须要成功的请求，如果不成功就存入DB，然后再网络好的情况下继续发送，参照微信发消息
    //需要注意，这类请求是不需要回调的
    //类似于发微信成功与否
    //必定成功，只要有网的情况下必定成功
    CPXNetWorkReliabilityStoreToDB,
    //普通请求，成不成功不影响业务，不需要重新发送
    //类似统计、后台拉取本地已有的配置之类的请求
    CPXNetWorkReliabilityNormal
};

/**
 网络请求方式

 - CPXRequestMethodGET: GET
 - CPXRequestMethodPOST: POS
 - CPXRequestMethodPUT:  PUT
 - CPXRequestMethodPATCH :PATCH
 - CPXRequestMethodDELETE: DELETE
 */
typedef NS_ENUM(NSInteger, CPXRequestMethod) {
    CPXRequestMethodGET = 0,
    CPXRequestMethodPOST,
    CPXRequestMethodPUT,
    CPXRequestMethodPATCH,
    CPXRequestMethodDELETE    
};
//网络请求Fail的展示
typedef NS_ENUM(NSInteger, RequestErrorShowStyle) {
    ErrorShowNone = 0,  //无
    ErrorShowWithHub,    //展示hub
    ErrorShowWithEmptyConfig,    //展示占位图
};  //网络请求失败展示效果

/// 网络状态的Block
typedef void(^CPXNetworkMethodType)(CPXRequestMethod status);


NS_ASSUME_NONNULL_BEGIN

@interface CPXNetworkManagerModel : NSObject
/**
 请求的url
 （必传）
 */
@property (nonatomic, copy) NSString *urlStr;

/**
 请求参数
（可不传）
 */
@property (nonatomic, copy) NSDictionary *params;

/**
 用于body网络请求传参数
 */
@property(nonatomic,strong)NSDictionary *bodyDic;



/**
 缓存开关 YES：打开开关 NO：关闭开关（默认关闭）

 */
@property (nonatomic, assign) BOOL isCache;
/**
 缓存过期时间  有网默认600秒 无网30天
 */
@property (nonatomic, assign) int expirationTime;


/**
 请求重复策略，默认重发（暂时没用）
 */
@property (nonatomic, assign) CPXNetWorkReliability reliability;

/**
 请求没成功，重连次数(默认一次)
 */
@property (nonatomic, assign) int retryCount;

/**
网络请求超时时间
 */
@property (nonatomic,assign) int retryTimeOut;

/**
 每次retry之间的间隔时间(默认0.1秒)
 */
@property (nonatomic,assign) CGFloat retryDelay;

/**
 请求方式（默认get）
 */
@property (nonatomic, assign) CPXRequestMethod requestMethod;

/**
 是否展示菊花（默认为NO）
 */
@property (nonatomic,assign) BOOL isShowHub;

/**
 菊花展示的view(配合IsShowHub使用，默认为window)
 */
@property (nonatomic,strong) UIView *showView;
/**
 传入一个继承于scrollView(tableview和collectionView都可以)，用来关闭上拉下拉刷新
 */
@property (nonatomic,strong) UIScrollView *ScrollView;

/**
 判断是否为手动刷新数据（如果是手动刷新数据就不用判断时间是否过期 ：  YES代表手动刷新数据）
 */
@property (nonatomic,assign) BOOL isFreshing;


/**
 是否展示状态栏小菊花(默认打开)
 */
@property(nonatomic,assign)BOOL showNetworkActivityIndicator;


/**
 网络请求错误的展示方式
 */
@property(nonatomic,assign)RequestErrorShowStyle errorStyle;

/**
 是否展示错误信息信息
 */
@property(nonatomic,assign)BOOL showCodeMsg;

/**
 是否取消当前网络请求
 */
@property(nonatomic,assign)BOOL isCancelRequest;




@end

NS_ASSUME_NONNULL_END
