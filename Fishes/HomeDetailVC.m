//
//  HomeDetailVC.m
//  Fishes
//
//  Created by test on 2017/11/29.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "HomeDetailVC.h"
#import "StartVC.h"
#import "PopPresentAnimation.h"
#import "PopDismissAnimation.h"
#import "PopPresentVC.h"
#import "FirmOrderVC.h"

@implementation HomeDetailVC
- (id)init
{
    //初始化HomeDetailV
    _homeDetailV = [[HomeDetailV alloc] init]; //对_homeDetailV进行初始化
    _homeDetailV.delegate = self; //将HomeDetailV自己的实例作为委托对象
    _IMGs = [NSMutableArray array];
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];
    _Auths = [UICKeyChainStore keyChainStore][@"authos"];
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNet:)
                                                 name:@"netChange" object:nil];
    [self setUpUI];
    [self startR];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}
-(void) setUpUI{
    [self.view addSubview:_homeDetailV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_homeDetailV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

-(void)startR{
    if ([_netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"group/detail" withParaments:@{@"group_id":[NSString stringWithFormat:@"%@",[_pass_Vals objectForKey:@"group_id"]]} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                HomeDetailMs *homeDetailMs = [HomeDetailMs modelWithJSON:feedBacks[@"data"]];
                for (int i = 0; i < [feedBacks[@"data"][@"attr_value"] count]; i++) {
                    HomeDetailSonMs *homeDetailSonMs = [HomeDetailSonMs modelWithJSON:feedBacks[@"data"][@"attr_value"][i]];
                    [homeDetailMs.attr_value_list addObject:homeDetailSonMs];
                }
                for (int i = 0 ; i < [feedBacks[@"data"][@"banner"] count]; i++) {
                    [homeDetailMs.banner_list addObject:[picUrl stringByAppendingString:feedBacks[@"data"][@"banner"][i]]];
                }
                HomeDetailMs* testMs = homeDetailMs;
                self.homeDetailV.homeDetailMs = homeDetailMs;
                [self.homeDetailV.tableV reloadData];
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [HudTips showToast:missSsidTips showType:Pos animationType:StToastAnimationTypeScale];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
#pragma  设置网络
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict = %@",dict);
    _netUseVals =  dict[@"ifnetUse"];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (BOOL)hidesBottomBarWhenPushed
{
    return (self.navigationController.topViewController == self);
}
#pragma mark - HomeDetailVDel
-(void) toDo{
    if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
        //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
        StartVC * startV = [[StartVC alloc] init];
        startV.pass_Vals = @{@"status_code":@"1"};
        [MethodFunc presentToNaviVC:self destVC:startV];
    }else{
        PopPresentVC * popPresentV = [PopPresentVC new];
        popPresentV.popPresentV.homeDetailMs = self.homeDetailV.homeDetailMs;
        popPresentV.dictB = ^(NSDictionary *dict, BOOL b){
            FirmOrderVC *vc = [[FirmOrderVC alloc]init];
            vc.pass_Vals = @{@"group_id":[_pass_Vals objectForKey:@"group_id"],@"AC":[dict objectForKey:@"AC"]};
            [MethodFunc pushToNextVC:self destVC:vc ];
        };
        popPresentV.modalPresentationStyle = UIModalPresentationCustom;
        popPresentV.transitioningDelegate = self;
        [self presentViewController:popPresentV animated:YES completion:nil];
    }
}

//mark://UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PopPresentAnimation new];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PopDismissAnimation new];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//   实现方式1:通知
//在本VC中:
//定一个popPresentV关闭后界面跳转的notice
//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToFirmVC:) name:@"mynoti" object:nil];
////方法:监听到通知之后调用的方法
//- (void)pushToFirmVC:(NSNotification *)noti {
//    STLog(@"%@",[noti.object objectForKey:@"num"]);
//    //self.view.backgroundColor = noti.object;
//    [MethodFunc pushToNextVC:self destVC:[[FirmOrderVC alloc]init] ];
//}
//- (void)dealloc {
//    // 移除监听者
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"mynoti" object:nil];
//}

//在PopPresentVC中
//[[NSNotificationCenter defaultCenter] postNotificationName:@"mynoti" object:@{@"num":@102}];

//  实现方式2:代理
//  在本VC中:

//遵循代理协议
//@interface HomeDetailVC()<PopPresentVCDel>{
//
//}
//@end
//设置代理本身
//PopPresentVC * popPresentV = [PopPresentVC new];
//popPresentV.delegate = self;
//popPresentV.modalPresentationStyle = UIModalPresentationCustom;
//popPresentV.transitioningDelegate = self;
//[self presentViewController:popPresentV animated:YES completion:nil];
//实现代理方法
//- (void)toPushPage:(NSDictionary *)dict {
//    STLog(@"%@",[dict objectForKey:@"num"]);
//    [MethodFunc pushToNextVC:self destVC:[[FirmOrderVC alloc]init] ];
//}


//在PopPresentVC中
//PopPresentVC.h文件
// 定制传值协议
//@protocol PopPresentVCDel <NSObject>
//- (void)toPushPage:(NSDictionary *)dict;
//@end
// 定义代理属性
//@property (weak, nonatomic) id<PopPresentVCDel> delegate;

//PopPresentVC.m文件

// 代理属性调用代理方法
//if ([_delegate respondsToSelector:@selector(toPushPage:)]) {
//    // 调用代理方法并传入红色
//    [_delegate toPushPage:@{@"num":@109}];
//}


//实现方式3：
//在PopPresentVC中
//PopPresentVC.h文件
// 定义一个block:  返回值(^Block名)(参数类型)
//typedef void(^DictB)(NSDictionary *, BOOL);
// 声明一个闭包
// @property (nonatomic, strong) DictB dictB;

//PopPresentVC.m文件
//调用block传参,让预置块代码执行
//_dictB(@{@"name":@"oooooo"}, YES);

//  在本VC中:
//PopPresentVC * popPresentV = [PopPresentVC new];
//popPresentV.dictB = ^(NSDictionary *dict, BOOL b){
//    STLog(@"%@",[dict objectForKey:@"name"]);
//    [MethodFunc pushToNextVC:self destVC:[[FirmOrderVC alloc]init] ];
//};
//popPresentV.modalPresentationStyle = UIModalPresentationCustom;
//popPresentV.transitioningDelegate = self;
//[self presentViewController:popPresentV animated:YES completion:nil];



//- (void)goBuy:(id)sender{
//    //如果没有导航栏，就进行这种跳转；
//    //STLog(@"%@",self.netUseVals);
//    //[HudTips showToast: self.netUseVals showType:Pos animationType:StToastAnimationTypeScale];
//    if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
//        //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
//        StartVC * startV = [[StartVC alloc] init];
//        startV.pass_Vals = @{@"status_code":@"1"};
//        [MethodFunc presentToNaviVC:self destVC:startV];
//    }else{
//        STLog(@"已登录,去拼单");
//    }
//}





@end
