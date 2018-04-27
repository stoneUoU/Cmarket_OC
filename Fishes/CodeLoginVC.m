//
//  CodeLoginVC.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "CodeLoginVC.h"
#import "TabBarVC.h"
#import "AppDelegate.h"
#import "RegisterVC.h"
#import "SmsLoginVC.h"
#import "ReSetCodeVC.h"
@implementation CodeLoginVC
- (id)init
{
    _codeLoginV = [[CodeLoginV alloc] init]; //对MyUIView进行初始化
    _codeLoginV.backgroundColor = allBgColor;
    _codeLoginV.delegate = self; //将SecondVC自己的实例作为委托对象
    _boolSee = NO;
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"密码登录" sideVal:@"注册" backIvName:@"theme_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_codeLoginV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_codeLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - CodeLoginVDel
-(void) toBack{
    [self.navigationController popViewControllerAnimated:true];
}
-(void) toSmsVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        SmsLoginVC *smsLoginV =[[SmsLoginVC alloc] init];
        smsLoginV.pass_Vals = self.pass_Vals;
        [self.navigationController pushViewController:smsLoginV animated:true];
    });
}

- (void)toLeftCode {
    dispatch_async(dispatch_get_main_queue(), ^{
        ReSetCodeVC *reSetCodeV =[[ReSetCodeVC alloc] init];
        [self.navigationController pushViewController:reSetCodeV animated:true];
    });
}


- (void)toSeeCode {
    _boolSee = !_boolSee;
    if (_boolSee){
        [_codeLoginV.seeCodeV setBackgroundImage:[UIImage imageNamed:@"open_eye.png"] forState:UIControlStateNormal];
        _codeLoginV.codeField.secureTextEntry = NO;
    }else{
        [_codeLoginV.seeCodeV setBackgroundImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
        _codeLoginV.codeField.secureTextEntry = YES;
    }
}


- (void)toSubmit:(NSString *)tel withCode:(NSString *)code {
    [self startR:tel withCode:code];
}


-(void) toSide{
    dispatch_async(dispatch_get_main_queue(), ^{
        RegisterVC *registerV =[[RegisterVC alloc] init];
        registerV.pass_Vals = self.pass_Vals;
        [self.navigationController pushViewController:registerV animated:true];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)startR:(NSString *)tel withCode:(NSString *)code{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/login/password" withParaments:@{@"registration_id":@"",@"username":@"15717914505",@"password":[[[@"000000" MD5]MD5]MD5]} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                //存登录后的token
                [UICKeyChainStore keyChainStore][@"orLogin"] = @"true";
                [UICKeyChainStore keyChainStore][@"authos"] = feedBacks[@"data"][@"token"];
                STLog(@"%@",[UICKeyChainStore keyChainStore][@"authos"]);
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

@end
