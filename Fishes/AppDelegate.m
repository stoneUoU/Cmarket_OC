//
//  AppDelegate.m
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarVC.h"

//static TabBarVC *tabBarVc;

@implementation AppDelegate

//+ (void)setTabBarV:(TabBarVC *)tabBar
//{
//    tabBarVc = tabBar;
//}
//+ (TabBarVC *)getTabBarV
//{
//    return tabBarVc;
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [UICKeyChainStore keyChainStore][@"orLogin"] = @"false";
//    [UICKeyChainStore keyChainStore][@"authos"] = @"";
    //[AppDelegate setTabBarV:[[TabBarVC alloc] init]];

    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    [self.window.layer addAnimation:anim forKey:nil];
    self.window.rootViewController = [TabBarVC sharedVC];
    [self.window makeKeyAndVisible];

    //关闭设置为NO, 默认值为NO.  键盘监听
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //网络变化
    [GLobalRealReachability startNotifier];

    [self setNetNotice];
    return YES;
}
-(void) setNetNotice{
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkChanged:)
                                                 name:kRealReachabilityChangedNotification
                                               object:nil];
    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
    if (status == RealStatusNotReachable)
    {
        keychainStore[@"ifnetUse"] = @"unUseable";
    }
    if (status == RealStatusViaWiFi)
    {
        keychainStore[@"ifnetUse"] = @"Useable";
    }

    if (status == RealStatusViaWWAN)
    {
        keychainStore[@"ifnetUse"] = @"Useable";
    }
}

- (void)networkChanged:(NSNotification *)notification
{
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];


    if (status == RealStatusNotReachable)
    {
        keychainStore[@"ifnetUse"] = @"unUseable";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"netChange" object:self userInfo:@{@"ifnetUse":@"unUseable"}];
    }

    if (status == RealStatusViaWiFi)
    {
        keychainStore[@"ifnetUse"] = @"Useable";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"netChange" object:self userInfo:@{@"ifnetUse":@"Useable"}];
    }

    if (status == RealStatusViaWWAN)
    {
        keychainStore[@"ifnetUse"] = @"Useable";
        [[NSNotificationCenter defaultCenter]postNotificationName:@"netChange" object:self userInfo:@{@"ifnetUse":@"Useable"}];
    }

    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];

    if (status == RealStatusViaWWAN)
    {
        if (accessType == WWANType2G)
        {
            STLog(@"RealReachabilityStatus2G");
        }
        else if (accessType == WWANType3G)
        {
            STLog(@"RealReachabilityStatus3G");
        }
        else if (accessType == WWANType4G)
        {
            STLog(@"RealReachabilityStatus4G");
        }
    }
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
