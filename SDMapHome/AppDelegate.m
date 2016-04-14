//
//  AppDelegate.m
//  SDMapHome
//
//  Created by shendong on 16/4/5.
//  Copyright © 2016年 Allen. All rights reserved.
//

#import "AppDelegate.h"
#import <JSPatch/JSPatch.h>

#import "SDFileToolClass.h"
//高德地图KEY
static NSString *const KGao_De_KEY = @"20fa6f28cd02b0833a568b2ec084425f";
/**
 *  已导入高德库
    1. 高德导航
    2. 高德3D地图
    3. 高德地图搜索
    4. 高德定位
 */

//JSPatch KEY
static NSString *const KJSPatchKEY = @"1285cb383ce9ea76"; //APP版本1.0

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"homeDirectory = %@",NSHomeDirectory());
    [self configueGao_DeMap];
    
//    [self configueJSPatch];
    
    [self catchCrashLogs];
    
    return YES;
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - 配置 SDK
/**
 *  配置高德地图
 */
- (void)configueGao_DeMap{
    //1.高德3D地图
    [MAMapServices sharedServices].apiKey = KGao_De_KEY;
    [AMapSearchServices sharedServices].apiKey = KGao_De_KEY;
    //2.高德定位
    [AMapLocationServices sharedServices].apiKey = KGao_De_KEY;
    
}

/**
 *  配置JSPatch热修复
 */
- (void)configueJSPatch{
//    [JSPatch startWithAppKey:KJSPatchKEY];
    [JSPatch testScriptInBundle];
    [JSPatch sync];
    [JSPatch setupLogger:^(NSString * message) {
        NSLog(@"message");
    }];
    [JSPatch setupCallback:^(JPCallbackType type, NSDictionary *data, NSError *error) {
        NSLog(@"data = %@, error = %@",data,error);
    }];
}

- (void)catchCrashLogs{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}
void UncaughtExceptionHandler(NSException *exception){
    if (exception ==nil)return;
    NSArray *array = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name  = [exception name];
    NSDictionary *dict = @{@"appException":@{@"exceptioncallStachSymbols":array,@"exceptionreason":reason,@"exceptionname":name}};
    NSLog(@"%@",NSHomeDirectory());
    
    if([SDFileToolClass writeCrashFileOnDocumentsException:dict]){
        NSLog(@"OKKK");
    }else{
        NSLog(@"not ok!");
    };
}
@end
