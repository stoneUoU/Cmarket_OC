//
//  YYModelVC.m
//  Fishes
//
//  Created by test on 2018/3/30.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "YYModelVC.h"
#import "TestModel.h"
#import "SingleClass.h"
#import "CarouselMs.h"
@interface YYBook : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) uint64_t pages;
@property (nonatomic, strong) NSDate *publishDate;
@end

@implementation YYBook
@end


@interface Res : NSObject
@property NSString *msg;
@property NSUInteger code;
@property NSUInteger total;

@property NSMutableArray *data;
//@property MoveMs *data; //Book 包含 Author 属性
@end
@implementation Res
@end

@interface YYModelVC()
    {
        NSMutableArray *_data;
    }
@end

@implementation YYModelVC
- (id)init
{
    self.dataArrs = [NSMutableArray array];
    // 情景二：采用网络图片实现
    return [super init];
}
+ (void) SimpleObjectExample {
    YYBook *book = [YYBook modelWithJSON:@"{\"name\": \"Harry Potter\",\"pages\": 512,\"publishDate\": \"2010-01-01\"}"];   //json字符串转成模型
    NSString *bookJSON = [book modelToJSONString];   //m->jsonStr
    STLog(@"Book: %@", bookJSON);
    //STLog(@"%@", book.name);
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.

    [YYModelVC SimpleObjectExample];

    [self setUpUI];

    //[self startQ];
}
-(void)startQ{
    [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"carousel/list" withParaments:@{} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *dataDic in feedBacks[@"data"]) {
            TestModel *model = [[TestModel alloc] initWithDataDic:dataDic];
            [_data addObject:model];
        }
        TestModel *mds = _data[0];
        STLog(@"====%@",mds.title);
    } withFailureBlock:^(NSError *error) {
        [HudTips hideHUD:self];
        STLog(@"%@",error)
    }];
}
-(void)startR{
    [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"carousel/list" withParaments:@{} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
        STLog(@"%@",[feedBacks modelToJSONString]);
//        for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
//            MoveMs *moveMs = [MoveMs modelWithJSON:feedBacks[@"data"][i]];
//            [self.dataArrs addObject:moveMs];
//        }
//        MoveMs *moveMs = self.dataArrs[0];
//        STLog(@"%@",moveMs.ids);
        Res *res = [Res modelWithJSON:feedBacks];
        for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
            MoveMs *moveMs = [MoveMs modelWithJSON:feedBacks[@"data"][i]];
            //[self.dataArrs addObject:moveMs];
            [res.data addObject:moveMs];
        }
        MoveMs *moveMs = [MoveMs modelWithJSON:res.data[2]];
        STLog(@"%@",moveMs.title);

    } withFailureBlock:^(NSError *error) {
        [HudTips hideHUD:self];
        STLog(@"%@",error)
    }];
}


-(void)setUpUI{
    _weChat_payBtn = [[UIButton alloc] init];
    _weChat_payBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _weChat_payBtn.backgroundColor = [UIColor color_HexStr:@"3ab829"];
    _weChat_payBtn.layer.cornerRadius = 22;
    _weChat_payBtn.tag = 0;
    [_weChat_payBtn setTitle:@"微信支付 丫" forState:UIControlStateNormal];
    [_weChat_payBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_weChat_payBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_weChat_payBtn];

    _alipay_payBtn = [[UIButton alloc] init];
    _alipay_payBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _alipay_payBtn.backgroundColor = [UIColor color_HexStr:@"1083e6"];
    _alipay_payBtn.layer.cornerRadius = 22;
    _alipay_payBtn.tag = 1;
    [_alipay_payBtn setTitle:@"支付宝支付 丫" forState:UIControlStateNormal];
    [_alipay_payBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_alipay_payBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_alipay_payBtn];

    [self setMas];
}

-(void)setMas{
    [_weChat_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(4*StatusBarAndNavigationBarH);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_alipay_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weChat_payBtn.mas_bottom).offset(StatusBarAndNavigationBarH);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
}
- (void)toDo:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self sendWXpay];
            break;
        default:
            [self alipayM];
            break;
    }
}

- (void)sendWXpay {
    if ([STPAYMANAGER st_orInstall]){
        //微信支付丫：
        [STPAYMANAGER st_payWithOrderMessage:[STPAYMANAGER st_getWXPayParam:@{@"prepayid":@"1101000000140415649af9fc314aa427",@"package":@"Sign=WXPay",@"noncestr":@"a462b76e7436e98e0ed6e13c64b4fd1c",@"timestamp":@"1397527777",@"sign":@"582282D72DD2B03AD892830965F428CB16E7A256"}] callBack:^(STErrCode errCode, NSString *errStr) {
            STLog(@"errCode = %zd,errStr = %@",errCode,errStr);
        }];
    }
}

- (void)alipayM{
    /**
     *  @author DevelopmentEngineer-ST
     *
     *  来自支付宝文档数据
     */
    NSString *orderMessage = @"app_id=2015052600090779&biz_content=%7B%22timeout_express%22%3A%2230m%22%2C%22seller_id%22%3A%22%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%2C%22total_amount%22%3A%220.02%22%2C%22subject%22%3A%221%22%2C%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22out_trade_no%22%3A%22314VYGIAGG7ZOYY%22%7D&charset=utf-8&method=alipay.trade.app.pay&sign_type=RSA&timestamp=2016-08-15%2012%3A12%3A15&version=1.0&sign=MsbylYkCzlfYLy9PeRwUUIg9nZPeN9SfXPNavUCroGKR5Kqvx0nEnd3eRmKxJuthNUx4ERCXe552EV9PfwexqW%2B1wbKOdYtDIb4%2B7PL3Pc94RZL0zKaWcaY3tSL89%2FuAVUsQuFqEJdhIukuKygrXucvejOUgTCfoUdwTi7z%2BZzQ%3D";
    [STPAYMANAGER st_payWithOrderMessage:orderMessage callBack:^(STErrCode errCode, NSString *errStr) {
        STLog(@"errCode = %zd,errStr = %@",errCode,errStr);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
