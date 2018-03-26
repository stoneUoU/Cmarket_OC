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

    _submitBtn = [[UIButton alloc] init];
    _submitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _submitBtn.backgroundColor = styleColor;
    _submitBtn.layer.cornerRadius = 22;
    [_submitBtn setTitle:@"短信验证码登录" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_submitBtn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toSubmit ];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
