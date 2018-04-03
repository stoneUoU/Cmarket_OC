//
//  HomeDetailVC.m
//  Fishes
//
//  Created by test on 2017/11/29.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "HomeDetailVC.h"
#import "StartVC.h"

@implementation HomeDetailVC
- (id)init
{
    //初始化HomeDetailV
    _homeDetailV = [[HomeDetailV alloc] init]; //对_homeDetailV进行初始化
    _homeDetailV.delegate = self; //将HomeDetailV自己的实例作为委托对象

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
                STLog(@"%@",[feedBacks modelToJSONString]);
                self.homeDetailV.homeDetailMs = [[HomeDetailMs alloc] initMs:feedBacks[@"data"][@"start_time"] total_inventory:feedBacks[@"data"][@"total_inventory"] qty:feedBacks[@"data"][@"qty"] group_id:feedBacks[@"data"][@"group_id"] freeze_inventory:feedBacks[@"data"][@"freeze_inventory"] vendor:feedBacks[@"data"][@"vendor"] volume:feedBacks[@"data"][@"volume"] price:feedBacks[@"data"][@"price"]  status:feedBacks[@"data"][@"status"] end_time:feedBacks[@"data"][@"end_time"] turnover:feedBacks[@"data"][@"turnover"] discount_price:feedBacks[@"data"][@"discount_price"] detail:feedBacks[@"data"][@"detail"] title:feedBacks[@"data"][@"title"] vendor_id:feedBacks[@"data"][@"vendor_id"] small_pic:feedBacks[@"data"][@"small_pic"]  logistics_fee:feedBacks[@"data"][@"logistics_fee"] actual_logistics_fee:feedBacks[@"data"][@"actual_logistics_fee"] type:feedBacks[@"data"][@"type"] subtitle:feedBacks[@"data"][@"subtitle"] vendor_avatar:feedBacks[@"vendor_avatar"][@"detail"] category_id:feedBacks[@"data"][@"category_id"] attr_value:feedBacks[@"data"][@"attr_value"][0][@"attr_value"]];
                for (int i = 0 ; i < [feedBacks[@"data"][@"banner"] count]; i++) {
                    [self.homeDetailV.imgStrGroup addObject:[picUrl stringByAppendingString:feedBacks[@"data"][@"banner"][i]]];
                }
                [self.homeDetailV.tableV reloadData];
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [HudTips showToast:missSsidTips showType:Pos animationType:StToastAnimationTypeScale];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
            //[self.mineV.iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:feedBacks[@"data"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HomeDetailVDel
-(void) toDo{
    if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
        //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
        StartVC * startV = [[StartVC alloc] init];
        startV.pass_Vals = @{@"status_code":@"1"};
        [MethodFunc presentToNaviVC:self destVC:startV];
    }else{
        STLog(@"已登录,去拼单");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
