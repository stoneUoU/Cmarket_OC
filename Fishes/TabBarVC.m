//
//  TabBarVC.m
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "TabBarVC.h"
//#import "NavigationVC.h"

#import "MineVC.h"
#import "HomeVC.h"

#import "UIImage+Image.h"

@implementation TabBarVC
//定义一个静态变量，实现登录后的跳转界面
static TabBarVC *tabVC = nil;
+(TabBarVC *)sharedVC{
    @synchronized(self){
        if(tabVC == nil){
            tabVC = [[self alloc] init];
        }
    }
    return tabVC;
}

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = styleColor;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVc];


    //注意，shouldSelectViewController此方法得设置这个代理
    self.delegate = self;
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    TabBar *tabbar = [[TabBar alloc] init];
    tabbar.delegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{

    HomeVC *homeV = [[HomeVC alloc] init];
    [self setUpOneChildVcWithVc:homeV Image:@"wode-weidianjijki" selectedImage:@"wode-dianjijki" title:@"活动"];
    
    MineVC *mineV = [[MineVC alloc] init];
    [self setUpOneChildVcWithVc:mineV Image:@"shouye-weidianji" selectedImage:@"shouye-dianji" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;

    [self addChildViewController:nav];
    
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([[NSString stringWithFormat:@"%@",viewController.tabBarItem.title]  isEqualToString: @"我的"]){
        //取是否登录
        if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
            //Mark 弹出登录视图：进app直接点我的tab登录:status_code:2
            StartVC * startV = [[StartVC alloc] init];
            startV.pass_Vals = @{@"status_code":@"2"};
            [MethodFunc presentToNaviVC:self destVC:startV];
            return NO;
        }else{
            return YES;
        }
    }else{
        return YES;
    }
}
- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}
@end
