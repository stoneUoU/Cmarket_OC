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
@implementation CodeLoginVC
- (id)init
{
    _codeLoginV = [[CodeLoginV alloc] init]; //对MyUIView进行初始化
    _codeLoginV.backgroundColor = [UIColor whiteColor];
    _codeLoginV.delegate = self; //将SecondVC自己的实例作为委托对象
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
- (void)toSubmit {
    [self startR];
}

-(void) toBack{
    STLog(@"密码登录返回");
    [self.navigationController popViewControllerAnimated:true];
}
-(void) toSmsVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        SmsLoginVC *smsLoginV =[[SmsLoginVC alloc] init];
        smsLoginV.pass_Vals = self.pass_Vals;
        [self.navigationController pushViewController:smsLoginV animated:true];
    });
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
                STLog(@"%@",feedBacks[@"data"][@"token"]);
                STLog(@"%@",[feedBacks[@"data"] objectForKey:@"token"]);
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
