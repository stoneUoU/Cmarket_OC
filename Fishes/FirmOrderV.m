//
//  FirmOrderV.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "FirmOrderV.h"
@implementation FirmOrderV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _doBtn = [[UIButton alloc] init];
    _doBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _doBtn.backgroundColor = styleColor;
    _doBtn.layer.cornerRadius = 22;
    [_doBtn setTitle:@"back to RootVC" forState:UIControlStateNormal];
    [_doBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [_doBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doBtn];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_doBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(ScreenW - (spaceM*2));
        make.height.mas_equalTo(44);
    }];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toDo ];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
