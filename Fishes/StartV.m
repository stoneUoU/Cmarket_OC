//
//  StartV.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "StartV.h"

@implementation StartV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{
    _statusV = [[UIView alloc] init];
    _statusV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_statusV];

    _navBarV = [[UIView alloc] init];
    _navBarV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_navBarV];

    _backBtn = [[UIButton alloc] init];
    _backBtn.tag = 0;
    [_backBtn setImage:[UIImage imageNamed:@"theme_serve_back.png"]forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [_backBtn adjustToSize:CGSizeMake(30,0)];
    [_navBarV addSubview:_backBtn];

    _logoIV = [[UIImageView alloc] init];
    _logoIV.image = [UIImage imageNamed:@"logo.png"];
    [self addSubview:_logoIV];

    _loginBtn = [[UIButton alloc] init];
    _loginBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _loginBtn.backgroundColor = styleColor;
    _loginBtn.tag = 1;
    _loginBtn.layer.cornerRadius = 22;
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];

    _registerBtn = [[UIButton alloc] init];
    _registerBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _registerBtn.backgroundColor = [UIColor whiteColor];
    _registerBtn.tag = 2;
    _registerBtn.layer.borderColor = [styleColor CGColor];
    _registerBtn.layer.borderWidth = 1;
    _registerBtn.layer.cornerRadius = 22;
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:styleColor  forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registerBtn];

    _caiIV = [[UIImageView alloc] init];
    _caiIV.image = [UIImage imageNamed:@"startBg.png"];
    [self addSubview:_caiIV];


    //添加约束
    [self setMas];
}
- (void) setMas{
    [_statusV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarH);
    }];
    [_navBarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusV.mas_bottom).offset(0);
        make.left.equalTo(_navBarV);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(NavigationBarH);
    }];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.height.equalTo(_navBarV);
    }];
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_bottom).offset(StatusBarAndNavigationBarH*StScaleH);
        make.centerX.equalTo(self);
    }];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoIV.mas_bottom).offset(58*StScaleH);
        make.left.equalTo(self.mas_left).offset(spaceM);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(26*StScaleH);
        make.left.equalTo(self.mas_left).offset(spaceM);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_caiIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-32);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(345*StScaleW);
        make.height.mas_equalTo(230*StScaleH);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    switch (sender.tag) {
    case 0:
            [_delegate toBack ];
            break;
    case 1:
            [_delegate toLogin ];
            break;
    default:
            [_delegate toRegister ];
            break;
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
