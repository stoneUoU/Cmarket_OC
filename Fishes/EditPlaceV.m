//
//  EditPlaceV.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "EditPlaceV.h"
@interface EditPlaceV(){
    UIView *_outV;

    UILabel *_manGet;

    UIView *_firstLine;

    UILabel *_contactM;

    UIView *_secondLine;

    UILabel *_goodPlace;

    UIView *_thirdLine;

    UIView *_fourthLine;

    UILabel *_defaultP;
}
@end
@implementation EditPlaceV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{
    _outV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    [self addSubview:_outV];

    _manGet = [STVFactory createLabelWithFrame:CGRectZero text:@"收货人" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    [_outV addSubview:_manGet];

    _manField = [STVFactory createTextFieldWithFrame:CGRectZero placeholder:@"收货人姓名" color:deepBlackC font:[UIFont systemFontOfSize:15] secureTextEntry:NO delegate:self];
    [_outV addSubview:_manField];

    _firstLine = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [_outV addSubview:_firstLine];

    _contactM = [STVFactory createLabelWithFrame:CGRectZero text:@"联系方式" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    [_outV addSubview:_contactM];

    _telField = [STVFactory createTextFieldWithFrame:CGRectZero placeholder:@"联系方式" color:deepBlackC font:[UIFont systemFontOfSize:15] secureTextEntry:NO delegate:self];
    [_outV addSubview:_telField];

    _secondLine = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [_outV addSubview:_secondLine];

    _goodPlace = [STVFactory createLabelWithFrame:CGRectZero text:@"收货地址" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    [_outV addSubview:_goodPlace];

    _placeField = [STVFactory createTextFieldWithFrame:CGRectZero placeholder:@"收货地址" color:labelDisable font:[UIFont systemFontOfSize:15] secureTextEntry:NO delegate:self];
    _placeField.userInteractionEnabled = NO;
    [_outV addSubview:_placeField];

    _thirdLine = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [_outV addSubview:_thirdLine];

    _delField = [STVFactory createTextFieldWithFrame:CGRectZero placeholder:@"详情地址" color:labelDisable font:[UIFont systemFontOfSize:15] secureTextEntry:NO delegate:self];
    _delField.userInteractionEnabled = NO;
    [_outV addSubview:_delField];

    _fourthLine = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [_outV addSubview:_fourthLine];

    _defaultP = [STVFactory createLabelWithFrame:CGRectZero text:@"默认地址" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    [_outV addSubview:_defaultP];

    _switchBtn = [[UISwitch alloc] init];
    _switchBtn.enabled = NO;
    _switchBtn.onTintColor = styleColor;
    [_outV addSubview:_switchBtn];

    _saveBtn = [STVFactory createBtnWithFrame:CGRectZero title:@"保存" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] target:self action:@selector(toDo:)];
    _saveBtn.backgroundColor = styleColor;
    _saveBtn.layer.cornerRadius = 22;
    [self addSubview:_saveBtn];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_outV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*StScaleH);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(230*StScaleH);
    }];
    [_manGet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10*StScaleH);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenInfo.width/4);
        make.height.mas_equalTo(24*StScaleH);
    }];
    [_manField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.equalTo(_manGet.mas_right).offset(0);
        make.width.mas_equalTo(3*ScreenW/4 - spaceM);
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_manField.mas_bottom).offset(-0.7);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.7);
    }];

    [_contactM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstLine.mas_bottom).offset(10*StScaleH);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenInfo.width/4);
        make.height.mas_equalTo(24*StScaleH);
    }];
    [_telField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstLine.mas_bottom).offset(0);
        make.left.equalTo(_contactM.mas_right).offset(0);
        make.width.mas_equalTo(3*ScreenW/4 - spaceM);
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telField.mas_bottom).offset(-0.7);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.7);
    }];
    [_goodPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondLine.mas_bottom).offset(10*StScaleH);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenInfo.width/4);
        make.height.mas_equalTo(24*StScaleH);
    }];
    [_placeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secondLine.mas_bottom).offset(0);
        make.left.equalTo(_goodPlace.mas_right).offset(0);
        make.width.mas_equalTo(3*ScreenW/4 - spaceM);
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_placeField.mas_bottom).offset(-0.7);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.7);
    }];
    [_delField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_thirdLine.mas_bottom).offset(0);
        make.left.equalTo(_goodPlace.mas_right).offset(0);
        make.width.mas_equalTo(3*ScreenW/4 - spaceM);
        make.height.mas_equalTo(44*StScaleH);
    }];
    [_fourthLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_delField.mas_bottom).offset(-0.7);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenW - spaceM);
        make.height.mas_equalTo(0.7);
    }];
    [_defaultP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fourthLine.mas_bottom).offset(10*StScaleH);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenInfo.width/4);
        make.height.mas_equalTo(24*StScaleH);
    }];
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fourthLine.mas_bottom).offset(10*StScaleH);
        make.right.mas_equalTo(-spaceM);
    }];

    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_outV.mas_bottom).offset(24*StScaleH);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(ScreenW - 2*spaceM);
        make.height.mas_equalTo(44*StScaleH);
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
