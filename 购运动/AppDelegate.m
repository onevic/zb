//
//  AppDelegate.m
//  购运动
//
//  Created by one_vic on 13-11-18.
//  Copyright (c) 2013年 one_vic. All rights reserved.
//

#import "AppDelegate.h"
#import "DDMenuController.h"
#import "IndexViewController.h"
#import "LeftViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    /*创建数据库*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cacheDBPath = [NSString stringWithFormat:@"%@/Library/Caches/SQLite3.db", NSHomeDirectory()];
    if (NO == [fileManager fileExistsAtPath:cacheDBPath])
    {
        NSString *appDBPath = [NSString stringWithFormat:@"%@/SQLite3.db", [NSBundle mainBundle].resourcePath];
        [fileManager copyItemAtPath:appDBPath toPath:cacheDBPath error:nil];
    }
    
    // 创建程序结构
    IndexViewController *index = [[IndexViewController alloc] init];
    UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:index];
    indexNav.navigationBar.hidden = YES;
    LeftViewController *left = [[LeftViewController alloc] init];
    _ddmenu = [[DDMenuController alloc] initWithRootViewController:indexNav];
    _ddmenu.leftViewController = left;
    self.window.rootViewController = _ddmenu;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
