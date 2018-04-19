//
//  CouponTbCells.m
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CouponTbCells.h"

@implementation CouponTbCells
- (UILabel *)AP {
    if(_AP == nil) {
        _AP = [[UILabel alloc] init];
        _AP.font = [UIFont systemFontOfSize:16];
        _AP.textColor = styleColor;
        _AP.numberOfLines = 0;
        [self addSubview:_AP];
        [_AP mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15*StScaleH);
            make.left.mas_equalTo(spaceM);
        }];
    }
    return _AP;
}

- (UIButton *)typeBtn {
    if(_typeBtn == nil) {
        _typeBtn = [[UIButton alloc] init];
        _typeBtn.layer.cornerRadius = 3;
        _typeBtn.layer.masksToBounds = true;
        _typeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_typeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_typeBtn];
        [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.AP);
            make.left.equalTo(self.AP.mas_right).offset(5);
            make.width.mas_equalTo(42);
            make.height.mas_equalTo(15*StScaleH);
        }];
    }
    return _typeBtn;
}

- (UILabel *)useInfo {
    if(_useInfo == nil) {
        _useInfo = [[UILabel alloc] init];
        _useInfo.font = [UIFont systemFontOfSize:12];
        _useInfo.textColor = deepBlackC;
        _useInfo.numberOfLines = 0;
        [self addSubview:_useInfo];
        [_useInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.AP.mas_bottom).offset(5*StScaleH);
            make.left.mas_equalTo(spaceM);
            make.right.mas_equalTo(-3*spaceM);
        }];
    }
    return _useInfo;
}

- (UILabel *)timeLimit {
    if(_timeLimit == nil) {
        _timeLimit = [[UILabel alloc] init];
        _timeLimit.font = [UIFont systemFontOfSize:10];
        _timeLimit.textColor = midBlackC;
        [self addSubview:_timeLimit];
        [_timeLimit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(spaceM);
            make.top.equalTo(self.useInfo.mas_bottom).offset(5*StScaleH);
            make.bottom.equalTo(self).offset(-15*StScaleH);
        }];
    }
    return _timeLimit;
}


- (UIButton *)trueBtn {
    if(_trueBtn == nil) {
        _trueBtn = [[UIButton alloc] init];
        [self addSubview:_trueBtn];
        [_trueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(-spaceM);
        }];
    }
    return _trueBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
