//
//  OrderListVC.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderListVC.h"
@implementation OrderListVC
- (id)init
{
    _orderListV = [[OrderListV alloc] init]; //对MyUIView进行初始化
    _orderListV.backgroundColor = [UIColor whiteColor];
    _orderListV.delegate = self;
    _pageSize = 10;
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];
    _Auths = [UICKeyChainStore keyChainStore][@"authos"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
    [self setUpUI];
    [self startR:0];

    STLog(@"%@",[_pass_Vals objectForKey:@"ids"]);
}
- (void)setUpUI{
    [self.view addSubview:_orderListV];
    //添加约束
    [self setMas];
}

- (void) setMas{
    [_orderListV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

//发送网络请求：（查询个人信息R）
-(void)startR:(NSInteger )ifR{
    if ([_netUseVals isEqualToString: @"Useable"]){
        //"consumer_status":self.intIndex
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"order/list" withParaments:@{@"page":@1,@"limit":@(_pageSize)} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            //STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                if (![[NSString stringWithFormat:@"%@",feedBacks] isEqualToString:[NSString stringWithFormat:@"%@",[YYCacheTools resCacheForURL:@"order/list"]]]){
                    //将返回的数据存入YYCache
                    [YYCacheTools setResCache:feedBacks url:@"order/list"];
                    STLog(@"不相同");
                    for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                        OrderMs *orderMs = [OrderMs modelWithJSON:feedBacks[@"data"][i]];
                        [self.orderListV.orderMs addObject:orderMs];
                        OrderSonAMs *orderSonAMs = [OrderSonAMs modelWithJSON:feedBacks[@"data"][i][@"address"]];
                        [orderMs.address addObject:orderSonAMs];
                        OrderSonRMs *orderSonRMs = [OrderSonRMs modelWithJSON:feedBacks[@"data"][i][@"refundment"]];
                        [orderMs.refundment addObject:orderSonRMs];
                    }
                    OrderMs *orderMs = self.orderListV.orderMs[0];
                    STLog(@"%@",orderMs.group_title);

                    OrderSonAMs *orderSonAMs  = orderMs.address[0];
                    STLog(@"%@",orderSonAMs.consignee_address);
                    [self.orderListV.tableV reloadData];
                }else{
                    STLog(@"相同");
                    for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                        OrderMs *orderMs = [OrderMs modelWithJSON:feedBacks[@"data"][i]];
                        [self.orderListV.orderMs addObject:orderMs];
                        OrderSonAMs *orderSonAMs = [OrderSonAMs modelWithJSON:feedBacks[@"data"][i][@"address"]];
                        [orderMs.address addObject:orderSonAMs];
                        OrderSonRMs *orderSonRMs = [OrderSonRMs modelWithJSON:feedBacks[@"data"][i][@"refundment"]];
                        [orderMs.refundment addObject:orderSonRMs];
                    }
                    OrderMs *orderMs = self.orderListV.orderMs[0];
                    STLog(@"%@",orderMs.group_title);

                    OrderSonAMs *orderSonAMs  = orderMs.address[0];
                    STLog(@"%@",orderSonAMs.consignee_address);
                    [self.orderListV.tableV reloadData];
                }
//                if (ifR == 0){
//                    [self.mineV.tableV.mj_header endRefreshing];
//                }
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
//                if (ifR == 0){
//                    [self.mineV.tableV.mj_header endRefreshing];
//                }
            }
        } withFailureBlock:^(NSError *error) {
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}

//OrderListVdel
-(void)toGo:(NSInteger)section row:(NSInteger)row{
    STLog(@"点击");
}
-(void)toRefresh{
    STLog(@"8888");
}

//网络监测通知：
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict = %@",dict);
    _netUseVals =  dict[@"ifnetUse"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
