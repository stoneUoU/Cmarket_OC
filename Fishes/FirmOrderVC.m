//
//  FirmOrderVC.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "FirmOrderVC.h"
#import "CouponVC.h"
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
    self.firmOrderV.AC = [[_pass_Vals objectForKey:@"AC"] intValue];
    //两个请求，互不干扰
    [self startAR];
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
                for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                    MineAds *mineAds = [MineAds modelWithJSON:feedBacks[@"data"][i]];
                    [self.firmOrderV.mineAds addObject:mineAds];
                }
                [self reloadOneSection:[[NSIndexSet alloc]initWithIndex:0]];
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
                self.firmOrderV.totalM = [FormatDs retainPoint:@"0.00" floatV:[homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [homeDetailMs.actual_logistics_fee intValue]];
                self.firmOrderV.totalFee.attributedText=[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [homeDetailMs.actual_logistics_fee intValue]]] andSymbolsC:styleColor];
                [self reloadOneSection:[[NSIndexSet alloc]initWithIndex:1]];
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
-(void)startPR:(NSString *)coupon_code_id andGroupId:(NSString *)group_id andAC:(NSInteger)AC andAddressId:(NSString *)address_id andPayM:(NSString *)payM{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        //微信支付:1     支付宝支付:2
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"order/add" withParaments:(coupon_code_id != NULL? @{@"group_id":group_id,@"num":[NSNumber numberWithInt:(int)AC],@"address_id":address_id,@"pay_channel":@1,@"pay_type":payM ,@"coupon_code_id": coupon_code_id} : @{@"group_id":group_id,@"num":[NSNumber numberWithInt:(int)AC],@"address_id":address_id,@"pay_channel":@1,@"pay_type":payM }) Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
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
    //支付，拉起支付宝、微信，哈哈
    MineAds *mineAds = self.firmOrderV.mineAds[0];
    [self startPR:self.firmOrderV.selMs.coupon_code_id andGroupId:[NSString stringWithFormat:@"%@",[_pass_Vals objectForKey:@"group_id"]] andAC:self.firmOrderV.AC andAddressId:mineAds.ids andPayM:[NSString stringWithFormat:@"%ld",(long)self.firmOrderV.selectM]];
}
- (void)toCoupon {    _popAligment  = CBPopupViewAligmentBottom;
    CouponVC *vc = [[CouponVC alloc] initWithParams:self.firmOrderV.homeDetailMs.category_id andTotalO:[NSString stringWithFormat:@"%ld",[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC] andRow:self.selRow];
    vc.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 326*StScaleH);
    vc.couponB = ^(NSDictionary *dict, BOOL b){
        self.firmOrderV.selMs = [dict objectForKey:@"selMs"];
        self.selRow = [dict objectForKey:@"selRow"];
        STLog(@"%@",[self.firmOrderV.selMs modelToJSONString]);
        switch (self.firmOrderV.selMs.coupon_type) {
            case 1:  //满减
            {
                self.firmOrderV.totalM = [FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue] - [self.firmOrderV.selMs.face_value floatValue]];
                self.firmOrderV.totalFee.attributedText=[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue]- [self.firmOrderV.selMs.face_value floatValue]]] andSymbolsC:styleColor];
            }
                break;
            default:
            {
                self.firmOrderV.totalM = [FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue] - [self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC*(100 - self.firmOrderV.selMs.discount)/100];

                self.firmOrderV.totalFee.attributedText=[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue]- [self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC*(100 - self.firmOrderV.selMs.discount)/100]] andSymbolsC:styleColor];
            }
                break;
        }
        [self reloadOneSection:[[NSIndexSet alloc]initWithIndex:1]];
    };
    vc.closeSelfB= ^(NSDictionary *dict, BOOL b){
        self.firmOrderV.selMs = NULL;
        self.selRow = NULL;
        self.firmOrderV.totalM = [FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue]];

        self.firmOrderV.totalFee.attributedText=[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue]]] andSymbolsC:styleColor];
        [self reloadOneSection:[[NSIndexSet alloc]initWithIndex:1]];
    };
    [self cb_presentPopupViewController:vc animationType:CBPopupViewAnimationSlideFromBottom aligment:_popAligment overlayDismissed:nil];
}
- (void)toRealN {
    STLog(@"实名丫");
}
- (void)toEditAs {
    STLog(@"编辑地址丫");
}
- (void)toPlusDescC:(NSInteger)AC{
    self.firmOrderV.selMs = NULL;
    self.selRow = NULL;
    self.firmOrderV.AC = AC;
    self.firmOrderV.totalM = [FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue]];
    self.firmOrderV.totalFee.attributedText=[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[self.firmOrderV.homeDetailMs.discount_price intValue] * self.firmOrderV.AC + [self.firmOrderV.homeDetailMs.actual_logistics_fee intValue]]] andSymbolsC:styleColor];
    [self reloadOneSection:[[NSIndexSet alloc]initWithIndex:1]];
}
//reloadSections时的1section的数据
-(void)reloadOneSection:(NSIndexSet *)indexSet{
    //解决reloadSections时的闪动问题
    [UIView performWithoutAnimation:^{
        [self.firmOrderV.tableV reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//- (void)placeholderView:(STPlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender {
//    <#code#>
//}
@end
