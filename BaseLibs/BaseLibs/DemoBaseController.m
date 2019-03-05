//
//  DemoBaseController.m
//  BaseLibs
//
//  Created by CPX_22 on 2019/3/4.
//  Copyright © 2019 CPX. All rights reserved.
//

#import "DemoBaseController.h"

@interface DemoBaseController ()
{
    BOOL _cacheState;//网络缓存开关状态
}

@property (weak, nonatomic) IBOutlet UITextView *netTextView;


@property (weak, nonatomic) IBOutlet UITextView *cacheTextView;

@end

@implementation DemoBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - button action
//网络请求事件
- (IBAction)action_networkBtn:(UIButton *)sender {
    NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
    CPXNetworkManagerModel *model = [[CPXNetworkManagerModel alloc] init];
    model.params = para;
    model.urlStr = @"http://api.budejie.com/api/api_open.php";
    model.expirationTime = 600.0;
    model.isCache = _cacheState;
    self.netTextView.text = @"";
    if (self->_cacheState) {
        [self requestCacheNetdataWithModel:model];
    }else{
        [self requestNetdataWithModel:model];
    }
    
}

/**
    CPXBaseLib网络缓存请求逻辑
    1 缓存通过调用不同函数来调用缓存
        //不带缓存的网络请求
        CPXRequestWithNetworkModel:(CPXNetworkManagerModel *)model
                           success:(CPXHttpRequestSuccess)success
                           failure:(CPXHttpRequestFailed)failure;
 
        //带缓存的网络请求 (通过函数是否有CPXHttpRequestCache这个block来调用缓存数据显示)
        CPXRequestWithNetworkModel:(CPXNetworkManagerModel *)model
                             responseCache:(CPXHttpRequestCache)responseCache
                                   success:(CPXHttpRequestSuccess)success
                                   failure:(CPXHttpRequestFailed)failure;
 
 */

//网络请求 （带缓存）
- (void)requestCacheNetdataWithModel:(CPXNetworkManagerModel *)model {
    /**
        注意！！！
        responseCache这个block的回调里面不做缓存数据的处理
        缓存数据在网络请求帮助类CPXNetworkManager里面进行处理，详情请command点击进入
     */
    [CPXNetworkManager CPXRequestWithNetworkModel:model responseCache:^(id  _Nonnull responseCache) {
        
    } success:^(id  _Nonnull responseObject) {
        [self dealNetData:responseObject];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//网络请求 （不带缓存）
- (void)requestNetdataWithModel:(CPXNetworkManagerModel *)model {
    [CPXNetworkManager CPXRequestWithNetworkModel:model success:^(id  _Nonnull responseObject) {
        [self dealNetData:responseObject];
    } failure:^(NSError * _Nonnull error) {

    }];

}


//网络缓存开关
- (IBAction)action_cacheBtn:(UISwitch *)sender {
    _cacheState = sender.on;
    if (_cacheState) {
        NSLog(@"缓存开关打开了");
    }else{
        NSLog(@"缓存开关关闭了");
    }
}
- (IBAction)action_clearBtn:(UIButton *)sender {
    
    self.netTextView.text = @"";
    
}


- (void)dealNetData:(id)responseObject {
    NSDictionary *responseDic = [NSDictionary cpx_safeDictionaryByObject:responseObject];
    NSString *dataStr = [NSString cpx_stringWithJsonDictionary:responseDic];
    self.netTextView.text = dataStr;
    if (![CPXNetworkManager isNetwork]) {
        
        self.cacheTextView.text = dataStr;
    }
    
}

@end
