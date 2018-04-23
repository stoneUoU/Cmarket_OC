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
    _hideFls = NO;
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

-(void)setCount:(NSInteger)restTime{
    __weak typeof(self) weakSelf = self;
    //倒计时时间
    __block NSInteger timeOut = restTime;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //weakSelf.orderDetailV.cancelTime.text = @"已结束";
                weakSelf.orderDetailV.cancelTime.hidden = YES;
                //在这里请求服务器:
                //[self startR:[_pass_Vals objectForKey:@"order_no"]];
            });
        } else {
            int allTime = (int)restTime + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (timeOut >= 60){
                    weakSelf.orderDetailV.cancelTime.text = [NSString stringWithFormat:@"距订单取消：%@分%@秒",[NSString stringWithFormat:@"%d",[timeStr intValue]/60],[NSString stringWithFormat:@"%d",[timeStr intValue]%60]];
                }else{
                    weakSelf.orderDetailV.cancelTime.text = [NSString stringWithFormat:@"距订单取消：%@秒",timeStr];
                }
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

// MARK: - OderDetailVDel
- (void)toToggleV {
    //第一步:创建控制器
    _hideFls = !_hideFls;
    if (_hideFls) {
        self.orderDetailV.ifCloseD = YES;
    }else{
        self.orderDetailV.ifCloseD = NO;
    }
    [self.orderDetailV.tableV reloadData];
}
-(void)startR:(NSString *)order_no{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"order/detail" withParaments:@{@"order_no":order_no} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            //进行容错处理丫:
            STLog(@"%@",[feedBacks modelToJSONString]);
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                OrderMs *orderMs = [OrderMs modelWithJSON:feedBacks[@"data"]];
                OrderSonAMs *orderSonAMs = [OrderSonAMs modelWithJSON:feedBacks[@"data"][@"address"]];
                [orderMs.address addObject:orderSonAMs];
                OrderSonRMs *orderSonRMs = [OrderSonRMs modelWithJSON:feedBacks[@"data"][@"refundment"]];
                [orderMs.refundment addObject:orderSonRMs];
                self.orderDetailV.orderMs = orderMs;
                [self setCount:5];
                [self.orderDetailV.tableV reloadData];
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
