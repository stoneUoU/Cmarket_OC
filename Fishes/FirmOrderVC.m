//
//  FirmOrderVC.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "FirmOrderVC.h"
@implementation FirmOrderVC
- (id)init
{
    _firmOrderV = [[FirmOrderV alloc] init]; //对MyUIView进行初始化
    _firmOrderV.backgroundColor = [UIColor whiteColor];
    _firmOrderV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"确认下单" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_firmOrderV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_firmOrderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - FirmOrderVDel
- (void)toDo {
    [MethodFunc popToRootVC:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
