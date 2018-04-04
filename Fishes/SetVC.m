//
//  SetVC.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SetVC.h"
@implementation SetVC
- (id)init
{
    _setV = [[SetV alloc] init]; //对MyUIView进行初始化
    _setV.backgroundColor = [UIColor whiteColor];
    _setV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"设置" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];

    [self startR];
}
- (void)setUpUI{
    [self.view addSubview:_setV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_setV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - SetVDel
- (void)toExit {
    //第一步:创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您是否确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    // 2.1 创建按钮
    UIAlertAction *succBtn = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self startR];
    }];
    UIAlertAction *failBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    // 2.2 添加按钮
    [alertController addAction:succBtn];
    [alertController addAction:failBtn];
    //显示弹框.(相当于show操作)
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)startR{
    if ([self.netUseVals isEqualToString: @"Unseable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/logout" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            //进行容错处理丫:
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                [HudTips showToast: @"注销成功" showType:Pos animationType:StToastAnimationTypeScale];
                //清空用户信息
                [UICKeyChainStore keyChainStore][@"orLogin"] = @"false";
                [UICKeyChainStore keyChainStore][@"authos"] = @"";
                [MethodFunc backToHomeVC:self];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
