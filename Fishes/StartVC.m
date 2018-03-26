//
//  StartVC.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "StartVC.h"
#import "TabBarVC.h"
#import "AppDelegate.h"
#import "CodeLoginVC.h"
#import "RegisterVC.h"
@implementation StartVC
- (id)init
{
    _startV = [[StartV alloc] init]; //对MyUIView进行初始化
    _startV.backgroundColor = [UIColor whiteColor];
    _startV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}
- (void)setUpUI{
    [self.view addSubview:_startV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_startV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}

// MARK: - MineVDel
- (void)toLogin {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:[[CodeLoginVC alloc] init] animated:true];
    });
}

- (void)toRegister {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:[[RegisterVC alloc] init] animated:true];
    });
}

-(void) toBack{
    [self dismissViewControllerAnimated:NO completion:nil];
    //[AppDelegate getTabBarV].selectedIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
