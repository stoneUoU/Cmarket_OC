//
//  CouponV.m
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CouponV.h"
#import "CouponTbCells.h"
@implementation CouponV
- (id)init
{
    _couponMs = [NSMutableArray array];
    _selInxs = [NSMutableArray array];
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    _titleV = [[UILabel alloc] init];
    _titleV.text = @"优惠券";
    _titleV.textColor = deepBlackC;
    _titleV.textAlignment = NSTextAlignmentCenter;

    _titleV.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleV];

    _lineV = [[UIView alloc]init ];
    _lineV.backgroundColor = cutOffLineC;
    [_titleV addSubview:_lineV];

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
    _tableV.dataSource = self;
    //给tableV注册Cells
    [_tableV registerClass:[CouponTbCells class] forCellReuseIdentifier: @"couponTbCells"];
    // 马上进入刷新状态
    _tableV.estimatedRowHeight = 160;  //将tableview的estimatedRowHeight设大一点
    _tableV.showsVerticalScrollIndicator=NO;
    _tableV.backgroundColor = someTableCellC;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.rowHeight = UITableViewAutomaticDimension;
    [self addSubview:_tableV];

    _botV = [[UIView alloc]init ];
    _botV.backgroundColor = styleColor;
    [self addSubview:_botV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_titleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.equalTo(_titleV.mas_bottom).offset(-0.5);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(0.5);
    }];

    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(_titleV.mas_bottom).offset(0);
        make.height.mas_equalTo(325*StScaleH - 48*StScaleH - 44*StScaleH);
        make.width.mas_equalTo(ScreenW);
    }];
    [_submitB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.equalTo(_tableV.mas_bottom).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(48*StScaleH);
    }];

    [_botV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(1*StScaleH);
    }];
}

#pragma  - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_couponMs count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponTbCells *cells = [tableView cellForRowAtIndexPath:indexPath];
    if(!cells){
        cells = [[CouponTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"couponTbCells"];
    }
    cells.selectionStyle = UITableViewCellSelectionStyleNone;
    CouponMs *couponMs = _couponMs[indexPath.row];
    [cells.trueBtn addTarget:self action:@selector(toDo:) forControlEvents:UIControlEventTouchUpInside];
    cells.trueBtn.tag = indexPath.row;
    if (![[NSString stringWithFormat:@"%@",_selInxs[indexPath.row]]  isEqual: @"0"]){
        [cells.trueBtn setBackgroundImage:[UIImage imageNamed:@"couponCircle.png"] forState:UIControlStateNormal];
    }else{
        [cells.trueBtn setBackgroundImage:[UIImage imageNamed:@"couponCir.png"] forState:UIControlStateNormal];
    }
    switch (couponMs.coupon_type) {
    case 1:  //满减券
        {
            cells.AP.attributedText = [MethodFunc strWithSymbolsS:[[@"￥" stringByAppendingString:[NSString stringWithFormat:@"%@",[FormatDs retainPoint:@"0.00" floatV:[couponMs.face_value floatValue]]]] stringByAppendingString:@"元"] andSymbolsC:styleColor];
            [cells.typeBtn setTitle:@"满减券" forState:UIControlStateNormal];
            cells.typeBtn.backgroundColor =[UIColor color_HexStr:@"41cabb"];
            break;
        }
    default:
        {
            cells.AP.text = [[FormatDs retainPoint:@"0.0" floatV:couponMs.discount*10] stringByAppendingString:@"折"];
            [cells.typeBtn setTitle:@"折扣券" forState:UIControlStateNormal];
            cells.typeBtn.backgroundColor =[UIColor color_HexStr:@"e5b66e"];
            break;
        }
    }
    cells.useInfo.text = couponMs.name;
    cells.timeLimit.text = [@"使用期限：" stringByAppendingString:[[couponMs.begin_time substringToIndex:10] stringByAppendingString:[@" - " stringByAppendingString:[couponMs.end_time substringToIndex:10]]]];
    return cells;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_delegate toSelectC: _couponMs[indexPath.row] andRow:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toSelectC: _couponMs[sender.tag] andRow:sender.tag];
}

- (void)toSubmit:(id)sender{
    [_delegate toCloseSelf];
    //[_delegate toSelectC: _couponMs[sender.tag] andRow:sender.tag];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
