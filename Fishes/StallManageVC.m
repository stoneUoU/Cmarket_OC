//
//  StallManageVC.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
//  摊位管理

#import "StallManageVC.h"
#import "StallAuthVC.h"
@interface StallManageVC ()

@end

@implementation StallManageVC
- (id)init
{
    _stallManageV = [[StallManageV alloc] init]; //对MyUIView进行初始化
    _stallManageV.backgroundColor = [UIColor whiteColor];
    _stallManageV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"摊位管理" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
    [self startR];
}
- (void)setUpUI{
    [self.view addSubview:_stallManageV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_stallManageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

-(void)startR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/certify/list" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"%@",[feedBacks modelToJSONString]);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [self.stallManageV.stallMs removeAllObjects];
                switch ([feedBacks[@"data"][@"status"] intValue]) {
                    case 0:
                        _stateInfo = @"去认证";
                        break;
                    case 1:
                        _stateInfo = @"审核中";
                        break;
                    case 3:
                        _stateInfo = @"";
                        break;
                    default:
                        _stateInfo = [[NSString stringWithFormat:@"%@",feedBacks[@"data"][@"company_name"]]   isEqual: @"null"] ? @"" :  [NSString stringWithFormat:@"%@",feedBacks[@"data"][@"company_name"]];
                        break;
                }
                self.stallManageV.stallMs =  [NSMutableArray arrayWithArray:@[
                  @[
                      @{@"modelName":@"摊位信息认证",@"vals":_stateInfo}
                      ]
                  ]];
                [self.stallManageV.tableV reloadData];
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

// MARK: - StallManageVDel
- (void)tableVClick:(NSInteger)section andRow:(NSInteger)row {
    if (section == 0 && row == 0){
        [MethodFunc pushToNextVC:self destVC:[[StallAuthVC alloc] init]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
