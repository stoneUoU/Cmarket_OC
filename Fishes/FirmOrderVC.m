//
//  FirmOrderVC.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "FirmOrderVC.h"
@implementation FirmOrderVC
- (id)init
{
    _firmOrderV = [[FirmOrderV alloc] init]; //对MyUIView进行初始化
    _firmOrderV.backgroundColor = [UIColor whiteColor];
    _firmOrderV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"确认下单" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
//    STLog(@"%@",[_pass_Vals objectForKey:@"group_id"]);
//    STLog(@"%@",[_pass_Vals objectForKey:@"amount"]);
    [self startGR];
}
- (void)setUpUI{
    [self.view addSubview:_firmOrderV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_firmOrderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH-StatusBarAndNavigationBarH);
    }];
}
//查询收货地址
-(void)startAR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/address/list" withParaments:@{@"default":@0,@"page":@1,@"limit":@1} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                //STLog(@"成功");
                for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                    MineAds *mineAds = [MineAds modelWithJSON:feedBacks[@"data"][i]];
                    [self.firmOrderV.mineAds addObject:mineAds];
                }
                [self.firmOrderV.tableV reloadData];
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
//查询商品详情
-(void)startGR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"group/detail" withParaments:@{@"group_id":[NSString stringWithFormat:@"%@",[_pass_Vals objectForKey:@"group_id"]]} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
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
                self.firmOrderV.homeDetailMs = homeDetailMs;
                [self.firmOrderV.tableV reloadData];
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

//查询优惠券：
-(void)startCR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"coupon/available" withParaments:@{@"category_id":@"123",@"order_total":@"price*amount"} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                STLog(@"成功");
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

//去支付，拉起微信支付宝
-(void)startPR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        //self.coupon_id != "" ? ["group_id":Int(self.GoodID)!,"num":self.amount,"address_id":Int(self.firmLocalMs[0].id)!,"pay_channel":1,"pay_type":self.firmOrderV.checkVals == "微信支付" ? 1 : 2 ,"coupon_code_id": Int(self.coupon_id)!] as [String : Any] : ["group_id":Int(self.GoodID)!,"num":self.amount,"address_id":Int(self.firmLocalMs[0].id)!,"pay_channel":1,"pay_type":self.firmOrderV.checkVals == "微信支付" ? 1 : 2 ] as [String : Any]
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"order/add" withParaments:@{@"category_id":@"123",@"order_total":@"price*amount"} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                STLog(@"成功");
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

// MARK: - FirmOrderVDel
- (void)toPlaceO {
    //[MethodFunc popToRootVC:self];
    STLog(@"立即支付");
}
- (void)toCoupon {
    //[MethodFunc popToRootVC:self];
    STLog(@"%ld",(long)self.firmOrderV.selectM);
}
- (void)toRealN {
    //[MethodFunc popToRootVC:self];
    STLog(@"实名丫");
}
- (void)toEditAs {
    STLog(@"编辑地址丫");
    //[MethodFunc popToRootVC:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
