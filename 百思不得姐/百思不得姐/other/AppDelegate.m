//
//  AppDelegate.m
//  百思不得姐
//
//  Created by 张树 on 16/5/12.
//  Copyright © 2016年 com.zs. All rights reserved.
//

#import "AppDelegate.h"
#import "BSTabBarController.h"
#import "BSNewFeature.h"
#import "BSTopWindow.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //设置根控制器
    BSTabBarController *tabBarVc = [[BSTabBarController alloc]init];
    //设置代理，监听tabbar的点击
    tabBarVc.delegate = self;
    self.window.rootViewController = tabBarVc;
    //显示窗口
    [self.window makeKeyAndVisible];
    //取出当前版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *shaboxVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    if (![currentVersion isEqualToString:shaboxVersion]) {
        //显示新特性
        BSNewFeature *guideView = [BSNewFeature showGuideView];
        guideView.frame = self.window.frame;
        [self.window addSubview:guideView];
        //当前版本号存入沙盒中
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:key];
    }
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //发出通知,让控制器去接收通知
    [[NSNotificationCenter defaultCenter]postNotificationName:BSTabBarDidSelectedNotification object:nil userInfo:nil];
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

@end
