//
//  systemConfig.h
//  demo
//
//  Created by CPX on 2018/11/13.
//  Copyright © 2018 CPX. All rights reserved.
//

#ifndef SystemConfig_h
#define SystemConfig_h

//************************本地化*************************//
#define iOS12_Beyond ([[UIDevice currentDevice].systemVersion doubleValue]>=12.0)
#define iOS11_Beyond ([[UIDevice currentDevice].systemVersion doubleValue]>=11.0)
#define iOS10_Beyond ([[UIDevice currentDevice].systemVersion doubleValue]>=10.0)
#define iOS9_Beyond ([[UIDevice currentDevice].systemVersion doubleValue]>=9.0)


/**启动宏 各类通知相关**/
#define EVER_LAUNCHED @"EVERLAUNCHED"
#define EVER_SHOW_APP_MAIN_PAGE @"EVER_SHOW_APP_MAIN_PAGE"

#define ALIPAYCOMPLETED @"ALIPAYCOMPLETED"
#define WALLET_PAY_NOTIFICATION @"WALLETPAYNOTIFICATION"
#define PASS_RENEW_NOTIFICATION @"PASSRENEWNOTIFICATION"

#define APP_ENTER_BACKGROUND_MODE @"APP_ENTER_BACKGROUND_MODE"
#define APP_ENTER_FOREGROUND_MODE @"APP_ENTER_FOREGROUND_MODE"
#define APP_LUANCHADS_FINISHED_NOTIFICATION  @"APP_LUANCHADS_FINISHED_NOTIFICATION"


#define APP_ADVERTISEMENT_FINISHED_NOTIFICATION  @"APP_ADVERTISEMENT_FINISHED_NOTIFICATION"
//用户登录状态改变
#define USER_LOGIN_STATE_CHANGE_NOTIFICATION @"USER_LOGIN_STATE_CHANGE_NOTIFICATION"

//用户金币数量改变
#define USER_COINS_CHANGE_NOTIFICATION @"USER_COINS_CHANGE_NOTIFICATION"

/**
 界面跳转发送该通知、隐藏首页悬浮球
 */
#define PUSH_VIEWCONTROLLER_NOTI @"PUSH_VIEWCONTROLLER_NOTI"

#define PAY_SUCCES_NOTIF @"pay_success_notification"//支付成功通知

#endif /* systemConfig_h */
