//
//  EditPlaceV.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "EditPlaceV.h"

@implementation EditPlaceV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _exitBtn = [[UIButton alloc] init];
    _exitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _exitBtn.backgroundColor = styleColor;
    _exitBtn.layer.cornerRadius = 22;
    [_exitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_exitBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_exitBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_exitBtn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toSubmit];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
