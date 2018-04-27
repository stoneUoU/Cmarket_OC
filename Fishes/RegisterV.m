//
//  RegisterV.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "RegisterV.h"
#import "UILabel+STAttributeTextTapAction.h"
@interface RegisterV(){

    UIView *_telV;

    UILabel *_telL;

    UIView *_v_cut_line;

    UIView *_l_cut_line;

    UIView *_s_cut_line;

    UIView *_smsV;

    UILabel *_smsL;

    UIView *_codeV;

    UILabel *_codeL;

    UILabel *_itemL;
}
@end
@implementation RegisterV
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

    _s_cut_line = [[UIView alloc] init];
    _s_cut_line.backgroundColor = cutOffLineC;
    [_smsV addSubview:_s_cut_line];

    _codeV = [[UIView alloc] init];
    _codeV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_codeV];

    _codeL = [[UILabel alloc] init];
    _codeL.font=[UIFont systemFontOfSize:16];
    _codeL.textColor = deepBlackC;
    _codeL.text = @"密    码";
    [_codeV addSubview:_codeL];

    _codeField = [[UITextField alloc] init];
    _codeField.placeholder = @"6到16位数字或字母";
    _codeField.font = [UIFont systemFontOfSize:16];
    _codeField.tintColor  = styleColor;//光标颜色
    _codeField.textColor  = midBlackC;//字体颜色
    _codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeField.keyboardType = UIKeyboardTypePhonePad;
    _codeField.secureTextEntry = YES;
    UIView *code_leftV = [[UIView alloc] initWithFrame:CGRectMake(0, 0,spaceM,0)];
    _codeField.leftViewMode = UITextFieldViewModeAlways;//设置左边距显示的时机，这个表示一直显示
    _codeField.leftView = code_leftV;
    [_codeV addSubview:_codeField];

    _seeCodeV = [[STButton alloc] init];
    [_seeCodeV setBackgroundImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
    _seeCodeV.hitTestEdgeInsets = UIEdgeInsetsMake(-12, -12, -12, -12);
    [_seeCodeV addTarget:self action:@selector(toSeeCode:)
        forControlEvents:UIControlEventTouchUpInside];
    [_codeV addSubview:_seeCodeV];

    _selectV = [[STButton alloc] init];
    [_selectV setBackgroundImage:[UIImage imageNamed:@"unAccept.png"] forState:UIControlStateNormal];
    _selectV.hitTestEdgeInsets = UIEdgeInsetsMake(-12, -12, -12, -12);
    [_selectV addTarget:self action:@selector(toSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectV];

    //需要点击的字符不同
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:@"我已阅读并同意《使用协议》、《隐私条款》"];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, @"我已阅读并同意《使用协议》、《隐私条款》".length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:styleColor range:NSMakeRange(7, 6)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:styleColor range:NSMakeRange(14, 6)];
    _itemL = [[UILabel alloc] init];
    _itemL.font=[UIFont systemFontOfSize:12];
    _itemL.textColor = deepBlackC;
    _itemL.attributedText = attrStr;
    _itemL.enabledTapEffect = NO;
    [self addSubview:_itemL];
    [_itemL st_addAttributeTapActionWithStrings:@[@"《使用协议》",@"《隐私条款》"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        STLog(@"%@",string);
    }];


    _submitBtn = [[UIButton alloc] init];
    _submitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _submitBtn.backgroundColor = btnDisableC;
    _submitBtn.userInteractionEnabled = NO;
    _submitBtn.layer.cornerRadius = 22;
    [_submitBtn setTitle:@"注册" forState:UIControlStateNormal];
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
        make.width.mas_equalTo(0.5);
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
        make.height.mas_equalTo(0.5);
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

    [_s_cut_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_smsV.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.5);
    }];

    [_codeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_s_cut_line.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_codeV);
        make.left.mas_equalTo(spaceM);
    }];
    [_codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeV.mas_top).offset(0);
        make.left.equalTo(_codeL.mas_right).offset(0);
        make.right.equalTo(_codeV.mas_right).offset(-3*spaceM);
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_seeCodeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_codeV);
        make.right.mas_equalTo(-spaceM);
    }];

    [_selectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeV.mas_bottom).offset(10*StScaleH);
        make.left.mas_equalTo(spaceM);
    }];

    [_itemL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectV);
        make.left.mas_equalTo(_selectV.mas_right).offset(4);
    }];

    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeV.mas_bottom).offset(48*StScaleH);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44*StScaleH);
    }];
}
//按钮、手势函数写这
- (void)toSmsCode:(UIButton *)sender{
    NSString *tel = _telField.text;
    tel = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    tel = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![ValidatedFile MobileIsValidated:tel]){
        [HudTips showToast: @"手机号码不合理" showType:Pos animationType:StToastAnimationTypeScale];
    }else{
        [_delegate toSmsCode:tel];
    }
}
- (void)toDo:(UIButton *)sender{
    NSString *tel = _telField.text;
    NSString *smsCode = _smsField.text;
    NSString *codeCode = _codeField.text;

    //去除两端空格
    tel = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    smsCode = [smsCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    codeCode = [codeCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //去除两端空格和回车
    tel = [tel stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    smsCode = [smsCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    codeCode = [codeCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![ValidatedFile MobileIsValidated:tel]){
        [HudTips showToast: @"手机号码不合理" showType:Pos animationType:StToastAnimationTypeScale];
    }else if (![ValidatedFile PayCodeIsValidated:smsCode]){
        [HudTips showToast: @"验证码位数不合理" showType:Pos animationType:StToastAnimationTypeScale];
    }else if (![ValidatedFile LoginCodeIsValidated:codeCode]){
        [HudTips showToast: @"登录密码不合理" showType:Pos animationType:StToastAnimationTypeScale];
    }else{
        [_delegate toSubmit:tel withSmsCode:smsCode withCodeCode:codeCode];
    }
}

- (void)toSeeCode:(id)sender{
    [_delegate toSeeCode];
}

- (void)toSelected:(id)sender{
    [_delegate toSelected];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
