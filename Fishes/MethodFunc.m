//
//  MethodFunc.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MethodFunc.h"
#import "AppDelegate.h"
@implementation MethodFunc

+ (void)popToRootVC:(UIViewController *)selfCtrl{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfCtrl.navigationController popToRootViewControllerAnimated:true];
    });
}

+ (void)backToHomeVC:(UIViewController *)selfCtrl{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfCtrl.navigationController popToRootViewControllerAnimated:true];
        //[AppDelegate getTabBarV].selectedIndex = 0;
    });
}

@end
