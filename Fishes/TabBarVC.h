//
//  TabBarVC.h
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBar.h"
#import "StartVC.h"
@interface TabBarVC : UITabBarController<UITabBarControllerDelegate>
//自定义导航栏
+(TabBarVC *)sharedVC;
@end
