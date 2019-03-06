//
//  NSObject+Basic.h
//  BaseLibs
//
//  Created by CPX on 2018/12/25.
//  Copyright © 2018 CPX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Basic)


/**
 数据持久化（单列存储）
 */
-(void)cpx_saveValue:(NSString*)key Value:(id)value;
-(id)cpx_getValue:(NSString*)key;
-(void)cpx_setBoolValue:(BOOL)value forKey:(NSString *)key;
-(BOOL)cpx_getBoolValueForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
