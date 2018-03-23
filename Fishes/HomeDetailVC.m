//
//  HomeDetailVC.m
//  Fishes
//
//  Created by test on 2017/11/29.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "HomeDetailVC.h"

@interface HomeDetailVC ()

@end

@implementation HomeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUp:@"商品详情" sideVal:@"" navC:[UIColor cyanColor] midFontC:deepBlackC sideFontC:deepBlackC];//[self setUp:@"商品详情"];
    [self setUpUI];
}
- (void)setUpUI{
    _btn = [[UIButton alloc] init];
    [_btn setTitle:@"网络状态" forState:UIControlStateNormal];
    [_btn sizeToFit];
    //self.dangerBtn.cs_acceptEventInterval = 5;
    //6.通过代码为控件注册一个单机事件
    [_btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarAndNavigationBarH);
    }];
}

- (void)jump:(id)sender{
    //如果没有导航栏，就进行这种跳转；
    //STLog(@"%@",self.netUseVals);
    [HudTips showToast:self text:self.netUseVals showType:Pos animationType:StToastAnimationTypeScale];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
