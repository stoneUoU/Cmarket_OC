//
//  HomeDetailVC.m
//  Fishes
//
//  Created by test on 2017/11/29.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "HomeDetailVC.h"
#import "StartVC.h"
@interface HomeDetailVC ()

@end

@implementation HomeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUp:@"商品详情" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor cyanColor] midFontC:deepBlackC sideFontC:deepBlackC];//[self setUp:@"商品详情"];
    [self setUpUI];
}
- (void)setUpUI{
    _btn = [[UIButton alloc] init];
    _btn.backgroundColor = styleColor;
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btn setTitle:@"去拼单" forState:UIControlStateNormal];
    [_btn sizeToFit];
    _btn.st_acceptEventInterval = 2;
    //6.通过代码为控件注册一个单机事件
    [_btn addTarget:self action:@selector(goBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];
}

- (void)goBuy:(id)sender{
    //如果没有导航栏，就进行这种跳转；
    //STLog(@"%@",self.netUseVals);
    //[HudTips showToast:self text:self.netUseVals showType:Pos animationType:StToastAnimationTypeScale];
    if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
        //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
        StartVC * startV = [[StartVC alloc] init];
        startV.pass_Vals = @{@"status_code":@"1"};
        [MethodFunc presentToNaviVC:self destVC:startV];
    }else{
        STLog(@"已登录,去拼单");
    }
}


//- (BOOL)hidesBottomBarWhenPushed
//{
//    return (self.navigationController.topViewController == self);
//}
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
