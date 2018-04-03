//
//  MethodFunc.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MethodFunc.h"
#import "TabBarVC.h"
#import "HomeVC.h"
#import "StartVC.h"
@implementation MethodFunc


+ (void)presentToCommVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC presentViewController:destVC animated:NO completion:nil];
    });
}


+ (void)presentToNaviVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC presentViewController:[[UINavigationController alloc] initWithRootViewController:destVC] animated:NO completion:nil];
    });
}

+ (void)dismissCurrVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC dismissViewControllerAnimated:NO completion:nil];
    });
}

+ (void)pushToNextVC:(UIViewController *)selfVC destVC:(UIViewController *)destVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController pushViewController:destVC animated:YES];
    });
}

+ (void)popToPrevVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popViewControllerAnimated:YES];
    });
}

//+ (void)popToSpecialVC:(UIViewController *)selfVC specialVC:()specialVC{
//}

+ (void)popToRootVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popToRootViewControllerAnimated:YES];
    });
}

+ (void)backToHomeVC:(UIViewController *)selfVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfVC.navigationController popToRootViewControllerAnimated:YES];
    });
    [TabBarVC sharedVC].selectedIndex = 0;  //不能将这行代码放到主线程中执行
}

+ (UIViewController *)getCurrVC{
    UIViewController *resVC = nil;

    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        resVC = nextResponder;
    else
        resVC = window.rootViewController;

    return resVC;
}

+ (void)dealAuthMiss:(UIViewController *)selfVC tipInfo:(NSString *)tipInfo{
    [HudTips showToast:tipInfo showType:Pos animationType:StToastAnimationTypeScale];
    //清空用户信息
    [UICKeyChainStore keyChainStore][@"orLogin"] = @"false";
    [UICKeyChainStore keyChainStore][@"authos"] = @"";
    //Mark:弹出登录视图，登录失效是:status_code:0
    StartVC * startV = [[StartVC alloc] init];
    startV.pass_Vals = @{@"status_code":@"0",@"selfVC":selfVC};
    [MethodFunc presentToNaviVC:selfVC destVC:startV];
}

@end
