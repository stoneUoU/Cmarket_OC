//
//  HomeTbCells.m
//  Fishes
//
//  Created by test on 2018/3/22.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HomeTbCells.h"

@implementation HomeTbCells

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

//懒加载：

- (UIImageView *)product_icon {
    if(_product_icon == nil) {
        _product_icon = [[UIImageView alloc] init];
        [self addSubview:_product_icon];
    }
    return _product_icon;
}

- (UILabel *)product_title {
    if(_product_title == nil) {
        _product_title = [[UILabel alloc] init];
        _product_title.font = [UIFont adjustFont:16];//[UIFont systemFontOfSize:16];
        _product_title.numberOfLines = 2;
        _product_title.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_product_title];
    }
    return _product_title;
}

- (void)createV{

    [self product_icon];
    [self product_title];

    _product_small_title = [[CustomLabel alloc] init];
    _product_small_title.font = [UIFont systemFontOfSize:10];
    _product_small_title.backgroundColor = [UIColor color_HexStr:@"f8dbd3"];
    _product_small_title.textColor = [UIColor color_HexStr:@"d73509"];
    _product_small_title.layer.cornerRadius = 3;
    _product_small_title.layer.masksToBounds = true;
    _product_small_title.textAlignment = NSTextAlignmentCenter;
    _product_small_title.leftEdge = 5;
    _product_small_title.rightEdge = 5;
    [self addSubview:_product_small_title];

    _product_unit = [[UILabel alloc] init];
    _product_unit.font = [UIFont systemFontOfSize:12];
    _product_unit.textColor = [UIColor color_HexStr:@"d73509"];
    _product_unit.text = @"￥";
    [self addSubview:_product_unit];

    _product_price = [[UILabel alloc] init];
    _product_price.font = [UIFont systemFontOfSize:18];
    _product_price.textColor = [UIColor color_HexStr:@"d73509"];
    [self addSubview:_product_price];


    _doBtn = [[TransferBtn alloc] init];
    _doBtn.layer.cornerRadius = 5;
    _doBtn.layer.masksToBounds = true;
    _doBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_doBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    [self addSubview:_doBtn];

    _product_attr = [[CustomLabel alloc] init];
    _product_attr.font = [UIFont systemFontOfSize:10];
    _product_attr.backgroundColor = [UIColor color_HexStr:@"e16847"];
    _product_attr.textColor = [UIColor whiteColor];
    _product_attr.layer.cornerRadius = 3;
    _product_attr.layer.masksToBounds = true;
    _product_attr.textAlignment = NSTextAlignmentCenter;
    _product_attr.leftEdge = 5;
    _product_attr.rightEdge = 5;
    [self addSubview:_product_attr];

    _progress_bar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress_bar.layer.cornerRadius = 3;
    _progress_bar.layer.masksToBounds = true;
    _progress_bar.layer.borderColor = [progress_barC CGColor];
    _progress_bar.layer.borderWidth = 1;
    _progress_bar.progressTintColor = progress_barC;  // 已走过的颜色
    _progress_bar.trackTintColor = [UIColor whiteColor];  // 为走过的颜色
    [self addSubview:_progress_bar];

    _progress_bar_vals = [[UILabel alloc] init];
    _progress_bar_vals.font = [UIFont systemFontOfSize:10];
    _progress_bar_vals.textColor = deepBlackC;
    [self addSubview:_progress_bar_vals];
    //倒计时
    _count_down = [[UILabel alloc] init];
    _count_down.font = [UIFont systemFontOfSize:12];
    _count_down.textColor = deepBlackC;
    [self addSubview:_count_down];

    //距开始：：：距结束
    _start_end = [[UILabel alloc] init];
    _start_end.font = [UIFont systemFontOfSize:13];
    _start_end.textColor = deepBlackC;
    [self addSubview:_start_end];

    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_product_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(2);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];

    [_product_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(_product_icon.mas_right).offset(4);
        make.right.equalTo(self.mas_right).offset(-spaceM);
    }];

    [_product_small_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_product_title.mas_bottom).offset(10);
        make.left.equalTo(_product_title.mas_left).offset(0);
    }];

    [_product_attr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_product_title.mas_left).offset(0);
        make.height.mas_equalTo(17);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];

    [_progress_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-spaceM);
        make.height.mas_equalTo(8);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(80);
    }];

    [_progress_bar_vals mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_progress_bar);
        make.right.equalTo(_progress_bar.mas_left).offset(-5);
    }];

    [_product_unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_product_attr.mas_top).offset(-5);
        make.left.equalTo(_product_title.mas_left).offset(0);
    }];

    [_product_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_product_unit.mas_right).offset(2);
        make.bottom.equalTo(_product_unit.mas_bottom).offset(2);
    }];

    [_doBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_progress_bar.mas_top).offset(-5);
        make.right.equalTo(self.mas_right).offset(-spaceM);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    [_count_down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_doBtn.mas_top).offset(-15);
        make.centerX.equalTo(_doBtn);
    }];

    [_start_end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_count_down.mas_top).offset(-8);
        make.centerX.equalTo(_doBtn);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
