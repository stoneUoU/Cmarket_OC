//
//  AccountInfoV.m
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AccountInfoV.h"

@implementation AccountInfoV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _testBtn = [[UIButton alloc] init];
    _testBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _testBtn.backgroundColor = styleColor;
    _testBtn.layer.cornerRadius = 22;
    [_testBtn setTitle:@"测试" forState:UIControlStateNormal];
    [_testBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_testBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_testBtn];

    //添加约束
    [self setMas];
}
- (void) setMas{

    [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toTest ];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
