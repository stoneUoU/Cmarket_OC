//
//  DeliverAdsTbCells.m
//  Fishes
//
//  Created by test on 2018/4/17.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineAdsTbCells.h"

@implementation MineAdsTbCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (UILabel *)shipName {
    if(_shipName == nil) {
        _shipName = [[UILabel alloc] init];
        _shipName.font = [UIFont systemFontOfSize:16];
        _shipName.textColor = deepBlackC;
        [self addSubview:_shipName];
        [_shipName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15*StScaleH);
            make.left.mas_equalTo(spaceM);
        }];
    }
    return _shipName;
}
- (UILabel *)telInfo {
    if(_telInfo == nil) {
        _telInfo = [[UILabel alloc] init];
        _telInfo.font = [UIFont systemFontOfSize:16];
        _telInfo.textColor = deepBlackC;
        [self addSubview:_telInfo];
        [_telInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shipName);
            make.left.equalTo(self.shipName.mas_right).offset(spaceM);
        }];
    }
    return _telInfo;
}
- (UILabel *)delInfo {
    if(_delInfo == nil) {
        _delInfo = [[UILabel alloc] init];
        _delInfo.font = [UIFont systemFontOfSize:16];
        _delInfo.textColor = deepBlackC;
        _delInfo.numberOfLines = 0;
        [self addSubview:_delInfo];
        [_delInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(spaceM);
            make.right.mas_equalTo(-ScreenW/5);
            make.top.equalTo(self.shipName.mas_bottom).offset(10*StScaleH);
            make.bottom.equalTo(self).offset(-15*StScaleH);
        }];
    }
    return _delInfo;
}
- (UIView *)editV{
    if(_editV == nil) {
        _editV = [[UIView alloc] init];
        [self addSubview:_editV];
        [_editV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(self);
            make.width.mas_equalTo(ScreenW/5);
        }];
    }
    return _editV;
}
- (UIImageView *)editIV {
    if(_editIV == nil) {
        _editIV = [[UIImageView alloc] init];
        _editIV.image  = [UIImage imageNamed:@"bianji.png"];
        [self addSubview:_editIV];
        [_editIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.mas_equalTo(-spaceM);
        }];
    }
    return _editIV;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
