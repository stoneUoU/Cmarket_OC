//
//  LazyTbCells.m
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "LazyTbCells.h"

@implementation LazyTbCells
@synthesize product_title = _product_title;
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (UILabel *)product_title {
    if(_product_title == nil) {
        _product_title = [[UILabel alloc] init];
        _product_title.font = [UIFont systemFontOfSize:16];
        _product_title.numberOfLines = 2;
        _product_title.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_product_title];
        [_product_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return _product_title;
}

- (UILabel *)product_time {
    if(_product_time == nil) {
        _product_time = [[UILabel alloc] init];
        _product_time.font = [UIFont systemFontOfSize:16];
        _product_time.numberOfLines = 2;
        _product_time.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_product_time];
        [_product_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.product_title.mas_bottom).offset(0);
            make.centerX.equalTo(self);
        }];
    }
    return _product_time;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
