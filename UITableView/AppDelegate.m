//
//  AppDelegate.m
//  UITableView
//
//  Created by liuhang on 16/9/8.
//  Copyright © 2016年 刘航. All rights reserved.
//
/* 友盟推送 */
//  appKey :  57e131b767e58e8c530023aa
//  App Master Secret  :  xxjbr7xiyynminlpyu5ksdijxqgkve0m
#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "UMessage.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //友盟
    //设置 AppKey 及 LaunchOptions
    [UMessage startWithAppkey:@"57e131b767e58e8c530023aa" launchOptions:launchOptions];
    
    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
    [UMessage registerForRemoteNotifications];
    [UMessage setLogEnabled:YES];
    //初始化数据库
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"FoodModel.sqlite"];
    return YES;
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //数据库清除
    [MagicalRecord cleanUp];
}

@end
