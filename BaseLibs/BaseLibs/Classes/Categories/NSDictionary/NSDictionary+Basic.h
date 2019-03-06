//
//  NSDictionary+categories.h
//  CPX
//
//  Created by CPX on 2017/5/23.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Basic)


/**
 处理不安全字典（null，@“” 等的处理）

 */
+(NSDictionary*)cpx_safeDictionaryByObject:(id)unsaveObj;


@end
