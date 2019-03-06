//
//  NSDictionary+categories.m
//  CPX
//
//  Created by CPX on 2017/5/23.
//  Copyright © 2017年 zhongcaishenghuo. All rights reserved.
//

#import "NSDictionary+Basic.h"

@implementation NSDictionary (Basic)

/*
 *处理不安全字典
 */
+(NSDictionary*)cpx_safeDictionaryByObject:(id)unsaveObj
{
    if([unsaveObj isKindOfClass:[NSNull class]]){
        return [NSDictionary new];
    }
    if([unsaveObj isEqual:[NSNull null]])
    {
        return [NSDictionary new];
    }
    if([unsaveObj isKindOfClass:[NSDictionary class]]){
        return (NSDictionary*)unsaveObj;
    }
    if([unsaveObj isKindOfClass:[NSString class]]){
        NSString* tempStr = (NSString*)unsaveObj;
        if(!tempStr ||  tempStr.length == 0  || [tempStr isEqualToString:@"<null>"] || [tempStr isEqualToString:@"(null)"] || [tempStr isEqualToString:@""] || [tempStr isEqual:[NSNull null]]){
            return [NSDictionary dictionary];
        }
        return [NSDictionary dictionary];
    }
    if([unsaveObj isKindOfClass:[NSArray class]]){
        return [NSDictionary dictionary];

    }
    return [NSDictionary dictionary];
}

@end
