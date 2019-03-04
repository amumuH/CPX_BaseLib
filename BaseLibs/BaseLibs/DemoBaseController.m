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
    model.expirationTime = 1.0;
    model.isCache = _cacheState;
    
    
    if (_cacheState) {
        [self requestCacheNetdataWithModel:model];
    }else{
        [self requestNetdataWithModel:model];
    }
    
}

//网络请求 （带缓存）
- (void)requestCacheNetdataWithModel:(CPXNetworkManagerModel *)model {
    
    
    
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
//    NSLog(@"%@",sender.state ? )
    if (_cacheState) {
        NSLog(@"缓存开关打开了");
    }else{
        NSLog(@"缓存开关关闭了");
    }
}


- (void)dealNetData:(id)responseObject {
    NSDictionary *responseDic = [NSDictionary cpx_safeDictionaryByObject:responseObject];
    NSString *dataStr = [NSString cpx_stringWithJsonDictionary:responseDic];
//    NSString *dataStr = [self jsonToString:responseDic];
    self.netTextView.text = dataStr;
    
}


/**
 *  json转字符串
 */
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
