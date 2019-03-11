//
//  CPXNetworkHelper.m
//  CPXNetwork
//
//  Created by CPX on 2018/11/14.
//  Copyright © 2018年 CPX. All rights reserved.
//

#import "CPXNetworkHelper.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "CPXNetCofig.h"

#ifdef DEBUG
#define CPXLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define CPXLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]


@implementation CPXNetworkHelper

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;



#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(CPXNetworkStatus)networkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(CPXNetworkStatusUnknown) : nil;
                if (_isOpenLog) CPXLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(CPXNetworkStatusNotReachable) : nil;
                if (_isOpenLog) CPXLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(CPXNetworkStatusReachableViaWWAN) : nil;
                if (_isOpenLog) CPXLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(CPXNetworkStatusReachableViaWiFi) : nil;
                if (_isOpenLog) CPXLog(@"WIFI");
                break;
        }
    }];
}

+ (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

+ (void)cancelAllRequest {
    // 锁操作 ([self allSessionTask] 可用 [_sessionManager downloadTasks]代替)
   
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}


#pragma mark - GET请求无缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    return [self GET:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark - POST请求无缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(CPXHttpRequestSuccess)success
                   failure:(CPXHttpRequestFailed)failure {
    return [self POST:URL parameters:parameters responseCache:nil success:success failure:failure];
}

#pragma mark -- PUT请求无缓存
+ (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    return [self PUT:URL parameters:parameters responseCache:nil success:success failure:failure];
}
#pragma mark -- PATCH请求无缓存
+ (NSURLSessionTask *)PATCH:(NSString *)URL
               parameters:(id)parameters
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    return [self PATCH:URL parameters:parameters responseCache:nil success:success failure:failure];
}

+ (__kindof NSURLSessionTask *)DELETE:(NSString *)URL
                           parameters:(id)parameters
                              success:(CPXHttpRequestSuccess)success
                              failure:(CPXHttpRequestFailed)failure {
    return [self DELETE:URL parameters:parameters responseCache:nil success:success failure:failure];

}

#pragma mark - GET请求自动缓存
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(CPXHttpRequestCache)responseCache
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    //读取缓存
    responseCache != nil ? responseCache([CPXNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [CPXNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(CPXHttpRequestCache)responseCache
                   success:(CPXHttpRequestSuccess)success
                   failure:(CPXHttpRequestFailed)failure {
    //读取缓存
    responseCache != nil ? responseCache([CPXNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;

    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [CPXNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;

    }];

    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
        
    
    
}

#pragma mark - PUT请求自动缓存
+ (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
            responseCache:(CPXHttpRequestCache)responseCache
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([CPXNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSURLSessionTask *sessionTask = [_sessionManager PUT:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [CPXNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}


#pragma mark - PATCH请求自动缓存
+ (NSURLSessionTask *)PATCH:(NSString *)URL
               parameters:(id)parameters
            responseCache:(CPXHttpRequestCache)responseCache
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([CPXNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSURLSessionTask *sessionTask = [_sessionManager PATCH:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [CPXNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - DELETE请求自动缓存
+ (NSURLSessionTask *)DELETE:(NSString *)URL
               parameters:(id)parameters
            responseCache:(CPXHttpRequestCache)responseCache
                  success:(CPXHttpRequestSuccess)success
                  failure:(CPXHttpRequestFailed)failure {
    //读取缓存
    responseCache!=nil ? responseCache([CPXNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
   NSURLSessionTask *sessionTask =  [_sessionManager DELETE:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache!=nil ? [CPXNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

+(void)HTTPBody:(NSString *)URL
                         prams:(id)parameters
                         body:(id)body
                requestMethod:(NSString*)requetMetod
                responseCache:(CPXHttpRequestCache)responseCache
                      success:(CPXHttpRequestSuccess)success
                     failure:(CPXHttpRequestFailed)failure{
    //读取缓存
    responseCache!=nil ? responseCache([CPXNetworkCache httpCacheForURL:URL parameters:parameters]) : nil;
    NSMutableURLRequest *request = [_sessionManager.requestSerializer requestWithMethod:requetMetod URLString:URL parameters:parameters error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    NSData *jsonData= [NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:jsonData];
    
    [[_sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        if (!error) {
            if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
            success ? success(responseObject) : nil;
            //对数据进行异步缓存
            responseCache!=nil ? [CPXNetworkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
            
        } else {
            if (_isOpenLog) {CPXLog(@"error = %@",error);}
            failure ? failure(error) : nil;
        }
    }] resume];
    
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(CPXHttpProgress)progress
                                success:(CPXHttpRequestSuccess)success
                                failure:(CPXHttpRequestFailed)failure {
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(CPXHttpProgress)progress
                                  success:(CPXHttpRequestSuccess)success
                                  failure:(CPXHttpRequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = NSStringFormat(@"%@%ld.%@",str,i,imageType?:@"jpg");
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                    mimeType:NSStringFormat(@"image/%@",imageType ?: @"image/png")];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (_isOpenLog) {CPXLog(@"responseObject = %@",responseObject);}
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (_isOpenLog) {CPXLog(@"error = %@",error);}
        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(CPXHttpProgress)progress
                              success:(void(^)(NSString *))success
                              failure:(CPXHttpRequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //拼接缓存目录
        NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
        //打开文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //创建Download目录
        [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
        //拼接文件路径
        NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
        //返回文件位置的URL路径
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    
    return downloadTask;
}
//下载文件（断点下载）
+ (__kindof NSURLSessionTask *)AFDownLoadFileWithUrl:(NSString*)urlHost
                                            progress:(DowningProgress)progress
                                             fileDir:(NSString *)fileDir
                                             success:(DonwLoadSuccessBlock)success
                                             failure:(DownLoadfailBlock)failure{
    
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:fileDir ? fileDir : @"Download"];
   NSURL *fileUrl = [NSURL fileURLWithPath:filePath isDirectory:NO];
    return [[CPXServerDownLoadTool sharedTool] AFDownLoadFileWithUrl:urlHost progress:progress fileLocalUrl:fileUrl success:success failure:failure];
    
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */
+ (void)initialize {
    
    NSURLSessionConfiguration * config  = [NSURLSessionConfiguration defaultSessionConfiguration];
    _sessionManager =[[AFHTTPSessionManager alloc]initWithBaseURL:nil sessionConfiguration:config];
   _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置网络请求超时时间
    _sessionManager.requestSerializer.timeoutInterval = kNetWorkTimeOut;
    
//    [_sessionManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    //打开打印日志
    _isOpenLog = YES;
    //配置请求头
//[ _sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",user.token] forHTTPHeaderField:@"Authorization"];
    // 打开状态栏的等待菊花
//
   

    
}



#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)setRequestSerializer:(CPXRequestSerializer)requestSerializer {
    _sessionManager.requestSerializer = requestSerializer==CPXRequestSerializerHTTP ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(CPXResponseSerializer)responseSerializer {
    _sessionManager.responseSerializer = responseSerializer==CPXResponseSerializerHTTP ? [AFHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}

+ (void)setRequestTimeoutInterval:(NSTimeInterval)time {
    _sessionManager.requestSerializer.timeoutInterval = time;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
    
    
    
}


+ (void)openNetworkActivityIndicator:(BOOL)open {
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end



