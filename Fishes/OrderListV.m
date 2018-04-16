//
//  OrderListV.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderListV.h"
#import "OrderListTbCells.h"
@implementation OrderListV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}

- (id)init
{
    _orderMs = [NSMutableArray array];
    return [super init];
}

- (void)setUpUI{

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[OrderListTbCells class] forCellReuseIdentifier: @"orderListTbCells"];
    //添加下拉刷新头
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(freshDs)];
    _tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMDs)];
    // 马上进入刷新状态
    [self addSubview:_tableV];

    //添加约束
    [self setMas];
}
- (void) setMas{

    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH - StatusBarAndNavigationBarH - TabbarSafeBottomM - 44);
    }];
}


// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_orderMs count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*StScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = someTableCellC;
    //给headerV渲染数据啦啦啦
    OrderMs *orderMs = _orderMs[section];

    UIView *tenPtV = [[UIView alloc] init ];
    tenPtV.backgroundColor = someTableCellC;
    [headerV addSubview:tenPtV];
    [tenPtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerV.mas_top).offset(0);
        make.left.equalTo(headerV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(10*StScaleH);
    }];

    UIView *whiteV = [[UIView alloc] init ];
    whiteV.backgroundColor = [UIColor whiteColor];
    [headerV addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tenPtV.mas_bottom).offset(0);
        make.left.equalTo(headerV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];


    UIImageView *iconV = [[UIImageView alloc] init ];
    [iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:orderMs.shop_avatar]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    [whiteV addSubview:iconV];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whiteV);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(20);
    }];

    UILabel *payStatus = [[UILabel alloc] init];
    payStatus.font = [UIFont systemFontOfSize:13];
    payStatus.textColor = styleColor;
    if ([orderMs.consumer_status isEqual: @"0"]) {
        payStatus.text = @"交易关闭";
    }else if ([orderMs.consumer_status isEqual: @"1"]) {
        payStatus.text = @"待付款";
    }else if ([orderMs.consumer_status isEqual: @"2"]) {
        payStatus.text = @"拼单中";
    }else if ([orderMs.consumer_status isEqual: @"3"] || [orderMs.consumer_status isEqual: @"4"] || [orderMs.consumer_status isEqual: @"5"]) {
        payStatus.text = @"待收货";
    }else if ([orderMs.consumer_status isEqual: @"6"]) {
        payStatus.text = @"待评价";
    }else if ([orderMs.consumer_status isEqual: @"8"]) {
        payStatus.text = @"已完成";
    }
    //payStatus.text = @"代付款";
    payStatus.textAlignment = NSTextAlignmentRight;
    [whiteV addSubview:payStatus];
    [payStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceM);
        make.width.mas_greaterThanOrEqualTo(42*StScaleH);
        make.centerY.equalTo(whiteV);
    }];

    UILabel *market = [[UILabel alloc] init];
    market.font = [UIFont systemFontOfSize:14];
    market.textColor = deepBlackC;
    market.text = [NSString stringWithFormat:@"%@",orderMs.shop_name];
    market.textAlignment = NSTextAlignmentLeft;
    market.numberOfLines = 1;
    [whiteV addSubview:market];
    [market mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconV.mas_right).offset(5);
        make.right.equalTo(payStatus.mas_left).offset(-5);
        make.centerY.equalTo(whiteV);
    }];
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 54*StScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    footerV.backgroundColor = [UIColor whiteColor];

    //给footerV渲染数据啦啦啦
    OrderMs *orderMs = _orderMs[section];

    UIView *moneyV = [[UIView alloc] init ];
    [footerV addSubview:moneyV];
    [moneyV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerV.mas_top).offset(0);
        make.left.equalTo(footerV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    UILabel *totalFee = [[UILabel alloc] init];
    totalFee.font = [UIFont systemFontOfSize:16];
    totalFee.textColor = deepBlackC;
    totalFee.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[NSString stringWithFormat:@"%@",[FormatDs retainPoint:@"0.00" floatV:[orderMs.order_amount_total floatValue]]]] andSymbolsC:deepBlackC];
    totalFee.textAlignment = NSTextAlignmentRight;
    [moneyV addSubview:totalFee];
    [totalFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceM);
        make.centerY.equalTo(moneyV);
    }];

    UILabel *shopAL = [[UILabel alloc] init];
    shopAL.font = [UIFont systemFontOfSize:13];
    shopAL.textColor = deepBlackC;
    shopAL.text =[[@"共" stringByAppendingString:[NSString stringWithFormat:@"%@",orderMs.num]] stringByAppendingString:@"件商品，合计："];
    shopAL.textAlignment = NSTextAlignmentRight;
    [moneyV addSubview:shopAL];
    [shopAL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totalFee.mas_left).offset(0);
        make.centerY.equalTo(moneyV);
    }];
    //0.7V分割线
    UIView *senvePPtV = [[UIView alloc] init ];
    senvePPtV.backgroundColor = cutOffLineC;
    [moneyV addSubview:senvePPtV];
    [senvePPtV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(moneyV.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(0.7);
    }];
    UIView *doV = [[UIView alloc] init ];
    [footerV addSubview:doV];
    [doV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyV.mas_bottom).offset(0);
        make.left.equalTo(footerV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    UIButton *detailB = [[UIButton alloc] init ];
    detailB.titleLabel.font=[UIFont systemFontOfSize:14];
    detailB.layer.cornerRadius = 4;
    detailB.layer.borderColor = [deepBlackC CGColor];
    detailB.layer.borderWidth = 1;
    detailB.tag = 0;
    detailB.st_acceptEventInterval = 2;
    [detailB setTitle:@"查看详情" forState:UIControlStateNormal];
    [detailB setTitleColor:deepBlackC  forState:UIControlStateNormal];
    [detailB addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    detailB.hidden = [[NSString stringWithFormat:@"%@",orderMs.num]  isEqual: @"1"] ? YES : NO;
    [doV addSubview:detailB];
    [detailB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(doV);
        make.right.mas_equalTo(-spaceM);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(27*StScaleH);
    }];

    UIButton *payB = [[UIButton alloc] init ];
    payB.titleLabel.font=[UIFont systemFontOfSize:14];
    payB.layer.cornerRadius = 4;
    payB.layer.borderColor = [deepBlackC CGColor];
    payB.layer.borderWidth = 1;
    payB.tag = 1;
    payB.st_acceptEventInterval = 2;
    payB.hidden = [[NSString stringWithFormat:@"%@",orderMs.num]  isEqual: @"1"] ? NO : YES;
    [payB setTitle:@"立即付款" forState:UIControlStateNormal];
    [payB setTitleColor:deepBlackC  forState:UIControlStateNormal];
    [payB addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
    [doV addSubview:payB];
    [payB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(doV);
        [[NSString stringWithFormat:@"%@",orderMs.num]  isEqual: @"1"] ?make.right.mas_equalTo(-spaceM) : make.right.equalTo(detailB.mas_left).offset(-spaceM);
        make.width.mas_equalTo(72);
        make.height.mas_equalTo(27*StScaleH);
    }];

    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 88*StScaleH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListTbCells *Cell = [tableView dequeueReusableCellWithIdentifier:@"orderListTbCells"];
    if (!Cell){
        Cell = [[OrderListTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderListTbCells"];
    }
    OrderMs *orderMs = _orderMs[indexPath.section];
    Cell.backgroundColor = someTableCellC;
    Cell.introLab.text = [NSString stringWithFormat:@"%@",orderMs.group_title];
    Cell.priceLab.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[NSString stringWithFormat:@"%@",[FormatDs retainPoint:@"0.00" floatV:[orderMs.product_price floatValue] - [orderMs.product_discount floatValue]]]] andSymbolsC:styleColor];
    Cell.amount.attributedText = [MethodFunc strWithSymbolsS:[@"X" stringByAppendingString:[NSString stringWithFormat:@"%@",orderMs.num]] andSymbolsC:midBlackC];
    [Cell.caiIcon sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:orderMs.small_pic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate toGo:indexPath.section row:indexPath.row];
}

//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    STLog(@"被点击");
}
- (void)freshDs{
    [self.delegate toRefresh];
}
- (void)loadMDs{
    [self.delegate toLoadM];
}
//    _testBtn = [[UIButton alloc] init];
//    _testBtn.titleLabel.font=[UIFont systemFontOfSize:16];
//    _testBtn.backgroundColor = styleColor;
//    _testBtn.layer.cornerRadius = 22;
//    [_testBtn setTitle:@"测试" forState:UIControlStateNormal];
//    [_testBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
//    [_testBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_testBtn];
//    [_testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.mas_equalTo(ScreenW - (spaceM*2));
//        make.height.mas_equalTo(44);
//    }];

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
