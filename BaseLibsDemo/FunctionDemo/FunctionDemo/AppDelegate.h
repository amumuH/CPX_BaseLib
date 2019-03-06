//
//  AppDelegate.h
//  FunctionDemo
//
//  Created by CPX_22 on 2019/3/6.
//  Copyright © 2019 CPX_22. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

