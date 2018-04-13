//
//  AccountInfoTbCells.m
//  Fishes
//
//  Created by test on 2018/4/11.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AccountInfoTbCells.h"

@implementation AccountInfoTbCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UILabel *)info_label {
    if(_info_label == nil) {
        _info_label = [[UILabel alloc] init];
        _info_label.font = [UIFont systemFontOfSize:16];
        _info_label.textColor = deepBlackC;
        [self addSubview:_info_label];
        [_info_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_offset(spaceM);
        }];
    }
    return _info_label;
}
- (UIImageView *)avatar {
    if(_avatar == nil) {
        _avatar = [[UIImageView alloc] init];
        [self addSubview:_avatar];
    }
    return _avatar;
}
- (UIImageView *)goV {
    if(_goV == nil) {
        _goV = [[UIImageView alloc] init];
        _goV.image  = [UIImage imageNamed:@"blackGoArrow"];
        [self addSubview:_goV];
        [_goV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_offset(-spaceM);
        }];
    }
    return _goV;
}

- (UILabel *)right_label {
    if(_right_label == nil) {
        _right_label = [[UILabel alloc] init];
        _right_label.font = [UIFont systemFontOfSize:14];
        _right_label.textColor = midBlackC;
        [self addSubview:_right_label];
    }
    return _right_label;
}

- (UIView *)lineV{
    if(_lineV == nil) {
        _lineV = [[UIView alloc] init];
        [self addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-1);
            make.width.mas_equalTo(ScreenW);
            make.height.mas_equalTo(0.7);
        }];
    }
    return _lineV;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
