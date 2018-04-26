//
//  FirmOrderV.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "FirmOrderV.h"
#import "MineAdsTbCells.h"
#import "OrderListTbCells.h"
@implementation FirmOrderV

- (id)init
{
    _selectM = 2;
    _mineAds = [NSMutableArray array];
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    //给tableV注册Cells
    [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier: @"cells"];
    [_tableV registerClass:[MineAdsTbCells class] forCellReuseIdentifier: @"mineAdsTbCells"];
    [_tableV registerClass:[OrderListTbCells class] forCellReuseIdentifier: @"orderListTbCells"];
    // 马上进入刷新状态
    _tableV.showsVerticalScrollIndicator=NO;
    _tableV.backgroundColor = someTableCellC;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.rowHeight = UITableViewAutomaticDimension;
    _tableV.estimatedRowHeight = 160;
    _tableV.estimatedSectionHeaderHeight = 100;
    _tableV.estimatedSectionFooterHeight = 100;
    [self addSubview:_tableV];

    _botV = [[UIView alloc] init];
    _botV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_botV];

    _totalA = [[UILabel alloc] init];
    _totalA.font = [UIFont systemFontOfSize:13];
    _totalA.textColor = deepBlackC;
    _totalA.text = @"合计金额:";
    [_botV addSubview:_totalA];


    _payBtn= [[UIButton alloc] init];
    _payBtn.backgroundColor = styleColor;
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [_payBtn sizeToFit];
    _payBtn.st_acceptEventInterval = 2;
    //6.通过代码为控件注册一个单机事件
    [_payBtn addTarget:self action:@selector(toPlaceO:) forControlEvents:UIControlEventTouchUpInside];
    [_botV addSubview:_payBtn];

    _totalFee= [[UILabel alloc] init];
    _totalFee.font = [UIFont systemFontOfSize:16];
    _totalFee.textColor = styleColor;
    [_botV addSubview:_totalFee];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_botV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(50*StScaleH);
    }];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.height.bottom.equalTo(_botV);
        make.width.mas_equalTo(ScreenW/3);
    }];
    [_totalA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_botV.mas_left).offset(spaceM);
        make.centerY.equalTo(_botV);
    }];
    [_totalFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalA.mas_right).offset(spaceM);
        make.centerY.equalTo(_botV);
    }];
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(0);
        make.bottom.equalTo(_botV.mas_top).offset(0);
        make.width.mas_equalTo(ScreenW);
    }];
}

#pragma  - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    switch (section) {
        case 1:
        {    
            headerV.backgroundColor = [UIColor whiteColor];
            UIImageView *iconV = [[UIImageView alloc] init ];
            if (_homeDetailMs != NULL){
                [iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:_homeDetailMs.vendor_avatar]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
            }
            [headerV addSubview:iconV];
            [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerV);
                make.left.mas_equalTo(spaceM);
                make.width.mas_equalTo(24);
                make.height.mas_equalTo(20);
            }];

            UILabel *market = [[UILabel alloc] init];
            market.font = [UIFont systemFontOfSize:14];
            market.textColor = deepBlackC;
            market.text = _homeDetailMs != NULL ? _homeDetailMs.vendor : @"";
            //market.text = [NSString stringWithFormat:@"%@",orderMs.shop_name];
            market.textAlignment = NSTextAlignmentLeft;
            market.numberOfLines = 1;
            [headerV addSubview:market];
            [market mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconV.mas_right).offset(5);
                make.right.mas_equalTo(-spaceM);
                make.centerY.equalTo(headerV);
            }];
            return headerV;
        }
        default:
            headerV.backgroundColor = someTableCellC;
            return headerV;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
    case 0:
        return 10*StScaleH;
    default:
        return 44*StScaleH;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    switch (section) {
        case 1:
        {
            footerV.backgroundColor = someTableCellC;
            UIView *countV = [[UIView alloc]init ];
            countV.backgroundColor = [UIColor whiteColor];
            [footerV addSubview:countV];
            [countV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(44*StScaleH);
            }];

            UILabel *countL = [[UILabel alloc] init];
            countL.font = [UIFont systemFontOfSize:16];
            countL.textColor = deepBlackC;
            countL.text = @"购买数量";
            countL.textAlignment = NSTextAlignmentLeft;
            [countV addSubview:countL];
            [countL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.centerY.equalTo(countV);
            }];

            _numBtn = [[PPNumberButton alloc] init];
            // 开启抖动动画
            _numBtn.shakeAnimation = YES;
            // 设置最小值
            _numBtn.minValue = 1;
            // 设置最大值
            if (_homeDetailMs != NULL){
                _numBtn.maxValue = [_homeDetailMs.total_inventory intValue] - [_homeDetailMs.freeze_inventory intValue];
            };
            // 设置输入框中的字体大小
            _numBtn.inputFieldFont = 16;
            _numBtn.increaseTitle = @"＋";
            _numBtn.decreaseTitle = @"－";
            _numBtn.currentNumber = _AC;
            _numBtn.delegate = self;
            _numBtn.longPressSpaceTime = CGFLOAT_MAX;
            __weak __typeof(self) weakSelf = self;
            _numBtn.resultBlock = ^(PPNumberButton *ppBtn, NSInteger number, BOOL increaseStatus){
                [weakSelf.delegate toPlusDescC:number];
            };
            [countV addSubview:_numBtn];
            [_numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-spaceM);
                make.centerY.equalTo(countV);
                make.width.mas_equalTo(105);
                make.height.mas_equalTo(28);
            }];

            UIView *first_lV = [[UIView alloc]init ];
            first_lV.backgroundColor = cutOffLineC;
            [footerV addSubview:first_lV];
            [first_lV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.bottom.equalTo(countV.mas_bottom).offset(-0.5);
                make.width.mas_equalTo(ScreenW - spaceM);
                make.height.mas_equalTo(0.5);
            }];
            //邮费
            UIView *delFeeV = [[UIView alloc]init ];
            delFeeV.backgroundColor = [UIColor whiteColor];
            [footerV addSubview:delFeeV];
            [delFeeV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(countV.mas_bottom).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(44*StScaleH);
            }];
            UILabel *delFeeL = [[UILabel alloc] init];
            delFeeL.font = [UIFont systemFontOfSize:16];
            delFeeL.textColor = deepBlackC;
            delFeeL.text = @"运费";
            delFeeL.textAlignment = NSTextAlignmentLeft;
            [delFeeV addSubview:delFeeL];
            [delFeeL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.centerY.equalTo(delFeeV);
            }];

            DealLabel *oFeeV = [[DealLabel alloc] init];
            oFeeV.font = [UIFont systemFontOfSize:13];
            oFeeV.textColor = deepBlackC;
            [oFeeV sizeToFit];
            oFeeV.text = [[@"(￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_homeDetailMs.logistics_fee floatValue]]] stringByAppendingString:@")"];
            oFeeV.textAlignment = NSTextAlignmentLeft;
            [delFeeV addSubview:oFeeV];
            [oFeeV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(delFeeV.mas_right).offset(-spaceM);
                make.centerY.equalTo(delFeeV);
            }];

            UILabel *frontV = [[UILabel alloc] init];
            frontV.font = [UIFont systemFontOfSize:13];
            frontV.textColor = deepBlackC;
            if (_homeDetailMs != NULL){
                if(![[NSString stringWithFormat:@"%@",_homeDetailMs.actual_logistics_fee] isEqualToString:@"0"]){
                frontV.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_homeDetailMs.actual_logistics_fee floatValue]]] andSymbolsC:deepBlackC];
                }else{
                    frontV.text = @"免运费";
                }
            }
            frontV.textAlignment = NSTextAlignmentRight;
            [delFeeV addSubview:frontV];
            [frontV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(oFeeV.mas_left).offset(0);
                make.centerY.equalTo(delFeeV);
            }];

            UIView *second_lV = [[UIView alloc]init ];
            second_lV.backgroundColor = cutOffLineC;
            [footerV addSubview:second_lV];
            [second_lV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.bottom.equalTo(delFeeV.mas_bottom).offset(-0.5);
                make.width.mas_equalTo(ScreenW - spaceM);
                make.height.mas_equalTo(0.5);
            }];

            //优惠券
            UIView *couponV = [[UIView alloc]init ];
            couponV.backgroundColor = [UIColor whiteColor];
            [couponV setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapCoupon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toCoupon:)];
            [couponV addGestureRecognizer:tapCoupon];
            [footerV addSubview:couponV];
            [couponV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(delFeeV.mas_bottom).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(44*StScaleH);
            }];
            UILabel *couponL = [[UILabel alloc] init];
            couponL.font = [UIFont systemFontOfSize:16];
            couponL.textColor = deepBlackC;
            couponL.text = @"优惠券";
            couponL.textAlignment = NSTextAlignmentLeft;
            [couponV addSubview:couponL];
            [couponL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.centerY.equalTo(couponV);
            }];
            //是否选有优惠券
            UIButton* ifSBtn= [[UIButton alloc] init];
            ifSBtn.backgroundColor = styleColor;
            [ifSBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            ifSBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            [ifSBtn setTitle:@"已选一张" forState:UIControlStateNormal];
            ifSBtn.layer.cornerRadius = 4;
            ifSBtn.layer.borderColor = [styleColor CGColor];
            ifSBtn.layer.borderWidth =  1;
            //self.firmOrderV.selMs
            ifSBtn.hidden = _selMs != NULL ? NO : YES;
            [couponV addSubview:ifSBtn];
            [ifSBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(couponL.mas_right).offset(spaceM);
                make.centerY.equalTo(couponV);
                make.height.mas_equalTo(18);
                make.width.mas_equalTo(48);
            }];
            UIImageView *toIcon  = [[UIImageView alloc] init];
            toIcon.image = [UIImage imageNamed:@"SeeAllArrow.png"];
            [couponV addSubview:toIcon];
            [toIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(couponV);
                make.right.mas_equalTo(-spaceM);
            }];
            //优惠券减了多少钱
            UILabel *descV = [[UILabel alloc] init];
            descV.font = [UIFont systemFontOfSize:16];
            descV.textColor = deepBlackC;
            if (_selMs != NULL) {
                switch (_selMs.coupon_type) {
                    case 1:  //满减
                        {
                            descV.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_selMs.face_value floatValue]]] andSymbolsC:deepBlackC];
                        }
                        break;
                    default:
                        {
                            descV.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:([_homeDetailMs.discount_price intValue] * _AC*(100 - _selMs.discount)/100)]] andSymbolsC:deepBlackC];
                        }
                        break;
                }
            }
            descV.textAlignment = NSTextAlignmentRight;
            [couponV addSubview:descV];
            [descV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(toIcon.mas_left).offset(-6);
                make.centerY.equalTo(couponV);
            }];

            UIView *third_lV = [[UIView alloc]init ];
            third_lV.backgroundColor = cutOffLineC;
            [footerV addSubview:third_lV];
            [third_lV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.bottom.equalTo(couponV.mas_bottom).offset(-0.5);
                make.width.mas_equalTo(ScreenW - spaceM);
                make.height.mas_equalTo(0.5);
            }];

            //邮费
            UIView *moneyV = [[UIView alloc]init ];
            moneyV.backgroundColor = [UIColor whiteColor];
            [footerV addSubview:moneyV];
            [moneyV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(couponV.mas_bottom).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(44*StScaleH);
            }];

            //需支付的钱
            UILabel *totalFee = [[UILabel alloc] init];
            totalFee.font = [UIFont systemFontOfSize:16];
            totalFee.textColor = styleColor;
            if (_totalM != NULL){totalFee.attributedText =[MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:_totalM] andSymbolsC:styleColor];}
            totalFee.textAlignment = NSTextAlignmentRight;
            [moneyV addSubview:totalFee];
            [totalFee mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-spaceM);
                make.centerY.equalTo(moneyV);
            }];
            //商品总数量
            UILabel *totalAms = [[UILabel alloc] init];
            totalAms.font = [UIFont systemFontOfSize:13];
            totalAms.textColor = deepBlackC;
            totalAms.text = [[@"共" stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)_AC]] stringByAppendingString:@"件商品  小计:"];
            totalAms.textAlignment = NSTextAlignmentRight;
            [moneyV addSubview:totalAms];
            [totalAms mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(totalFee.mas_left).offset(0);
                make.centerY.equalTo(moneyV);
            }];
            UIButton* alipayV= [[UIButton alloc] init];
            alipayV.backgroundColor = [UIColor whiteColor];
            alipayV.tag = 0;
            [alipayV addTarget:self action:@selector(toSelectM:) forControlEvents:UIControlEventTouchUpInside];
            [footerV addSubview:alipayV];
            [alipayV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(moneyV.mas_bottom).offset(10*StScaleH);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(60*StScaleH);
            }];

            UIImageView *alipayIcon  = [[UIImageView alloc] init];
            alipayIcon.image = [UIImage imageNamed:@"icon_zhifu_zhifubao.png"];
            [alipayV addSubview:alipayIcon];
            [alipayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.centerY.equalTo(alipayV);
            }];

            UILabel *alipayLab = [[UILabel alloc] init];
            alipayLab.font = [UIFont systemFontOfSize:16];
            alipayLab.textColor = deepBlackC;
            alipayLab.text = @"支付宝支付";
            alipayLab.textAlignment = NSTextAlignmentLeft;
            [alipayV addSubview:alipayLab];
            [alipayLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(alipayIcon.mas_right).offset(8);
                make.top.equalTo(alipayIcon.mas_top).offset(0);
            }];

            UIImageView *tuiIcon  = [[UIImageView alloc] init];
            tuiIcon.image = [UIImage imageNamed:@"icon_zhifu_tuijian.png"];
            [alipayV addSubview:tuiIcon];
            [tuiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(alipayLab.mas_right).offset(5);
                make.centerY.equalTo(alipayLab);
            }];

            UILabel *alipayIntro = [[UILabel alloc] init];
            alipayIntro.font = [UIFont systemFontOfSize:13];
            alipayIntro.textColor = midBlackC;
            alipayIntro.text = @"数亿客户都在用，安全可托付";
            alipayIntro.textAlignment = NSTextAlignmentLeft;
            [alipayV addSubview:alipayIntro];
            [alipayIntro mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(alipayIcon.mas_right).offset(8);
                make.bottom.equalTo(alipayIcon.mas_bottom).offset(0);
            }];
            //被选中
            _alipayS  = [[UIImageView alloc] init];
            _alipayS.image = [UIImage imageNamed:@"icon_zhifu_tuoyuan.png"];
            _alipayS.hidden = _selectM == 2 ? NO :YES ;
            [alipayV addSubview:_alipayS];
            [_alipayS mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-spaceM);
                make.centerY.equalTo(alipayV);
            }];

            UIView *fourth_lV = [[UIView alloc]init ];
            fourth_lV.backgroundColor = cutOffLineC;
            [footerV addSubview:fourth_lV];
            [fourth_lV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.bottom.equalTo(alipayV.mas_bottom).offset(-0.5);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(0.5);
            }];

            UIButton* weChatV= [[UIButton alloc] init];
            weChatV.backgroundColor = [UIColor whiteColor];
            weChatV.tag = 1;
            [weChatV addTarget:self action:@selector(toSelectM:) forControlEvents:UIControlEventTouchUpInside];
            [footerV addSubview:weChatV];
            [weChatV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.equalTo(alipayV.mas_bottom).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(60*StScaleH);
            }];

            UIImageView *weChatIcon  = [[UIImageView alloc] init];
            weChatIcon.image = [UIImage imageNamed:@"icon_zhifu_weixin.png"];
            [weChatV addSubview:weChatIcon];
            [weChatIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.centerY.equalTo(weChatV);
            }];

            UILabel *weChatLab = [[UILabel alloc] init];
            weChatLab.font = [UIFont systemFontOfSize:16];
            weChatLab.textColor = deepBlackC;
            weChatLab.text = @"微信支付";
            weChatLab.textAlignment = NSTextAlignmentLeft;
            [weChatV addSubview:weChatLab];
            [weChatLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weChatIcon.mas_right).offset(8);
                make.top.equalTo(weChatIcon.mas_top).offset(0);
            }];

            UILabel *weChatIntro = [[UILabel alloc] init];
            weChatIntro.font = [UIFont systemFontOfSize:13];
            weChatIntro.textColor = midBlackC;
            weChatIntro.text = @"亿万客户的选择，更快更安全";
            weChatIntro.textAlignment = NSTextAlignmentLeft;
            [weChatV addSubview:weChatIntro];
            [weChatIntro mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weChatIcon.mas_right).offset(8);
                make.bottom.equalTo(weChatIcon.mas_bottom).offset(0);
            }];
            //被选中
            _weChatS  = [[UIImageView alloc] init];
            _weChatS.image = [UIImage imageNamed:@"icon_zhifu_tuoyuan.png"];
            _weChatS.hidden = _selectM == 1 ? NO :YES ;
            [weChatV addSubview:_weChatS];
            [_weChatS mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-spaceM);
                make.centerY.equalTo(weChatV);
            }];

            return footerV;
        }
        default:
            footerV.backgroundColor = someTableCellC;
            return footerV;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
    case 0:
        return 10*StScaleH;
    default:
        return 360*StScaleH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section  == 0 ){
        if ([_mineAds count]  == 0){
            UITableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:@"cells"];
            UIImageView*iconV  = [[UIImageView alloc] init];
            iconV.image = [UIImage imageNamed:@"dingwei.png"];
            [cells addSubview:iconV];
            [iconV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceM);
                make.centerY.equalTo(cells);
            }];
            UILabel *marketLab = [[UILabel alloc] init];
            marketLab.font = [UIFont systemFontOfSize:16];
            marketLab.textColor = deepBlackC;
            marketLab.text = @"请先摊位信息认证";
            marketLab.textAlignment = NSTextAlignmentLeft;
            [cells addSubview:marketLab];
            MASAttachKeys(marketLab);
            [marketLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(iconV.mas_right).offset(10);
                make.centerY.mas_equalTo(0);
                make.height.mas_equalTo(44*StScaleH);
            }];
            cells.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cells;
        }else{
            MineAds *mineAds = _mineAds[indexPath.section];
            MineAdsTbCells *cells = [tableView dequeueReusableCellWithIdentifier:@"mineAdsTbCells"];
            if (!cells){
                cells = [[MineAdsTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineAdsTbCells"];
            }
            cells.selectionStyle =NO;
            cells.shipName.text = mineAds.addressee;
            cells.telInfo.text = mineAds.tel;
            cells.delInfo.text = [mineAds.province stringByAppendingString:[mineAds.city stringByAppendingString:[mineAds.area stringByAppendingString:mineAds.detail]]];
            [cells.editV addSubview:cells.editIV];
            return cells;
        }
    }else{
        OrderListTbCells *cells = [tableView dequeueReusableCellWithIdentifier:@"orderListTbCells"];
        if (!cells){
            cells = [[OrderListTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderListTbCells"];
        }
        cells.selectionStyle =NO;
        cells.backgroundColor = someTableCellC;
        if (_homeDetailMs != NULL){
            cells.introLab.text = [NSString stringWithFormat:@"%@",_homeDetailMs.title];
            cells.priceLab.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_homeDetailMs.discount_price floatValue]]] andSymbolsC:styleColor];
            [cells.caiIcon sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:_homeDetailMs.small_pic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
        }
        return cells;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section  == 0 ){
        if ([_mineAds count]  == 0){
            //未实名
            [_delegate toRealN];
        }else{
            //去编辑地址
            [_delegate toEditAs:_mineAds[indexPath.section]];
        }
    }
}
//按钮、手势函数写这
- (void)toPlaceO:(UIButton *)sender{
    [_delegate toPlaceO ];
}
- (void)toCoupon:(id)sender{
    [_delegate toCoupon];
}
-(void)toSelectM:(UIButton *)btn{
    switch (btn.tag){
    case 0:
        {
            _alipayS.hidden = NO;
            _weChatS.hidden = YES;
            _selectM = 2;
            break;
        }
    default:
        {
            _alipayS.hidden = YES;
            _weChatS.hidden = NO;
            _selectM = 1;
            break;
        }
    }
}


@end
