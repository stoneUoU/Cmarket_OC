//
//  AppDelegate.h
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
// 引入JPush功能所需头文件(极光推送)
#import "JPUSHService.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>
@property (strong, nonatomic) UIWindow *window;
//+ (void)setTabBarV:(UITabBarController *)tabBar;
//+ (UITabBarController *)getTabBarV;
@end

