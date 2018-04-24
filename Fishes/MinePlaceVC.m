//
//  MinePlaceVC.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "MinePlaceVC.h"
#import "EditPlaceVC.h"
@interface MinePlaceVC ()

@end

@implementation MinePlaceVC
- (id)init
{
    _minePlaceV = [[MinePlaceV alloc] init]; //对MyUIView进行初始化
    _minePlaceV.backgroundColor = [UIColor whiteColor];
    _minePlaceV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"我的地址" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
    [self startR:1];
}
- (void)setUpUI{
    [self.view addSubview:_minePlaceV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_minePlaceV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

//查询收货地址
-(void)startR:(NSInteger )ifR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/address/list" withParaments:@{@"default":@0,@"page":@1,@"limit":@1} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                    MineAds *mineAds = [MineAds modelWithJSON:feedBacks[@"data"][i]];
                    [self.minePlaceV.minePls addObject:mineAds];
                }
                [self.minePlaceV.tableV reloadData];
                if (ifR == 0){
                    [self.minePlaceV.tableV.mj_header endRefreshing];
                }
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                if (ifR == 0){
                    [self.minePlaceV.tableV.mj_header endRefreshing];
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

// MARK: - StallManageVDel
- (void)tableVClick:(NSInteger)section andRow:(NSInteger)row andDatas:(MineAds *)datas {
    if (section == 0 && row == 0){
        STLog(@"%@",datas);
        EditPlaceVC * vc=[[EditPlaceVC alloc]init];
        [MethodFunc pushToNextVC:self destVC:vc];
    }
}
- (void)toRefresh{
    [self startR:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
