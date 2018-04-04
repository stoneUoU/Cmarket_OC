//
//  PopPresentVC.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "PopPresentVC.h"

@implementation PopPresentVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    self.view.layer.shadowOpacity = 0.8;
    self.view.layer.shadowRadius = 5;
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpUI];
}

- (void)setUpUI{
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(15, 0, 50, 40);
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithRed:217/255.0 green:110/255.0 blue:90/255.0 alpha:1] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];

    _doBtn = [[UIButton alloc] init];
    _doBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _doBtn.backgroundColor = styleColor;
    [_doBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_doBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_doBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_doBtn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_doBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    _dictB(@{@"name":@"oooooo"}, YES);
}
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
