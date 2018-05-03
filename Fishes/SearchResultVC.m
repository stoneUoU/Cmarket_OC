//
//  SearchResultVC.m
//  Fishes
//
//  Created by test on 2018/5/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SearchResultVC.h"
#import "HomeDetailVC.h"
#import "StartVC.h"
#import "FirmOrderVC.h"
@implementation SearchResultVC
- (id)init
{
    _searchResultV = [[SearchResultV alloc] init]; //对MyUIView进行初始化
    _searchResultV.backgroundColor = [UIColor whiteColor];
    _searchResultV.delegate = self; //将SecondVC自己的实例作为委托对象
    _pageSize = 4;
    _pageInt = 1;
    _totalMount = 0;
    _keyStr = @"";
    _selArr = [NSMutableArray arrayWithObjects:@0,@0, nil];
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];
    _Auths = [UICKeyChainStore keyChainStore][@"authos"];
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
    _statusStr = [_pass_Vals objectForKey:@"statusStr"];
    _keyStr = [_pass_Vals objectForKey:@"keyStr"];
    [self startPR:_statusStr withKeyWord:_keyStr withFreeze:@"" withPrice:@"" withUpdate:@"" andL:1];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}
- (void)setUpUI{
    [self.view addSubview:_searchResultV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_searchResultV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - MineVDel
- (void)toSort:(UIButton *)sender {
    //STLog(@"%ld",(long)sender.tag);
    switch (sender.tag) {
        case 0:
            //时间
            _timeSign = !_timeSign;
            if (_timeSign == NO){
                [sender setTitleColor:styleColor forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
            }else{
                [sender setTitleColor:styleColor forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
            }
            [_searchResultV.priceBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.priceBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.progressBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.progressBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.selectBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.selectBtn setImage:[UIImage imageNamed:@"unClickSelect.png"] forState:UIControlStateNormal];
            _pageInt = 1;
            [self startPR:_statusStr withKeyWord:_keyStr withFreeze:@"" withPrice:@"" withUpdate:_timeSign == NO ? @"asc" : @"desc" andL:1];
            _timeStr = _timeSign == NO ? @"asc" : @"desc";
            _priceStr = @"";
            _progressStr = @"";
            break;
        case 1:
            //价格
            _priceSign = !_priceSign;
            if (_priceSign == NO){
                [sender setTitleColor:styleColor forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
            }else{
                [sender setTitleColor:styleColor forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
            }
            [_searchResultV.timeBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.timeBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.progressBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.progressBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.selectBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.selectBtn setImage:[UIImage imageNamed:@"unClickSelect.png"] forState:UIControlStateNormal];
            _pageInt = 1;
            [self startPR:_statusStr withKeyWord:_keyStr withFreeze:@"" withPrice:_priceSign == NO ? @"asc" : @"desc" withUpdate:@"" andL:1];
            _priceStr = _priceSign == NO ? @"asc" : @"desc";
            _timeStr = @"";
            _progressStr = @"";
            break;
        case 2:
            //进度
            _progressSign = !_progressSign;
            if (_progressSign == NO){
                [sender setTitleColor:styleColor forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
            }else{
                [sender setTitleColor:styleColor forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];
            }
            [_searchResultV.timeBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.timeBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.priceBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.priceBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.selectBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.selectBtn setImage:[UIImage imageNamed:@"unClickSelect.png"] forState:UIControlStateNormal];
            _pageInt = 1;
            [self startPR:_statusStr withKeyWord:_keyStr withFreeze:_progressSign == NO ? @"asc" : @"desc" withPrice:@"" withUpdate:@"" andL:1];
            _progressStr = _progressSign == NO ? @"asc" : @"desc";
            _timeStr = @"";
            _priceStr = @"";
            break;
        default:
            _selSign = !_selSign;
            [_searchResultV.selectBtn setTitleColor:styleColor forState:UIControlStateNormal];
            [_searchResultV.selectBtn setImage:[UIImage imageNamed:@"clickSelect.png"] forState:UIControlStateNormal];
            [_searchResultV.timeBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.timeBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.priceBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.priceBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            [_searchResultV.progressBtn setTitleColor:deepBlackC forState:UIControlStateNormal];
            [_searchResultV.progressBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
            _timeStr = @"";
            _priceStr = @"";
            _progressStr = @"";
            //弹出QQ popover
            _stDropMenu=[[STDropMenu alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 120 - spaceM, StatusBarAndNavigationBarH + 44, 120, 86) ArrowOffset:102.f TitleArr:@[@"正在进行",@"即将开始"] ImageArr:@[@"",@""] Type:STDropMenuTypeQQ LayoutType:STDropMenuLayoutTypeNormal RowHeight:40.f Delegate:self andSelArr:_selArr];

            break;
    }
}
-(void)toCancel{
    [MethodFunc popToPrevVC:self];
}
-(void)toSearch{
    STLog(@"SOUSUO");
}

- (void)toLoadM {
    _pageInt = _pageInt + 1;
    [self startPR:_statusStr withKeyWord:_keyStr withFreeze:_progressStr withPrice:_priceStr withUpdate:_timeStr andL:0];
}
-(void) tableVClick:(NSInteger)row andDatas:(HomeMs *)datas{
    HomeDetailVC * homeDetailV = [[HomeDetailVC alloc] init];
    homeDetailV.pass_Vals = @{@"group_id":datas.group_id};
    [MethodFunc pushToNextVC:self destVC:homeDetailV];
}
-(void) toPlaceO:(NSDictionary *)str{
    if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
        //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
        StartVC * startV = [[StartVC alloc] init];
        startV.pass_Vals = @{@"status_code":@"1"};
        [MethodFunc presentToNaviVC:self destVC:startV];
    }else{
        //STLog(@"已登录,去消息");
        FirmOrderVC *vc = [[FirmOrderVC alloc]init];
        vc.pass_Vals = @{@"group_id":[str objectForKey:@"datas"],@"AC":@1};
        [MethodFunc pushToNextVC:self destVC:vc ];
    }
}
// MARK: - STDropMenuDelegate
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    for (int i = 0;i<_selArr.count;i++){
        if (i == index){
            [_selArr replaceObjectAtIndex:i withObject:@1];
        }else{
            [_selArr replaceObjectAtIndex:i withObject:@0];
        }

    }
    _pageInt = 1;
    _statusStr = index == 0 ? @"4":@"2";
    [self startPR:_statusStr withKeyWord:_keyStr withFreeze:_progressSign == NO ? @"asc" : @"desc" withPrice:@"" withUpdate:@"" andL:1];
}
//查询商品
- (void)startPR:(NSString *)selIdx withKeyWord:(NSString *)key_word  withFreeze:(NSString *)freeze_inventory withPrice:(NSString *)price_much withUpdate:(NSString *)update_time andL:(NSInteger)ifL{  // 0:上拉   1:不上拉
    if ([_netUseVals isEqualToString: @"Useable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
        STLog(@"%@",[@{@"cond":@{@"keywords":key_word,@"status":selIdx},@"sort":@{@"freeze_inventory":freeze_inventory,@"group_product_price":price_much,@"update_time":update_time},@"limit":@(_pageSize),@"page":@(_pageInt)} modelToJSONString]);
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"search" withParaments:@{@"cond":@{@"keywords":key_word,@"status":selIdx},@"sort":@{@"freeze_inventory":freeze_inventory,@"group_product_price":price_much,@"update_time":update_time},@"limit":@(_pageSize),@"page":@(_pageInt)} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            STLog(@"%@",[feedBacks modelToJSONString]);
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]] isEqualToString:@"0"]){
                if (ifL == 1){
                    [self.searchResultV.dataArrs removeAllObjects];
                }
                if ( [feedBacks[@"data"] count] == 0){
                    if (_placeholderV == nil){
                        _placeholderV = [[STPlaceholderView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarH + 44 , ScreenW, ScreenH - StatusBarAndNavigationBarH - 44 - TabbarSafeBottomM) type:STPlaceholderViewTypeNoData delegate:self];
                        [self.view addSubview:_placeholderV];
                        [self.searchResultV.tableV reloadData];
                    }
                }else{
                    [_placeholderV removeFromSuperview];
                    _placeholderV = nil;
                    for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                        HomeMs *homeMs = [[HomeMs alloc] initMs:feedBacks[@"data"][i][@"group_id"] title:feedBacks[@"data"][i][@"title"] price:feedBacks[@"data"][i][@"price"] discount_price:feedBacks[@"data"][i][@"discount_price"] spic:feedBacks[@"data"][i][@"spic"] status:feedBacks[@"data"][i][@"status"] total_inventory:feedBacks[@"data"][i][@"total_inventory"] freeze_inventory:feedBacks[@"data"][i][@"freeze_inventory"] start_time:feedBacks[@"data"][i][@"start_time"] end_time:feedBacks[@"data"][i][@"end_time"] type:feedBacks[@"data"][i][@"type"] subtitle:feedBacks[@"data"][i][@"subtitle"] attr_value:feedBacks[@"data"][i][@"attr_value"][0][@"attr_value"] desc:feedBacks[@"data"][i][@"description"]];
                        [self.searchResultV.dataArrs addObject:homeMs];
                    }
                }
                self.totalMount = [feedBacks[@"total"] integerValue];
                //此操作是为了解决当数据量不够分页时，隐藏loadFooter
                if (self.pageSize >= self.totalMount){
                    self.searchResultV.tableV.mj_footer.hidden = true;
                }else{
                    self.searchResultV.tableV.mj_footer.hidden = false;
                }
                [self.searchResultV.tableV.mj_header endRefreshing];
                [self.searchResultV.tableV reloadData];
                switch (ifL) {
                    case true:
                        if (self.pageInt >= ceil(self.totalMount/self.pageSize)){
                            [self.searchResultV.tableV.mj_footer endRefreshingWithNoMoreData];
                        }
                        break;
                    default:
                        [self.searchResultV.tableV.mj_footer resetNoMoreData];
                        break;
                }
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
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
//通知模块代码：
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    _netUseVals =  dict[@"ifnetUse"];
}
- (BOOL)hidesBottomBarWhenPushed
{
    return (self.navigationController.topViewController == self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

