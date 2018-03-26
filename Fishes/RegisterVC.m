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
@implementation RegisterVC
- (id)init
{
    _registerV = [[RegisterV alloc] init]; //对MyUIView进行初始化
    _registerV.backgroundColor = [UIColor whiteColor];
    _registerV.delegate = self; //将SecondVC自己的实例作为委托对象
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

// MARK: - SmsLoginVDel
- (void)toSubmit {
    [self startR];
}

-(void) toBack{
    STLog(@"注册返回");
    [self.navigationController popViewControllerAnimated:true];
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
                [HudTips showToast:self text:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                //存登录后的token
                [UICKeyChainStore keyChainStore][@"orLogin"] = @"true";
                [UICKeyChainStore keyChainStore][@"authos"] = feedBacks[@"data"][@"token"];
                [self dismissViewControllerAnimated:NO completion:nil];
                //[AppDelegate getTabBarV].selectedIndex = 1;
                [TabBarVC sharedVC].selectedIndex = 1;
            }else{
                [HudTips showToast:self text:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        [HudTips showToast:self text:missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
@end
