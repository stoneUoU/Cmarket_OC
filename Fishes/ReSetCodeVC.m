//
//  ReSetCodeVC.m
//  Fishes
//
//  Created by test on 2018/4/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
// 找回密码
#import "ReSetCodeVC.h"
#import "UIButton+countDown.h"
@implementation ReSetCodeVC
- (id)init
{
    _reSetCodeV = [[ReSetCodeV alloc] init]; //对MyUIView进行初始化
    _reSetCodeV.backgroundColor = allBgColor ;
    _reSetCodeV.delegate = self; //将SecondVC自己的实例作为委托对象
    _boolSee = NO;
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"找回密码" sideVal:@"" backIvName:@"theme_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:[UIColor clearColor]];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_reSetCodeV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_reSetCodeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取验证码:
- (void)smsCodeR:(NSString *)tel{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/code" withParaments:@{@"opr":@"login",@"tel":tel} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"%@",feedBacks);
            [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
//提交密码:
-(void)startR:(NSString *)tel withSmsCode:(NSString *)smsCode withCodeCode:(NSString *)codeCode{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/password/modify" withParaments:@{@"username":@"15717914505",@"password":[[[@"000000" MD5]MD5]MD5],@"code":@"666666"} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [MethodFunc popToPrevVC:self];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
// MARK: - SmsLoginVDel
- (void)toSeeCode {
    _boolSee = !_boolSee;
    if (_boolSee){
        [_reSetCodeV.seeCodeV setBackgroundImage:[UIImage imageNamed:@"open_eye.png"] forState:UIControlStateNormal];
        _reSetCodeV.codeField.secureTextEntry = NO;
    }else{
        [_reSetCodeV.seeCodeV setBackgroundImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
        _reSetCodeV.codeField.secureTextEntry = YES;
    }
}
- (void)toSmsCode:(NSString *)tel{
    [_reSetCodeV.smsBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"s后再获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    [self smsCodeR:tel];

}
- (void)toSubmit:(NSString *)tel withSmsCode:(NSString *)smsCode withCodeCode:(NSString *)codeCode {
    [self startR:tel withSmsCode:smsCode withCodeCode:codeCode];
}



@end
