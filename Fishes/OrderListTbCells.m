//
//  OrderListTbCells.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderListTbCells.h"

@implementation OrderListTbCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UIImageView *)caiIcon {
    if(_caiIcon == nil) {
        _caiIcon = [[UIImageView alloc] init];
        [self addSubview:_caiIcon];
        [_caiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.greaterThanOrEqualTo(self.mas_top).offset(10*StScaleH);
            make.left.mas_equalTo(spaceM);
            make.width.height.mas_equalTo(80*StScaleH);
            make.centerY.equalTo(self);
        }];
    }
    return _caiIcon;
}
- (UILabel *)introLab {
    if(_introLab == nil) {
        _introLab = [[UILabel alloc] init];
        _introLab.font = [UIFont systemFontOfSize:13];
        _introLab.textColor = deepBlackC;
        _introLab.numberOfLines = 0;
        [self addSubview:_introLab];
        [_introLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.caiIcon.mas_top).offset(0);
            make.left.equalTo(self.caiIcon.mas_right).offset(spaceM);
            make.right.mas_equalTo(-spaceM);
        }];
    }
    return _introLab;
}

- (UILabel *)priceLab {
    if(_priceLab == nil) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:18];
        _priceLab.textColor = styleColor;
        [self addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.caiIcon.mas_right).offset(spaceM);
            make.bottom.equalTo(self.caiIcon.mas_bottom).offset(0);
        }];
    }
    return _priceLab;
}
- (UILabel *)amount {
    if(_amount == nil) {
        _amount = [[UILabel alloc] init];
        _amount.font = [UIFont systemFontOfSize:16];
        _amount.textColor = midBlackC;
        [self addSubview:_amount];
        [_amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.priceLab);
            make.right.mas_equalTo(-spaceM);
        }];
    }
    return _amount;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
