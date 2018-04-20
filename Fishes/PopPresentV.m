//
//  PopPresentV.m
//  Fishes
//
//  Created by test on 2018/4/19.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "PopPresentV.h"
@implementation PopPresentV
- (id)init
{
    self.AC = 1;
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{
    _submitB = [[UILabel alloc] init];
    _submitB.backgroundColor = styleColor;
    _submitB.text = @"确定";
    [_submitB setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapCoupon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toSubmit:)];
    [_submitB addGestureRecognizer:tapCoupon];
    _submitB.textColor = [UIColor whiteColor];
    _submitB.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_submitB];

    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    //给tableV注册Cells
    [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier: @"cells"];
    // 马上进入刷新状态
    _tableV.estimatedRowHeight = 160;  //将tableview的estimatedRowHeight设大一点
    _tableV.showsVerticalScrollIndicator=NO;
    _tableV.backgroundColor = someTableCellC;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.rowHeight = UITableViewAutomaticDimension;
    [self addSubview:_tableV];

    //添加约束
    [self setMas];
}
- (void) setMas{

    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(ScreenW*3/5 - 44*StScaleH);
        make.width.mas_equalTo(ScreenW);
    }];
    [_submitB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(_tableV.mas_bottom).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];
}

#pragma  - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    UIImageView *iconV = [[UIImageView alloc] init ];
    [iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:_homeDetailMs.small_pic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    [headerV addSubview:iconV];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(4*StScaleH);
        make.left.mas_equalTo(spaceM);
        make.width.height.mas_equalTo(85);
    }];

    _closeB = [[UIButton alloc] init];
    _closeB.titleLabel.font=[UIFont systemFontOfSize:16];
    [_closeB setTitle:@"关闭" forState:UIControlStateNormal];
    [_closeB setTitleColor:styleColor  forState:UIControlStateNormal];
    [_closeB addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:_closeB];
    [_closeB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceM);
        make.top.equalTo(headerV).offset(6*StScaleH);
    }];

    UILabel *priceInfo = [[UILabel alloc] init];
    priceInfo.font = [UIFont systemFontOfSize:16];
    priceInfo.textColor = styleColor;
    priceInfo.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_homeDetailMs.discount_price floatValue]]] andSymbolsC:styleColor];
    [headerV addSubview:priceInfo];
    [priceInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconV.mas_right).offset(spaceM);
        make.top.mas_equalTo(32*StScaleH);
    }];

    UILabel *infoLab = [[UILabel alloc] init];
    infoLab.font = [UIFont systemFontOfSize:13];
    infoLab.textColor = deepBlackC;
    infoLab.text = @"请选择：数量";
    [headerV addSubview:infoLab];
    [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconV.mas_right).offset(spaceM);
        make.top.equalTo(priceInfo.mas_bottom).offset(10*StScaleH);
    }];

    UIView *lineV = [[UIView alloc]init ];
    lineV.backgroundColor = cutOffLineC;
    [headerV addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.equalTo(iconV.mas_bottom).offset(4*StScaleH);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(0.5);
    }];

    UILabel *amountLab = [[UILabel alloc] init];
    amountLab.font = [UIFont systemFontOfSize:13];
    amountLab.textColor = deepBlackC;
    amountLab.text = @"数量";
    [headerV addSubview:amountLab];
    [amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(lineV.mas_bottom).offset(20*StScaleH);
    }];

    _numBtn = [[PPNumberButton alloc] init];
    // 开启抖动动画
    _numBtn.shakeAnimation = YES;
    // 设置最小值
    _numBtn.minValue = 1;
    // 设置最大值
    _numBtn.maxValue = [_homeDetailMs.total_inventory intValue] - [_homeDetailMs.freeze_inventory intValue];
    // 设置输入框中的字体大小
    _numBtn.inputFieldFont = 16;
    _numBtn.increaseTitle = @"＋";
    _numBtn.decreaseTitle = @"－";
    _numBtn.currentNumber = 1;
    _numBtn.delegate = self;
    _numBtn.longPressSpaceTime = CGFLOAT_MAX;
    __weak __typeof(self) weakSelf = self;
    _numBtn.resultBlock = ^(PPNumberButton *ppBtn, NSInteger number, BOOL increaseStatus){
        //[weakSelf.delegate toPlusDescC:number];
        weakSelf.AC = number;
    };
    [headerV addSubview:_numBtn];
    [_numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceM);
        make.centerY.equalTo(amountLab);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(28);
    }];
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScreenW * 3 / 5 - 44*StScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
//按钮、手势函数写这
- (void)toSubmit:(UIButton *)sender{
    [_delegate toCloseSelf:self.AC];
}

- (void)toDo:(UIButton *)sender{
    [_delegate toCloseV];
}

@end

