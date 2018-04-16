//
//  OrderDetailV.m
//  Fishes
//
//  Created by test on 2018/4/16.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderDetailV.h"

@implementation OrderDetailV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (id)init
{
    _orderMs = [NSMutableDictionary dictionary];
    return [super init];
}
- (void)setUpUI{

    //添加约束
    [self setMas];
}
- (void) setMas{
//    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.mas_equalTo(ScreenW - (spaceM*2));
//        make.height.mas_equalTo(44);
//    }];
}
//按钮、手势函数写这
//- (void)toDo:(UIButton *)sender{
//    [_delegate toR ];
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
