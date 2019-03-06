//
//  NSArray+categories.h
//  CPX
//
//  Created by CPX on 2017/5/23.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Basic)

/*
 *处理不安全数组
 */
+(NSArray*)cpx_saveArrayByObject:(id)unsaveObj;

@end
