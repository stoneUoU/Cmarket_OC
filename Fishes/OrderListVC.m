//
//  OrderListVC.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderListVC.h"
#import "OrderDetailVC.h"
@implementation OrderListVC
- (id)init
{
    _orderListV = [[OrderListV alloc] init]; //对MyUIView进行初始化
    _orderListV.backgroundColor = [UIColor whiteColor];
    _orderListV.delegate = self;
    _pageSize = 10;
    _pageInt = 1;
    _totalMount = 0;
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
    [self startR:1 andTab:[[_pass_Vals objectForKey:@"ids"] intValue] andR:1 andL:1];
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

//发送网络请求：（查询个人信息R） andTab:在那个tab   andNoData:从空数据图上点过来的
-(void)startR:(NSInteger )pageInt andTab:(NSInteger )inTab andR:(NSInteger )ifR andL:(NSInteger)ifL{
    //ifL: 0->true  1->false
    if (ifL == 1) {   //没上拉加载才setCache
        if([YYCacheTools isCacheExist:@"order/list"]){
            [self setCache];
        }
    }
    if ([_netUseVals isEqualToString: @"Useable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
        STLog(@"%@",inTab == 0 ? @{@"page":@(_pageInt),@"limit":@(_pageSize)} : @{@"page":@(_pageInt),@"limit":@(_pageSize),@"consumer_status":@(inTab)});
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"order/list" withParaments:inTab == 0 ? @{@"page":@(_pageInt),@"limit":@(_pageSize)} : @{@"page":@(_pageInt),@"limit":@(_pageSize),@"consumer_status":@(inTab)} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            //STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:（上拉加载绝对是走这里）注：没拍出上拉加载数据与前一页相同的情况
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                if (![[NSString stringWithFormat:@"%@",feedBacks] isEqualToString:[NSString stringWithFormat:@"%@",[YYCacheTools resCacheForURL:@"order/list"]]]){
                    if (ifL == 1) {
                        [self.orderListV.orderMs removeAllObjects];
                        //将返回的数据存入YYCache   上拉加载就不用存如cache
                        [YYCacheTools setResCache:feedBacks url:@"order/list"];
                    }
                    //STLog(@"不相同");
                    if ( [feedBacks[@"data"] count] == 0){
                        if (_placeholderV == nil){
                            _placeholderV = [[STPlaceholderView alloc]initWithFrame:self.view.bounds type:STPlaceholderViewTypeNoData delegate:self];
                            [self.view addSubview:_placeholderV];
                        }
                    }else{
                        [_placeholderV removeAllSubviews];
                        _placeholderV = nil;
                        for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                            OrderMs *orderMs = [OrderMs modelWithJSON:feedBacks[@"data"][i]];
                            OrderSonAMs *orderSonAMs = [OrderSonAMs modelWithJSON:feedBacks[@"data"][i][@"address"]];
                            [orderMs.address addObject:orderSonAMs];
                            OrderSonRMs *orderSonRMs = [OrderSonRMs modelWithJSON:feedBacks[@"data"][i][@"refundment"]];
                            [orderMs.refundment addObject:orderSonRMs];
                            [self.orderListV.orderMs addObject:orderMs];
                        }
                    }
                }
                if (ifR == 0){
                    [self.orderListV.tableV.mj_header endRefreshing];
                }
                self.totalMount = [feedBacks[@"total"] integerValue];
                //此操作是为了解决当数据量不够分页时，隐藏loadFooter
                if (self.pageSize >= self.totalMount){
                    self.orderListV.tableV.mj_footer.hidden = true;
                }else{
                    self.orderListV.tableV.mj_footer.hidden = false;
                }
                [self.orderListV.tableV.mj_header endRefreshing];
                [self.orderListV.tableV reloadData];
                switch (ifL) {
                    case true:
                        if (self.pageInt >= ceil(self.totalMount/self.pageSize)){
                            [self.orderListV.tableV.mj_footer endRefreshingWithNoMoreData];
                        }
                        break;
                    default:
                        [self.orderListV.tableV.mj_footer resetNoMoreData];
                        break;
                }
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                if (ifR == 0){
                    [self.orderListV.tableV.mj_header endRefreshing];
                }
                if (ifL == 0){
                    [self.orderListV.tableV.mj_footer resetNoMoreData];
                }
            }
        } withFailureBlock:^(NSError *error) {
            STLog(@"%@",error)
        }];
    }else{
        if (self.placeholderV == nil){
            self.placeholderV = [[STPlaceholderView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarH, ScreenW, ScreenH - StatusBarAndNavigationBarH ) type:STPlaceholderViewTypeNoNetwork delegate:self];
            [self.view addSubview:self.placeholderV];
        }
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
-(void)setCache{
    //清空数据
    [self.orderListV.orderMs removeAllObjects];
    for (int i = 0; i < [[YYCacheTools resCacheForURL:@"order/list"][@"data"] count]; i++) {
        OrderMs *orderMs = [OrderMs modelWithJSON:[YYCacheTools resCacheForURL:@"order/list"][@"data"][i]];
        [self.orderListV.orderMs addObject:orderMs];
        OrderSonAMs *orderSonAMs = [OrderSonAMs modelWithJSON:[YYCacheTools resCacheForURL:@"order/list"][@"data"][i][@"address"]];
        [orderMs.address addObject:orderSonAMs];
        OrderSonRMs *orderSonRMs = [OrderSonRMs modelWithJSON:[YYCacheTools resCacheForURL:@"order/list"][@"data"][i][@"refundment"]];
        [orderMs.refundment addObject:orderSonRMs];
    }
    [self.orderListV.tableV reloadData];
};
//OrderListVdel
-(void)toGo:(NSString *)ids{
    OrderDetailVC * vc=[[OrderDetailVC alloc]init];
    vc.pass_Vals = @{@"order_no":ids};
    [MethodFunc pushToNextVC:self destVC:vc];
}
//下拉刷新
-(void)toRefresh{
    //清空数据
    _pageInt = 1;
    //0:刷新  1:不刷新    0:加载  1:不加载
    [self startR:1 andTab:[[_pass_Vals objectForKey:@"ids"] intValue] andR:0 andL:1];
}
//上拉加载
-(void)toLoadM{
    _pageInt  = _pageInt + 1;
    [self startR:_pageInt andTab:[[_pass_Vals objectForKey:@"ids"] intValue] andR:1 andL:0];
}

//网络监测通知：
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict = %@",dict);
    _netUseVals =  dict[@"ifnetUse"];
}

#pragma mark - Delegate - 占位图
/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(STPlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender{
    switch (placeholderView.type) {
        case STPlaceholderViewTypeNoGoods:       // 没商品
        {
            STLog(@"没商品");
        }
            break;

        case STPlaceholderViewTypeNoData:       // 没有订单
        {
            [YYCacheTools setResCache:@{} url:@"order/list"];
            [self startR:1 andTab:[[_pass_Vals objectForKey:@"ids"] intValue] andR:1 andL:1];
        }
            break;

        case STPlaceholderViewTypeNoNetwork:     // 没网
        {
            STLog(@"没网");
        }
            break;

        case STPlaceholderViewTypeBeautifulGirl: // 妹纸
        {
            STLog(@"没商品");
        }
            break;

        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
