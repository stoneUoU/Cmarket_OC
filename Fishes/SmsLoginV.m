//
//  SmsLoginV.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SmsLoginV.h"
@implementation SmsLoginV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _telV = [[UIView alloc] init];
    _telV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_telV];

    _telL = [[UILabel alloc] init];
    _telL.font=[UIFont systemFontOfSize:16];
    _telL.textColor = deepBlackC;
    _telL.text = @"手机号";
    [_telV addSubview:_telL];

    _telField = [[UITextField alloc] init];
    _telField.placeholder = @"请输入您的手机号";
    _telField.font = [UIFont systemFontOfSize:16];
    _telField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telField.keyboardType = UIKeyboardTypePhonePad;
    _telField.secureTextEntry = false;
    _telField.tintColor  = styleColor;//光标颜色
    _telField.textColor  = midBlackC;//字体颜色
    UIView *tel_leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0,spaceM,0)];
    _telField.leftViewMode = UITextFieldViewModeAlways;//设置左边距显示的时机，这个表示一直显示
    _telField.leftView = tel_leftV;
    [_telV addSubview:_telField];

    _v_cut_line = [[UIView alloc] init];
    _v_cut_line.backgroundColor = cutOffLineC;
    [_telV addSubview:_v_cut_line];

    _smsBtn = [[UIButton alloc] init];
    _smsBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_smsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_smsBtn setTitleColor:styleColor  forState:UIControlStateNormal];
    [_smsBtn addTarget:self action:@selector(toSmsCode:)forControlEvents:UIControlEventTouchUpInside];
    [_telV addSubview:_smsBtn];

    _l_cut_line = [[UIView alloc] init];
    _l_cut_line.backgroundColor = cutOffLineC;//[UIColor redColor];
    [self addSubview:_l_cut_line];

    _smsV = [[UIView alloc] init];
    _smsV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_smsV];

    _smsL = [[UILabel alloc] init];
    _smsL.font=[UIFont systemFontOfSize:16];
    _smsL.textColor = deepBlackC;
    _smsL.text = @"验证码";
    [_smsV addSubview:_smsL];

    _smsField = [[UITextField alloc] init];
    _smsField.placeholder = @"您手机收到的验证码";
    _smsField.font = [UIFont systemFontOfSize:16];
    _smsField.tintColor  = styleColor;//光标颜色
    _smsField.textColor  = midBlackC;//字体颜色
    _smsField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _smsField.keyboardType = UIKeyboardTypePhonePad;
    _smsField.secureTextEntry = false;
    UIView *sms_leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0,spaceM,0)];
    _smsField.leftViewMode = UITextFieldViewModeAlways;//设置左边距显示的时机，这个表示一直显示
    _smsField.leftView = sms_leftV;
    [_smsV addSubview:_smsField];

    _codeLoginV = [[UILabel alloc] init];
    _codeLoginV.font=[UIFont systemFontOfSize:13];
    _codeLoginV.textColor = deepBlackC;
    _codeLoginV.text = @"密码登录";
    [_codeLoginV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toCodeVC:)];
    [_codeLoginV addGestureRecognizer:touchTap];
    [self addSubview:_codeLoginV];


    _submitBtn = [[UIButton alloc] init];
    _submitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _submitBtn.backgroundColor = styleColor;
    _submitBtn.layer.cornerRadius = 22;
    [_submitBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_submitBtn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_telV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_telL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_telV);
        make.left.equalTo(_telV.mas_left).offset(spaceM);
    }];

    [_telField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telV.mas_top).offset(0);
        make.left.equalTo(_telL.mas_right).offset(0);
        make.width.mas_equalTo(ScreenW*3/5 - 2*spaceM - 2);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_v_cut_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telV.mas_top).offset(0);
        make.left.equalTo(_telField.mas_right).offset(0);
        make.width.mas_equalTo(0.7);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_telV);
        make.right.equalTo(_telV.mas_right).offset(-spaceM);
        make.width.mas_equalTo(ScreenW/5 + spaceM);
    }];

    [_l_cut_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telV.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.7);
    }];

    [_smsV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_l_cut_line.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_smsL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_smsV);
        make.left.equalTo(self.mas_left).offset(spaceM);
    }];
    [_smsField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_smsV.mas_top).offset(0);
        make.left.equalTo(_smsL.mas_right).offset(0);
        make.right.equalTo(_smsV.mas_right).offset(-spaceM);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_codeLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_smsV.mas_bottom).offset(10);
        make.left.equalTo(self).offset(spaceM);
    }];

    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeLoginV.mas_bottom).offset(24*StScaleH);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
}
//按钮、手势函数写这
- (void)toSmsCode:(UIButton *)sender{
    [_delegate toSmsCode ];
}


- (void)toDo:(UIButton *)sender{
    [_delegate toSubmit ];
}

- (void)toCodeVC:(id)sender{
    [_delegate toCodeVC];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
