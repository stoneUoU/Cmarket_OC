//
//  OrderDetailV.m
//  Fishes
//
//  Created by test on 2018/4/16.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OrderDetailV.h"
#import "OrderListTbCells.h"
#import "UILabel+Deal.h"
@implementation OrderDetailV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (id)init
{
    _ifHideR = NO;
    _ifCloseD = NO;
    return [super init];
}
- (void)setUpUI{

    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [_tableV registerClass:[OrderListTbCells class] forCellReuseIdentifier: @"orderListTbCells"];
    // 马上进入刷新状态
    _tableV.showsVerticalScrollIndicator=NO;
    _tableV.backgroundColor = someTableCellC;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.estimatedRowHeight = 160;
    _tableV.estimatedSectionHeaderHeight = 100;
    _tableV.estimatedSectionFooterHeight = 100;
    [self addSubview:_tableV];
    
//    NSArray *segmentedArray = [NSArray arrayWithObjects:@"问答",@"倾述",nil];
//    _segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
//    _segmentedControl.frame = CGRectZero;
//    _segmentedControl.selectedSegmentIndex = 0;
//    _segmentedControl.tintColor = styleColor;
//    [_segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
//    [self addSubview:_segmentedControl];

    //添加约束
    [self setMas];
}
- (void) setMas{
//    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.mas_equalTo(180);
//        make.height.mas_equalTo(30);
//    }];
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-TabbarSafeBottomM);
        make.width.mas_equalTo(ScreenW);
    }];
}

#pragma  - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = someTableCellC;
    UIView *brownV = [STVFactory createVWithFrame:CGRectZero color:styleColor];
    [headerV addSubview:brownV];
    [brownV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(80*StScaleH);
    }];
    //订单状态:
    UILabel *statusV = [STVFactory createLabelWithFrame:CGRectZero text:@"" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
    switch ([_orderMs.consumer_status intValue]) {
        case 0:
            statusV.text = @"交易关闭";
            break;
        case 1:
            statusV.text = @"待付款";
            break;
        case 2:
            statusV.text = @"拼单中";
            break;
        case 3: case 4: case 5:
            statusV.text = @"待收货";
            break;
        case 6:
            statusV.text = @"待评价";
            break;
        case 8:
            statusV.text = @"已完成";
            break;
        default:
            break;
    }
    [brownV addSubview:statusV];
    [statusV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.centerY.mas_equalTo(brownV);
    }];
    //订单取消时间
    _cancelTime = [STVFactory createLabelWithFrame:CGRectZero text:@"" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft];
    [brownV addSubview:_cancelTime];
    [_cancelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(brownV);
        make.right.mas_equalTo(-spaceM);
    }];

    //预计到货时间
    UILabel *arriveTime = [STVFactory createLabelWithFrame:CGRectZero text:_orderMs != NULL ? [@"预计到货时间：" stringByAppendingString:_orderMs.create_time]:@"" color:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft];
    [brownV addSubview:arriveTime];
    [arriveTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(80*StScaleH/3);
    }];


    UIView *whiteV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    [headerV addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(brownV.mas_bottom).offset(10*StScaleH);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
    }];
    //收货地址信息:
    OrderSonAMs *addressM = _orderMs.address[0];
    UIView *addressV = [STVFactory createVWithFrame:CGRectZero color:[UIColor clearColor]];
    [whiteV addSubview:addressV];
    [addressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteV.mas_top).offset(10*StScaleH);
        make.left.width.mas_equalTo(whiteV);
        make.width.mas_equalTo(ScreenW);
        make.bottom.equalTo(whiteV.mas_bottom).offset(-10*StScaleH);
    }];
    UIImageView *iconV = [[UIImageView alloc] init ];
    iconV.image = [UIImage imageNamed:@"dingwei.png"];
    [addressV addSubview:iconV];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressV);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(21);
    }];
    //addressM
    UILabel *manInfo = [STVFactory createLabelWithFrame:CGRectZero text:_orderMs != NULL ? [@"收货人：" stringByAppendingString:addressM.consignee_name]:@"" color:deepBlackC font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft];
    [addressV addSubview:manInfo];
    [manInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconV.mas_right).offset(12);
        make.top.mas_equalTo(0);
    }];

    UILabel *telInfo = [STVFactory createLabelWithFrame:CGRectZero text:addressM.consignee_tel color:deepBlackC font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft];
    [addressV addSubview:telInfo];
    [telInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceM);
        make.centerY.equalTo(manInfo);
    }];
    //收货地址:
    UILabel *aInfo = [STVFactory createLabelWithFrame:CGRectZero text:_orderMs != NULL ? [@"收货地址：" stringByAppendingString:addressM.consignee_address] : @"" color:deepBlackC font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft];
    aInfo.numberOfLines = 0;
    [addressV addSubview:aInfo];
    [aInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(manInfo);
        make.top.equalTo(manInfo.mas_bottom).offset(10*StScaleH);
        make.right.mas_equalTo(-spaceM);
        make.bottom.mas_equalTo(0);
    }];

    UIView *titleV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    [headerV addSubview:titleV];
    [titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(whiteV.mas_bottom).offset(10*StScaleH);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
        make.bottom.equalTo(headerV);
    }];
    UIImageView *shopV = [[UIImageView alloc] init ];
    [shopV sd_setImageWithURL:[NSURL URLWithString:_orderMs != NULL ? [picUrl stringByAppendingString:_orderMs.shop_avatar]:@""] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    [titleV addSubview:shopV];
    [shopV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleV);
        make.left.mas_equalTo(spaceM);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(20);
    }];

    UILabel *marketV = [STVFactory createLabelWithFrame:CGRectZero text:_orderMs.shop_name color:deepBlackC font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft];
    marketV.numberOfLines = 1;
    [titleV addSubview:marketV];
    [marketV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopV.mas_right).offset(5);
        make.right.mas_equalTo(-spaceM);
        make.centerY.equalTo(titleV);
    }];
    return headerV;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    footerV.backgroundColor = someTableCellC;

    UIView *whiteV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    [footerV addSubview:whiteV];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(80*StScaleH);
    }];
    //运费:
    UILabel *feeV = [STVFactory createLabelWithFrame:CGRectZero text:@"运费" color:deepBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [whiteV addSubview:feeV];
    [feeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.mas_equalTo(13*StScaleH);
    }];

    DealLabel *oFeeV = [[DealLabel alloc] init];
    oFeeV.font = [UIFont systemFontOfSize:13];
    oFeeV.textColor = deepBlackC;
    [oFeeV sizeToFit];
    oFeeV.text = _orderMs != NULL ? [[@"(￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_orderMs.logistics_fee floatValue]]] stringByAppendingString:@")"] : @"";
    oFeeV.textAlignment = NSTextAlignmentLeft;
    [whiteV addSubview:oFeeV];
    [oFeeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteV.mas_right).offset(-spaceM);
        make.centerY.equalTo(feeV);
    }];
    UILabel *frontV = [STVFactory createLabelWithFrame:CGRectZero text:@"" color:deepBlackC font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight];
    if(![[NSString stringWithFormat:@"%@",_orderMs.actual_logistics_fee] isEqualToString:@"0"]){
        frontV.attributedText = [MethodFunc strWithSymbolsS:_orderMs != NULL ? [@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_orderMs.actual_logistics_fee floatValue]]] : @"￥" andSymbolsC:deepBlackC];
    }else{
        frontV.text = @"免运费";
    }
    [whiteV addSubview:frontV];
    [frontV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(oFeeV.mas_left).offset(0);
        make.centerY.equalTo(feeV);
    }];

    UILabel *couponV = [STVFactory createLabelWithFrame:CGRectZero text:@"优惠券" color:deepBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [whiteV addSubview:couponV];
    [couponV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(feeV.mas_bottom).offset(8*StScaleH);
    }];
    UILabel *descV = [STVFactory createLabelWithFrame:CGRectZero text:_orderMs != NULL ?  [@"-￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_orderMs.product_amount_total floatValue]-[_orderMs.order_amount_total floatValue] + [_orderMs.actual_logistics_fee floatValue]]] : @"" color:deepBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentRight];
    [whiteV addSubview:descV];
    [descV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteV.mas_right).offset(-spaceM);
        make.centerY.equalTo(couponV);
    }];

    UILabel *actFee = [STVFactory createLabelWithFrame:CGRectZero text:_orderMs.actual_logistics_fee == 0 ? @"实付款":@"实付款（含运费）" color:deepBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [whiteV addSubview:actFee];
    [actFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.bottom.mas_equalTo(-10*StScaleH);
    }];
    //实付款的值
    //[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_orderMs.order_amount_total floatValue]]] andSymbolsC:deepBlackC]
    UILabel *actM = [STVFactory createLabelWithFrame:CGRectZero text:@"" color:deepBlackC font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentRight];
    if (_orderMs != NULL){
        actM.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_orderMs.order_amount_total floatValue]]] andSymbolsC:deepBlackC];
    }
    [whiteV addSubview:actM];
    [actM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteV.mas_right).offset(-spaceM);
        make.centerY.equalTo(actFee);
    }];

    UIView *refundV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    //  1------>YES   0------->NO
    refundV.hidden = _ifHideR == 1 ? YES : NO;
    [refundV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toToggleV:)];
    [refundV addGestureRecognizer:tapInfo];
    [footerV addSubview:refundV];
    [refundV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(whiteV.mas_bottom).offset(10*StScaleH);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    UILabel *fontV = [STVFactory createLabelWithFrame:CGRectZero text:@"退款详情" color:deepBlackC font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
    [refundV addSubview:fontV];
    [fontV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.centerY.equalTo(refundV);
    }];

    UIImageView *iconV = [[UIImageView alloc] init ];
    iconV.image = _ifCloseD == 0 ?  [UIImage imageNamed:@"shangla.png"]: [UIImage imageNamed:@"xiala.png"];
    [refundV addSubview:iconV];
    [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-spaceM);
        make.centerY.equalTo(refundV);
    }];
    //退款信息
    OrderSonRMs *refundMs = _orderMs.refundment[0];
    UILabel *refundS = [STVFactory createLabelWithFrame:CGRectZero text:[refundMs.status  isEqual: @"5"] ? @"退款成功" : @"退款中" color:styleColor font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentRight];
    [refundV addSubview:refundS];
    [refundS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(iconV.mas_left).offset(-3);
        make.centerY.equalTo(refundV);
    }];

    UIView *infoV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    if (_ifHideR){
        infoV.hidden = YES;
    }else{
        infoV.hidden = _ifCloseD == 1 ? YES : NO;
    }
    [footerV addSubview:infoV];
    [infoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(refundV.mas_bottom).offset(0.7);
        make.width.mas_equalTo(ScreenW);
        [refundMs.status  isEqual: @"5"] ? make.height.mas_equalTo(105*StScaleH) : make.height.mas_equalTo(86*StScaleH);
    }];
    //退款流水号
    UILabel *waterNum = [STVFactory createLabelWithFrame:CGRectZero text:[@"退款流水号：" stringByAppendingString:_orderMs != NULL ? refundMs.refund_no : @""] color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [infoV addSubview:waterNum];
    [waterNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.mas_equalTo(15*StScaleH);
    }];
    //退款状态
    UILabel *statusV = [STVFactory createLabelWithFrame:CGRectZero text:@"退款状态：" color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [infoV addSubview:statusV];
    [statusV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(waterNum.mas_bottom).offset(10*StScaleH);
    }];

    UILabel *stateV = [STVFactory createLabelWithFrame:CGRectZero text:[refundMs.status  isEqual: @"5"] ? @"退款成功" : @"退款中" color:styleColor font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [infoV addSubview:stateV];
    [stateV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(statusV.mas_right).offset(0);
        make.centerY.equalTo(statusV);
    }];
    //退款金额
    UILabel *amountV = [STVFactory createLabelWithFrame:CGRectZero text:@"退款金额：" color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [infoV addSubview:amountV];
    [amountV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(statusV.mas_bottom).offset(10*StScaleH);
    }];

    UILabel *withdrawnV = [STVFactory createLabelWithFrame:CGRectZero text:@"" color:styleColor font:[UIFont systemFontOfSize:16] textAlignment:NSTextAlignmentLeft];
    withdrawnV.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[NSString stringWithFormat:@"%@",[FormatDs retainPoint:@"0.00" floatV:[refundMs.actual_refund_amount floatValue]]]] andSymbolsC:styleColor];
    [infoV addSubview:withdrawnV];
    [withdrawnV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amountV.mas_right).offset(0);
        make.centerY.equalTo(amountV);
    }];

    //退款时间
    UILabel *timeV = [STVFactory createLabelWithFrame:CGRectZero text:[@"退款时间：" stringByAppendingString:_orderMs != NULL ? refundMs.update_time : @""] color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    timeV.hidden = [refundMs.status  isEqual: @"5"] ? NO : YES;
    [infoV addSubview:timeV];
    [timeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(amountV.mas_bottom).offset(10*StScaleH);
    }];

    UIView *botInfoV = [STVFactory createVWithFrame:CGRectZero color:[UIColor whiteColor]];
    [footerV addSubview:botInfoV];
    [botInfoV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_ifHideR){
            make.top.equalTo(whiteV.mas_bottom).offset(10*StScaleH);
        }else{
            _ifCloseD == 1 ?  make.top.equalTo(refundV.mas_bottom).offset(10*StScaleH) : make.top.equalTo(infoV.mas_bottom).offset(10*StScaleH);
        }
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        if (_orderMs != NULL){
            if ([_orderMs.pay_time isEqual:@""]&&[_orderMs.delivery_time isEqual:@""]){
                make.height.mas_equalTo(90*StScaleH);
            }else if (![_orderMs.pay_time isEqual:@""]&&[_orderMs.delivery_time isEqual:@""]){
                make.height.mas_equalTo(110*StScaleH);
            }else{
                make.height.mas_equalTo(136*StScaleH);
            }
        }
    }];

    UILabel *orderNo = [STVFactory createLabelWithFrame:CGRectZero text:[@"订单编号：" stringByAppendingString:_orderMs != NULL ? _orderMs.order_no : @""] color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [botInfoV addSubview:orderNo];
    [orderNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.mas_equalTo(15*StScaleH);
    }];
    //1:微信  2:支付宝
    UILabel *payM = [STVFactory createLabelWithFrame:CGRectZero text:[_orderMs.pay_type isEqual:@"1"] ? @"支付方式：微信支付" : @"支付方式：支付宝支付" color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [botInfoV addSubview:payM];
    [payM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(orderNo.mas_bottom).offset(10*StScaleH);
    }];

    UILabel *setTime = [STVFactory createLabelWithFrame:CGRectZero text:[@"创建时间：" stringByAppendingString:_orderMs != NULL ? _orderMs.create_time : @""] color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    [botInfoV addSubview:setTime];
    [setTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(payM.mas_bottom).offset(10*StScaleH);
    }];

    UILabel *payTime = [STVFactory createLabelWithFrame:CGRectZero text:[@"付款时间：" stringByAppendingString:_orderMs != NULL ? _orderMs.pay_time : @""] color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    payTime.hidden = [_orderMs.pay_time isEqual:@""] ? YES :NO;
    [botInfoV addSubview:payTime];
    [payTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.top.equalTo(setTime.mas_bottom).offset(10*StScaleH);
    }];

    UILabel *delTime = [STVFactory createLabelWithFrame:CGRectZero text:[@"发货时间：" stringByAppendingString:_orderMs != NULL ? _orderMs.delivery_time : @""] color:midBlackC font:[UIFont systemFontOfSize:11] textAlignment:NSTextAlignmentLeft];
    delTime.hidden = [_orderMs.delivery_time isEqual:@""] ? YES :NO;
    [botInfoV addSubview:delTime];
    [delTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceM);
        make.bottom.equalTo(botInfoV.mas_bottom).offset(-15*StScaleH);
    }];
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_ifHideR){
        return 330*StScaleH;
    }else{
        return (_ifCloseD == 1 ? 375*StScaleH : 480*StScaleH);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListTbCells *cells = [tableView dequeueReusableCellWithIdentifier:@"orderListTbCells"];
    if (!cells){
        cells = [[OrderListTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderListTbCells"];
    }
    cells.selectionStyle =NO;
    cells.backgroundColor = someTableCellC;
    if (_orderMs != NULL){
        cells.introLab.text = [NSString stringWithFormat:@"%@",_orderMs.group_title];
        cells.priceLab.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[NSString stringWithFormat:@"%@",[FormatDs retainPoint:@"0.00" floatV:[_orderMs.product_price floatValue] - [_orderMs.product_discount floatValue]]]] andSymbolsC:styleColor];
        cells.amount.attributedText = [MethodFunc strWithSymbolsS:[@"X" stringByAppendingString:[NSString stringWithFormat:@"%@",_orderMs.num]] andSymbolsC:midBlackC];
        [cells.caiIcon sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:_orderMs.small_pic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    }
    return cells;
}

- (void)toToggleV:(id)sender{
    [_delegate toToggleV];
}
//-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender
//{
//    //我定义了一个 NSInteger tag，是为了记录我当前选择的是分段控件的左边还是右边。
//    NSInteger selecIndex = sender.selectedSegmentIndex;
//    switch(selecIndex){
//        case 0:
//            sender.selectedSegmentIndex=0;
//            break;
//
//        case 1:
//            sender.selectedSegmentIndex = 1;
//            break;
//        default:
//            break;
//    }
//}

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
