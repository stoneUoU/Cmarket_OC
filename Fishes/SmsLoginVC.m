//
//  SmsLoginVC.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SmsLoginVC.h"
#import "TabBarVC.h"
#import "AppDelegate.h"
#import "RegisterVC.h"
#import "UIButton+countDown.h"
@implementation SmsLoginVC
- (id)init
{
    _smsLoginV = [[SmsLoginV alloc] init]; //对MyUIView进行初始化
    _smsLoginV.backgroundColor = allBgColor;
    _smsLoginV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"验证码登录" sideVal:@"注册" backIvName:@"theme_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_smsLoginV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_smsLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - SmsLoginVDel
- (void)toSubmit {
    [self startR];
}

- (void)toSmsCode {
    [_smsLoginV.smsBtn startWithTime:60 title:@"获取验证码" countDownTitle:@"s后再获取" mainColor:[UIColor clearColor] countColor:[UIColor clearColor]];
    [self smsCodeR];
}

//网络请求：
-(void) smsCodeR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"user/code" withParaments:@{@"opr":@"login",@"tel":@"15717914505"} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"%@",feedBacks);
            [HudTips showToast:self text:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast:self text:missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}

-(void)startR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        if (![ValidatedFile PayCodeIsValidated:self.smsLoginV.smsField.text]){
            [HudTips showToast:self text:@"验证码位数不合理" showType:Pos animationType:StToastAnimationTypeScale];
        }else{
            [HudTips showHUD:self];
            [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/login/code" withParaments:@{@"registration_id":@"",@"username":@"15717914505",@"code":self.smsLoginV.smsField.text} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
                [HudTips hideHUD:self];
                STLog(@"%@",feedBacks);
                //进行容错处理丫:
                if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                    [HudTips showToast:self text:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
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
                    [HudTips showToast:self text:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                }
            } withFailureBlock:^(NSError *error) {
                [HudTips hideHUD:self];
                STLog(@"%@",error)
            }];
        }
    }else{
        [HudTips showToast:self text:missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
// MARK: - 重写父类的方法
-(void) toSide{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:[[RegisterVC alloc] init] animated:true];
    });
}
//普通方法：
- (void)toCodeVC{
    [MethodFunc popToPrevVC:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
