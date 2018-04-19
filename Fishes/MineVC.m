//
//  MineViewC.m
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "MineVC.h"
#import "AccountInfoVC.h"
#import "AboutUsVC.h"
#import "SetVC.h"
#import "MineOrderVC.h"
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
    _Auths = [UICKeyChainStore keyChainStore][@"authos"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
    [self setUpUI];
    [self setClosure];
}

- (void) setClosure{
    AccountInfoVC *accountV=[AccountInfoVC shareIns];
    accountV.nickB = ^(NSDictionary *dict, BOOL b){
        STLog(@"%@",[dict objectForKey:@"postN"]);
        [self startR:1];
    };
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
    [self startR:1];
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
-(void)startR:(NSInteger )ifR{
    if([YYCacheTools isCacheExist:@"user/list"]){
        [self setCache];
    }
    if ([_netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/list" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                if (![[NSString stringWithFormat:@"%@",feedBacks] isEqualToString:[NSString stringWithFormat:@"%@",[YYCacheTools resCacheForURL:@"user/list"]]]){
                    //将返回的数据存入YYCache
                    [YYCacheTools setResCache:feedBacks url:@"user/list"];
                    MineMs *mineMs = [MineMs modelWithJSON:feedBacks[@"data"]];
                    MineSonMs *mineSonMs = [MineSonMs modelWithJSON:feedBacks[@"data"][@"order_num"]];
                    self.mineV.mineMs = mineMs;
                    self.mineV.mineSonMs = mineSonMs;
                    [self.mineV.tableV reloadData];
                }
                if (ifR == 0){
                    [self.mineV.tableV.mj_header endRefreshing];
                }
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                if (ifR == 0){
                    [self.mineV.tableV.mj_header endRefreshing];
                }
            }
        } withFailureBlock:^(NSError *error) {
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
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
    //STLog(@"去消息模块");
//    AccountInfoVC *accountV=[[AccountInfoVC alloc]init ];
//    accountV.nickB = ^(NSDictionary *dict, BOOL b){
//        STLog(@"%@",[dict objectForKey:@"postN"]);
//        [self startR:1];
//    };
    [MethodFunc pushToNextVC:self destVC:[[AccountInfoVC alloc]init ]];
}
- (void)toOrder {
    [MethodFunc pushToNextVC:self destVC:[[MineOrderVC alloc]initWithIds:0]];
}
- (void)toNextVC:(NSString *)section row:(NSString *)row{
    switch ([section integerValue]) {
        case 0:{
            if ([row  isEqual: @"0"]) {
                STLog(@"我的优惠券");
            }else{
                STLog(@"摊位管理");
            }
            break;
        }
        case 1:{
            STLog(@"收货地址");
            break;
        }
        case 2:{
            if ([row  isEqual: @"0"]) {
                STLog(@"联系客服");
            }else{
                [MethodFunc pushToNextVC:self destVC:[[SetVC alloc] init]];
            }
            break;
        }
        default:
            [MethodFunc pushToNextVC:self destVC:[[AboutUsVC alloc] init]];
            break;
    }
}
- (void)toWpay {
    MineOrderVC * vc=[[MineOrderVC alloc]initWithIds:1];
    [MethodFunc pushToNextVC:self destVC:vc];
}
- (void)toPdan {
    MineOrderVC * vc=[[MineOrderVC alloc]initWithIds:2];
    [MethodFunc pushToNextVC:self destVC:vc];
}
- (void)toWrece {
    MineOrderVC * vc=[[MineOrderVC alloc]initWithIds:3];
    [MethodFunc pushToNextVC:self destVC:vc];
}
- (void)toOver {
    MineOrderVC * vc=[[MineOrderVC alloc]initWithIds:4];
    [MethodFunc pushToNextVC:self destVC:vc];
}

- (void)toRefresh {
    // 模拟网络请求，1秒后结束刷新
    [self startR:0];
}

//通知模块代码：
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    _netUseVals =  dict[@"ifnetUse"];
}
-(void)setCache{
    MineMs *mineMs = [MineMs modelWithJSON:[YYCacheTools resCacheForURL:@"user/list"][@"data"]];
    MineSonMs *mineSonMs = [MineSonMs modelWithJSON:[YYCacheTools resCacheForURL:@"user/list"][@"data"][@"order_num"]];
    self.mineV.mineMs = mineMs;
    self.mineV.mineSonMs = mineSonMs;
    [self.mineV.tableV reloadData];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
