//
//  NSArray+categories.m
//  CPX
//
//  Created by CPX on 2017/5/23.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import "NSArray+Basic.h"

@implementation NSArray (Basic)


/*
 *处理不安全数组
 */
+(NSArray*)cpx_saveArrayByObject:(id)unsaveObj
{
    if([unsaveObj isKindOfClass:[NSNull class]]){
        return [NSArray new];
    }
    if([unsaveObj isEqual:[NSNull null]])
    {
        return [NSArray new];
    }
    if([unsaveObj isKindOfClass:[NSArray class]]){
        return (NSArray*)unsaveObj;
    }
    if([unsaveObj isKindOfClass:[NSString class]]){
        NSString* tempStr = (NSString*)unsaveObj;
        if(!tempStr ||  tempStr.length == 0  || [tempStr isEqualToString:@"<null>"] || [tempStr isEqualToString:@"(null)"] || [tempStr isEqualToString:@""] || [tempStr isEqual:[NSNull null]]){
            return [NSArray array];
        }
        return [NSArray array];
    }
    if ([unsaveObj isKindOfClass:[NSDictionary class]]) {
        return [NSArray array];
    }
    return [NSArray array];
}



@end
