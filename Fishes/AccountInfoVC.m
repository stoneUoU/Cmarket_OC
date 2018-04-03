//
//  AccountInfoVC.m
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "AccountInfoVC.h"
@implementation AccountInfoVC
- (id)init
{
    _accountInfoV = [[AccountInfoV alloc] init]; //对MyUIView进行初始化
    _accountInfoV.backgroundColor = [UIColor whiteColor];
    _accountInfoV.delegate = self; //将自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"个人信息" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:[UIColor clearColor]];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_accountInfoV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_accountInfoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - SetVDel
- (void)toTest {
    [self startR];
}

//发送网络请求：（查询个人信息R）
-(void)startR{

    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/list" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
            }else{
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
            //[self.mineV.iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:feedBacks[@"data"][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
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
