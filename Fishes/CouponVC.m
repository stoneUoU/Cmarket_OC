//
//  CouponVC.m
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CouponVC.h"



@implementation CouponVC
- (id)initWithParams:(NSString*) category_id andTotalO:(NSString*)totalO andRow:(NSString*)selRow
{
    _couponV = [[CouponV alloc] init]; //对MyUIView进行初始化
    _couponV.backgroundColor = [UIColor whiteColor];
    _couponV.delegate = self; //将SecondVC自己的实例作为委托对象
    _pass_Vals = @{@"category_id":category_id,@"totalO":totalO};
    _selRow = selRow;
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];
    _Auths = [UICKeyChainStore keyChainStore][@"authos"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNet:)
                                                 name:@"netChange" object:nil];
    [self setUpUI];
    [self startCR:[_pass_Vals objectForKey:@"category_id"] andTotalO:[_pass_Vals objectForKey:@"totalO"]];
}
//查询优惠券：
-(void)startCR:(NSString*) category_id andTotalO:(NSString*)totalO{
    if ([_netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"coupon/available" withParaments:@{@"category_id":category_id,@"order_total":totalO} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                    CouponMs *couponMs = [CouponMs modelWithJSON:feedBacks[@"data"][i]];
                    [self.couponV.couponMs addObject:couponMs];
                    [self.couponV.selInxs addObject:@0];
                }
                if (_selRow != NULL){
                    self.couponV.selInxs[[_selRow intValue]] = @1;
                }
                [self.couponV.tableV reloadData];
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
- (void)setUpUI{
    [self.view addSubview:_couponV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_couponV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(326*StScaleH);
    }];
}
#pragma  设置网络
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict = %@",dict);
    _netUseVals =  dict[@"ifnetUse"];
}
// MARK: - CouponVDel
- (void)toSelectC:(CouponMs *)couponMs andRow:(NSInteger)row {
    if (self.selRow != [NSString stringWithFormat:@"%ld",(long)row]){
        _selMs = couponMs;
        self.selRow = [NSString stringWithFormat:@"%ld",(long)row];
        self.couponV.selInxs[row] = @1;
        for (int i = 0; i < [self.couponV.selInxs count]; i++) {
            if (i != row){
                self.couponV.selInxs[i] = @0;
            }
        }
    }else{
        if ([self.couponV.selInxs[row]  isEqual: @0]){
            self.selRow = [NSString stringWithFormat:@"%ld",(long)row];
            self.couponV.selInxs[row] = @1;
            for (int i = 0; i < [self.couponV.selInxs count]; i++) {
                if (i != row){
                    self.couponV.selInxs[i] = @0;
                }
            }
        }else{
            for (int i = 0; i < [self.couponV.selInxs count]; i++) {
                self.couponV.selInxs[i] = @0;
            }
        }
    }
    [self.couponV.tableV reloadData];
}
-(void)toCloseSelf{
    if (_selRow != NULL){
        if (![self.couponV.selInxs[[self.selRow intValue]]  isEqual: @0]){
            _couponB(@{@"selMs":self.couponV.couponMs[[self.selRow intValue]] ,@"selRow":self.selRow}, YES);
        }
        //一个闭包不够用，当进入else的时候就无法通知firmorderVC该VC是否关闭;   因此增加一个闭包来操作
        else{
            _closeSelfB(@{@"closeSelf":@true}, YES);
        }
    }
    [self cb_dismissPopupViewControllerAnimated:YES completion:nil];
}
#pragma mark - Actions


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
