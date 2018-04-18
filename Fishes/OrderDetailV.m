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
    _orderMs = [[OrderMs alloc] init];
    return [super init];
}
- (void)setUpUI{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"问答",@"倾述",nil];
    _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    _segmentedControl.frame = CGRectZero;
    _segmentedControl.selectedSegmentIndex = 0;
    _segmentedControl.tintColor = styleColor;
    [_segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_segmentedControl];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
}

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
{
    //我定义了一个 NSInteger tag，是为了记录我当前选择的是分段控件的左边还是右边。
    NSInteger selecIndex = sender.selectedSegmentIndex;
    switch(selecIndex){
        case 0:
            sender.selectedSegmentIndex=0;
            break;

        case 1:
            sender.selectedSegmentIndex = 1;
            break;
        default:
            break;
    }
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
