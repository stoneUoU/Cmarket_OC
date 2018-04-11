//
//  AppDelegate.m
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarVC.h"

#import "MonitorVC.h"

#import "YYModelVC.h"

#import "YYCacheVC.h"

#import "ThreadVC.h"

#import "YYCacheTools.h"
//static TabBarVC *tabBarVc;
#import "AppUpdate.h"

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


#import "XYLaunchVC.h"
#import "XYIntroductionPage.h"

@interface AppDelegate ()<XYLaunchDelegate,XYIntroductionDelegate>
{
    XYIntroductionPage * _xyIntroductionPage;
    NSArray *            _xyCoverImgNameArr;
    NSArray *            _xyBgImgNameArr;
    NSArray *            _xyCoverTitleArr;
    NSURL   *            _xyVideoUrl;
    XYLaunchVC *         _xyLaunch;
}
@end

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
    [self.window makeKeyAndVisible];

    //关闭设置为NO, 默认值为NO.  键盘监听
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //网络变化
    [GLobalRealReachability startNotifier];

    [self setNetNotice];

    [self setAPNS];
    //注册微信支付:
    [STPAYMANAGER st_registerApp];

    [YYCacheTools removeAllResCache];
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    [JPUSHService setupWithOption:launchOptions appKey:jpushAppKey
                          channel:apsForChannel
                 apsForProduction:apsForPs
            advertisingIdentifier:nil];
    //通过通知启动APP
    NSDictionary *remoteUserInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteUserInfo) {//远程通知启动App
        [self dealPushM:remoteUserInfo];
    }else{
        if ([[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"firstIn"]]  isEqual: @"true"]){
            self.window.rootViewController =  [TabBarVC sharedVC]; //[[ThreadVC alloc] init];//[TabBarVC sharedVC];  //  [[YYCacheVC alloc] init]; //[[MonitorVC alloc]init ];  //[[YYModelVC alloc] init];
            //[self xyAdLaunch];
        }else{
            [self setFollow];
        }
    }

    //检查更新
//    AppUpdate *appUpdate = [AppUpdate shareIns];
//    [appUpdate appVersion];

    #pragma mark-xy -引导页-----------------------------------------------------
    //[self setFollow];
    return YES;
}

-(void)setAPNS{
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
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
        STLog(@"1111");
        keychainStore[@"ifnetUse"] = @"unUseable";
    }
    if (status == RealStatusViaWiFi)
    {
        STLog(@"2222");
        keychainStore[@"ifnetUse"] = @"Useable";
    }

    if (status == RealStatusViaWWAN)
    {
        STLog(@"3333");
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

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
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


#pragma mark- JPUSHRegisterDelegate
//极光推送支持
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;

    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark - 处理远程推送的数据
-(void)dealPushM:(NSDictionary *)userInfo{

    self.window.rootViewController = [TabBarVC sharedVC];
}


/**
 *  @author DevelopmentEngineer-ST
 *  集成支付
 *  最老的版本，最好也写上
 */
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

    return [STPAYMANAGER st_handleUrl:url];
}
/**
 *  @author DevelopmentEngineer-ST
 *
 *  iOS 9.0 之前 会调用
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return [STPAYMANAGER st_handleUrl:url];
}
/**
 *  @author DevelopmentEngineer-ST
 *
 *  iOS 9.0 以上（包括iOS9.0）
 */

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{

    return [STPAYMANAGER st_handleUrl:url];
}


#pragma mark-xy ---------------------------------引导页-------------------------------
- (void)setFollow{
    _xyBgImgNameArr = @[@"loading1", @"loading2", @"loading3"];
    _xyIntroductionPage = [self example1];
    self.window.rootViewController = [TabBarVC sharedVC];//只用引导页的时候打开此项/跟启动页一起用的时候注释掉
    [self.window addSubview:_xyIntroductionPage.view];
}
//传统引导页
- (XYIntroductionPage *)example1{
    //可以添加gif动态图哦
    _xyBgImgNameArr = @[@"loading1", @"loading2", @"loading3"];
    XYIntroductionPage * xyPage = [[XYIntroductionPage alloc]init];
    xyPage.xyCoverImgArr = _xyBgImgNameArr;//设置浮层滚动图片数组
    xyPage.xyDelegate = self;//进入按钮事件代理
    xyPage.xyAutoScrolling = NO;//是否自动滚动
    xyPage.xyPageControl.hidden = YES;
    //可以自定义设置进入按钮样式
    [xyPage.xyEnterBtn setTitle:@"立即进入" forState:UIControlStateNormal];
    return xyPage;
}

#pragma mark-xy 启动页2 -广告
- (void)xyAdLaunch{
    _xyLaunch = [[XYLaunchVC alloc]initWithRootVC:[TabBarVC sharedVC] withLaunchType:XYLaunchAD];
    _xyLaunch.xyAdDuration = 16;
    _xyLaunch.xyDelegate = self;
    _xyLaunch.xyAdActionUrl = @"https://www.baidu.com";
    //    _xyLaunch.xyIsCloseTimer = YES;//跟引导页(XYIntroductionPage)一起用的时候要打开/否则关闭
    // 网络
    _xyLaunch.xyAdImgUrl = @"http://pic.qiantucdn.com/58pic/17/76/58/24K58PICsEp_1024.jpg";
    // 本地
    self.window.rootViewController = _xyLaunch;

}

//详情页代理
- (void)xyLaunchAdImgViewAction:(id)sender withObject:(id)object{
    STLog(@"JJJJJJ");
}
//进入按钮事件
- (void)xyIntroductionViewEnterTap:(id)sender{
    _xyIntroductionPage = nil;
    [UICKeyChainStore keyChainStore][@"firstIn"] =@"true";
    //[_xyLaunch xy_startFire];//和引导页(XYIntroductionPage)一起用的时候加上这句
}


@end
