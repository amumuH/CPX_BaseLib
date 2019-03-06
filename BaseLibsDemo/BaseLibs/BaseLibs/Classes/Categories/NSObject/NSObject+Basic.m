//
//  NSObject+Basic.m
//  BaseLibs
//
//  Created by CPX on 2018/12/25.
//  Copyright © 2018 CPX. All rights reserved.
//

#import "NSObject+Basic.h"

@implementation NSObject (Basic)

-(void)cpx_saveValue:(NSString*)key Value:(id)value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(id)cpx_getValue:(NSString*)key{
    return [NSString cpx_safetyStringByObject:[[NSUserDefaults standardUserDefaults] valueForKey:key]];
}
-(void)cpx_setBoolValue:(BOOL)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(BOOL)cpx_getBoolValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]boolForKey:key];
}

@end
