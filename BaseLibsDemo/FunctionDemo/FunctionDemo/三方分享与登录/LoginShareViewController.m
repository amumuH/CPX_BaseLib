//
//  LoginShareViewController.m
//  FunctionDemo
//
//  Created by CPX on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import "LoginShareViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface LoginShareViewController ()

@end

/**
 一句代码实现三方登录与分享
 */
@implementation LoginShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)RESPONTObTN:(UIButton *)sender {
    SSDKPlatformType type = 0;
    switch (sender.tag - 1001) {
        case 0:
        {
            type =  SSDKPlatformTypeGooglePlus;
        }
            break;
        case 1:
        {
            type =  SSDKPlatformTypeTwitter;
            
        }
            break;
        case 2:
        {
            type =     SSDKPlatformTypeFacebook;
            
            
        }
            break;
        default:
            break;
    }
    [ShareSDK cancelAuthorize:type result:nil];
    
    [ShareSDK getUserInfo:type  onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        NSLog(@"%@",user.credential.token);
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                NSLog(@"sucess");
                NSLog(@"%@",user.rawData);
                NSLog(@"%@",user.uid);
                
            }
                break;
            case SSDKResponseStateCancel:
            {
                NSLog(@"cancle");
            }
                break;
            case SSDKResponseStateFail:
            {
                NSLog(@"%@",error.localizedDescription);
            }
                break;
                
            default:
                break;
        }
        
    }];
}


- (IBAction)share:(UIButton *)sender {
    SSDKPlatformType type = 0;
    switch (sender.tag - 2001) {
        case 0:
        {
            type =  SSDKPlatformTypeGooglePlus;
        }
            break;
        case 1:
        {
            type =  SSDKPlatformTypeTwitter;
            
        }
            break;
        case 2:
        {
            type =    SSDKPlatformTypeFacebook;
            
            
        }
            break;
        default:
            break;
    }
    [ShareSDK cancelAuthorize:type result:nil];
    
    //注：google分享仅支持web分享，分享类型仅支持Text和WebPage。
    NSArray* imageArray = @[[UIImage imageNamed:@"网络错误"]];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容:http://www.baidu.com"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.baidu.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        
        
    }];
}


@end
