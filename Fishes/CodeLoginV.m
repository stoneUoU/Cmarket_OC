//
//  CodeLoginV.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CodeLoginV.h"

@interface CodeLoginV(){
    UIButton *_submitBtn;

    UIView *_telV;

    UIView *_l_cut_line;

    UIView *_codeV;

    UILabel *_smsLoginV;

    UILabel *_leftCodeV;
}
@end
@implementation CodeLoginV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _telV = [[UIView alloc] init];
    _telV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_telV];

    _telField = [[UITextField alloc] init];
    _telField.placeholder = @"请输入您的手机号";
    _telField.font = [UIFont systemFontOfSize:16];
    _telField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telField.keyboardType = UIKeyboardTypePhonePad;
    _telField.secureTextEntry = false;
    _telField.tintColor  = styleColor;//光标颜色
    _telField.textColor  = midBlackC;//字体颜色
    [_telField addTarget:self action:@selector(valC:) forControlEvents:UIControlEventEditingChanged];
    [_telV addSubview:_telField];

    _l_cut_line = [[UIView alloc] init];
    _l_cut_line.backgroundColor = cutOffLineC;//[UIColor redColor];
    [self addSubview:_l_cut_line];

    _codeV = [[UIView alloc] init];
    _codeV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_codeV];

    _codeField = [[UITextField alloc] init];
    _codeField.placeholder = @"您输入您的密码";
    _codeField.font = [UIFont systemFontOfSize:16];
    _codeField.tintColor  = styleColor;//光标颜色
    _codeField.textColor  = midBlackC;//字体颜色
    _codeField.delegate = self;
    _codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeField.keyboardType = UIKeyboardTypeDefault;
    _codeField.secureTextEntry = YES;
    [_codeV addSubview:_codeField];

    _seeCodeV = [[STButton alloc] init];
    [_seeCodeV setBackgroundImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
    _seeCodeV.hitTestEdgeInsets = UIEdgeInsetsMake(-12, -12, -12, -12);
    [_seeCodeV addTarget:self action:@selector(toSeeCode:) forControlEvents:UIControlEventTouchUpInside];
    [_codeV addSubview:_seeCodeV];

    _smsLoginV = [[UILabel alloc] init];
    _smsLoginV.font=[UIFont systemFontOfSize:13];
    _smsLoginV.textColor = deepBlackC;
    _smsLoginV.text = @"验证码登录";
    [_smsLoginV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toSmsVC:)];
    [_smsLoginV addGestureRecognizer:touchTap];
    [self addSubview:_smsLoginV];

    _leftCodeV = [[UILabel alloc] init];
    _leftCodeV.font=[UIFont systemFontOfSize:13];
    _leftCodeV.textColor = deepBlackC;
    _leftCodeV.text = @"忘记密码";
    [_leftCodeV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *leftGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLeftCode:)];
    [_leftCodeV addGestureRecognizer:leftGes];
    [self addSubview:_leftCodeV];


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

    [_telField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_telV);
        make.left.mas_equalTo(spaceM);
        make.right.mas_equalTo(-spaceM);
    }];

    [_l_cut_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telV.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.7);
    }];

    [_codeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_l_cut_line.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_codeV);
        make.left.mas_equalTo(spaceM);
        make.right.mas_equalTo(-3*spaceM);
    }];

    [_seeCodeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_codeV);
        make.right.mas_equalTo(-spaceM);
    }];

    [_smsLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeV.mas_bottom).offset(18*StScaleH);
        make.left.mas_equalTo(spaceM);
    }];

    [_leftCodeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_codeV.mas_bottom).offset(18*StScaleH);
        make.right.mas_equalTo(-spaceM);
    }];

    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftCodeV.mas_bottom).offset(24*StScaleH);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
}
//按钮、手势函数写这

- (void)toSmsVC:(id)sender{
    [_delegate toSmsVC];
}

- (void)toSeeCode:(id)sender{
    [_delegate toSeeCode];
}

- (void)toDo:(UIButton *)sender{
    NSString *tel = _telField.text;
    NSString *codeCode = _codeField.text;

    //去除两端空格
    tel = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    codeCode = [codeCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除两端空格和回车
    tel = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    codeCode = [codeCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if (![ValidatedFile MobileIsValidated:tel]){
//        [HudTips showToast: @"手机号码不合理" showType:Pos animationType:StToastAnimationTypeScale];
//    }else if (![ValidatedFile LoginCodeIsValidated:codeCode]){
//        [HudTips showToast: @"登录密码不合理" showType:Pos animationType:StToastAnimationTypeScale];
//    }else{
        [_delegate toSubmit:tel withCode:codeCode];
    //}
}

- (void)toLeftCode:(id)sender{
    [_delegate toLeftCode];
}


- (void)valC:(UITextField *)sender{
    if(sender.text.length == 11){
        if (![ValidatedFile MobileIsValidated:sender.text]){
            [HudTips showToast: @"手机号码不合理" showType:Pos animationType:StToastAnimationTypeScale];
        }else{
            [_codeField becomeFirstResponder];
        }
    }else if(sender.text.length > 11){
        sender.text = [sender.text substringToIndex:11];
    }
    //[_delegate toLeftCode];
}

#pragma UITextFieldDelegate
//-(void)text
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
