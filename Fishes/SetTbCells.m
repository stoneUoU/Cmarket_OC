//
//  SetTbCells.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SetTbCells.h"

@implementation SetTbCells

- (UILabel *)infoV {
    if(_infoV == nil) {
        _infoV = [[UILabel alloc] init];
        _infoV.font = [UIFont systemFontOfSize:16];
        _infoV.textColor = deepBlackC;
        [self addSubview:_infoV];
        MASAttachKeys(_infoV);
        [_infoV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.mas_equalTo(spaceM);
        }];
    }
    return _infoV;
}
- (UILabel *)sideV {
    if(_sideV == nil) {
        _sideV = [[UILabel alloc] init];
        _sideV.font = [UIFont systemFontOfSize:14];
        _sideV.textColor = midBlackC;
        _sideV.textAlignment = NSTextAlignmentRight;
        [self addSubview:_sideV];
        MASAttachKeys(_sideV);
        [_sideV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.goV.mas_left).offset(-6);
        }];
    }
    return _sideV;
}
- (UIImageView *)goV {
    if(_goV == nil) {
        _goV = [[UIImageView alloc] init];
        _goV.image = [UIImage imageNamed:@"blackGoArrow"];
        [self addSubview:_goV];
        MASAttachKeys(_goV);
        [_goV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(-spaceM);
        }];
    }
    return _goV;
}
- (UIView *)lineV {
    if(_lineV == nil) {
        _lineV = [[UIView alloc] init];
        [self addSubview:_lineV];
        [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.equalTo(self.mas_bottom).offset(-0.7);
            make.height.mas_equalTo(0.7);
        }];
    }
    return _lineV;
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
