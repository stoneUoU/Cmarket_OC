//
//  RegisterVC.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "RegisterVC.h"
#import "TabBarVC.h"
#import "AppDelegate.h"
#import "UIButton+countDown.h"
@implementation RegisterVC
- (id)init
{
    _registerV = [[RegisterV alloc] init]; //对MyUIView进行初始化
    _registerV.backgroundColor = allBgColor ;
    _registerV.delegate = self; //将SecondVC自己的实例作为委托对象
    _boolSee = NO;
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"注册" sideVal:@"" backIvName:@"theme_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:[UIColor clearColor]];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_registerV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_registerV mas_makeConstraints:^(MASConstraintMaker *make) {
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
//注册:
-(void)startR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/login/password" withParaments:@{@"registration_id":@"",@"username":@"15717914505",@"password":[[[@"000000" MD5]MD5]MD5]} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"%@",feedBacks);
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                //存登录后的token
                [UICKeyChainStore keyChainStore][@"orLogin"] = @"true";
                [UICKeyChainStore keyChainStore][@"authos"] = feedBacks[@"data"][@"token"];
                if ([[NSString stringWithFormat:@"%@",[_pass_Vals objectForKey:@"status_code"]]  isEqual: @"0"]){
                    [MethodFunc dismissCurrVC:self];
                    [MethodFunc backToHomeVC:[_pass_Vals objectForKey:@"selfVC"]];
                    [TabBarVC sharedVC].selectedIndex = 0;
                }else if ([[NSString stringWithFormat:@"%@",[_pass_Vals objectForKey:@"status_code"]]  isEqual: @"1"]){
                    [MethodFunc dismissCurrVC:self];
                }else if ([[NSString stringWithFormat:@"%@",[_pass_Vals objectForKey:@"status_code"]]  isEqual: @"2"]){
                    [MethodFunc dismissCurrVC:self];
                    [TabBarVC sharedVC].selectedIndex = 1;
                }
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
// MARK: - SmsLoginVDel
- (void)toSeeCode {
    _boolSee = !_boolSee;
    if (_boolSee){
        [_registerV.seeCodeV setBackgroundImage:[UIImage imageNamed:@"open_eye.png"] forState:UIControlStateNormal];
        _registerV.codeField.secureTextEntry = NO;
    }else{
        [_registerV.seeCodeV setBackgroundImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
        _registerV.codeField.secureTextEntry = YES;
    }
}

- (void)toSelected {
    _boolR = !_boolR;
    if (_boolR){
        [_registerV.selectV setBackgroundImage:[UIImage imageNamed:@"accept.png"] forState:UIControlStateNormal];
        _registerV.submitBtn.backgroundColor = styleColor;
        _registerV.submitBtn.userInteractionEnabled = YES;
    }else{
        [_registerV.selectV setBackgroundImage:[UIImage imageNamed:@"unAccept.png"] forState:UIControlStateNormal];
        _registerV.submitBtn.backgroundColor = btnDisableC;
        _registerV.submitBtn.userInteractionEnabled = NO;
    }
}

- (void)toSmsCode:(NSString *)tel {
    [_registerV.smsBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"s后再获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    [self smsCodeR:tel];

}

- (void)toSubmit:(NSString *)tel withSmsCode:(NSString *)smsCode withCodeCode:(NSString *)codeCode {
    [self startR];
}

@end
