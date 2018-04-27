//
//  MineTbCells.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineTbCells.h"

@implementation MineTbCells

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createV];
    }
    return  self;
}
- (void)createV{

    _part_icon = [[UIImageView alloc] init];
    [self addSubview:_part_icon];

    _part_name = [[UILabel alloc] init];
    _part_name.font = [UIFont systemFontOfSize:16];
    _part_name.textColor = deepBlackC;
    [self addSubview:_part_name];

    _goV = [[UIImageView alloc] init];
    _goV.image  = [UIImage imageNamed:@"blackGoArrow"];
    [self addSubview:_goV];

    _lineV = [[UIView alloc] init];
    _lineV.backgroundColor  = [UIColor whiteColor];
    [self addSubview:_lineV];

    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_part_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(spaceM);
    }];

    [_part_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_part_icon.mas_right).offset(6);
    }];

    [_goV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-spaceM);
    }];

    [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-0.5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(0.5);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
