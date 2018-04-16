//
//  OrderDetailVC.m
//  Fishes
//
//  Created by test on 2018/4/16.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderDetailVC.h"

@implementation OrderDetailVC
- (id)init
{
    _orderDetailV = [[OrderDetailV alloc] init]; //对MyUIView进行初始化
    _orderDetailV.backgroundColor = [UIColor whiteColor];
    _orderDetailV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"订单详情" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
    [self startR:[_pass_Vals objectForKey:@"order_no"]];
}
- (void)setUpUI{
    [self.view addSubview:_orderDetailV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_orderDetailV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - OderDetailVDel
- (void)toR {
    //第一步:创建控制器
}
-(void)startR:(NSString *)order_no{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"order/detail" withParaments:@{@"order_no":order_no} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            //STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                OrderMs *orderMs = [OrderMs modelWithJSON:feedBacks[@"data"]];
                OrderSonAMs *orderSonAMs = [OrderSonAMs modelWithJSON:feedBacks[@"data"][@"address"]];
                [orderMs.address addObject:orderSonAMs];
                OrderSonRMs *orderSonRMs = [OrderSonRMs modelWithJSON:feedBacks[@"data"][@"refundment"]];
                [orderMs.refundment addObject:orderSonRMs];
                self.orderDetailV.orderMs = orderMs;
                OrderMs *testOMs = self.orderDetailV.orderMs;
                OrderSonAMs *testMs = testOMs.address[0];
                STLog(@"%@",testMs.consignee_address);
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
