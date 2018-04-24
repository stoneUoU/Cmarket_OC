//
//  EditPlaceVC.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "EditPlaceVC.h"

@interface EditPlaceVC ()

@end

@implementation EditPlaceVC

- (id)init
{
    _editPlaceV = [[EditPlaceV alloc] init]; //对MyUIView进行初始化
    _editPlaceV.backgroundColor = [UIColor whiteColor];
    _editPlaceV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"收货地址" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];

    //[self startR];
}
- (void)setUpUI{
    [self.view addSubview:_editPlaceV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_editPlaceV mas_makeConstraints:^(MASConstraintMaker *make) {
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
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/logout" withParaments:@{} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            STLog(@"%@",[feedBacks modelToJSONString]);
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

// MARK: - EditPlaceVDel
- (void)toSubmit {
    STLog(@"保存");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
