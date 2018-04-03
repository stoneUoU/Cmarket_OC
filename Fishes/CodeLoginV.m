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

    UILabel *_smsLoginV;
}
@end
@implementation CodeLoginV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _submitBtn = [[UIButton alloc] init];
    _submitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _submitBtn.backgroundColor = styleColor;
    _submitBtn.layer.cornerRadius = 22;
    [_submitBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_submitBtn];

    _smsLoginV = [[UILabel alloc] init];
    _smsLoginV.font=[UIFont systemFontOfSize:13];
    _smsLoginV.textColor = deepBlackC;
    _smsLoginV.text = @"验证码登录";
    [_smsLoginV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toSmsVC:)];
    [_smsLoginV addGestureRecognizer:touchTap];
    [self addSubview:_smsLoginV];

    //添加约束
    [self setMas];

}
- (void) setMas{
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44);
    }];

    [_smsLoginV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(spaceM);
        make.bottom.mas_equalTo(_submitBtn.mas_top).offset(-20*StScaleH);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toSubmit ];
}

- (void)toSmsVC:(id)sender{
    [_delegate toSmsVC];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
