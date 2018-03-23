//
//  MineViewC.m
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "MineVC.h"

@interface MineVC ()

@end

@implementation MineVC
- (id)init
{
    _mineV = [[MineV alloc] init]; //对MyUIView进行初始化
    _mineV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = allBgColor;

    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
    [self setUpUI];
    [self startR];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}
- (void)setUpUI{
    [self.view addSubview:_mineV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_mineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}


//发送网络请求：（查询个人信息R）
-(void)startR{

    if ([_netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/list" withParaments:@{} Authos:defineAuths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            self.mineV.mineMs = [[MineMs alloc] initMs:feedBacks[@"data"][@"nick_name"] gender:feedBacks[@"data"][@"gender"] tel:feedBacks[@"data"][@"tel"] avatar:feedBacks[@"data"][@"avatar"] birthday:feedBacks[@"data"][@"birthday"] user_name:feedBacks[@"data"][@"user_name"] customer_service_tel:feedBacks[@"data"][@"customer_service_tel"] has_pay:feedBacks[@"data"][@"order_num"][@"has_pay"] no_pay:feedBacks[@"data"][@"order_num"][@"no_pay"] over:feedBacks[@"data"][@"order_num"][@"over"] no_delivery:feedBacks[@"data"][@"order_num"][@"no_delivery"]];
            [self.mineV.tableV reloadData];
            //STLog(@"%@",feedBacks);
            //STLog(@"%@",[picUrl stringByAppendingString:feedBacks[@"data"][@"avatar"]]);
            //            [self.mineV.iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:feedBacks[@"data"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
            //            self.mineV.user_name.text = feedBacks[@"data"][@"nick_name"];
            //            self.mineV.phone_str.text = feedBacks[@"data"][@"tel"];
            //[self.mineV.tableV reloadData];
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast:self text:missNetTips showType:Pos animationType:StToastAnimationTypeScale];
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
// MARK: - MineVDel
- (void)toMsg {
    STLog(@"去消息模块");
}

- (void)toRefresh {
    // 模拟网络请求，1秒后结束刷新
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mineV.tableV.mj_header endRefreshing];
    });
}

//通知模块代码：
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    _netUseVals =  dict[@"ifnetUse"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
