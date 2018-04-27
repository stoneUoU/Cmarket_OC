//
//  MineV.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineV.h"


@interface MineV(){
    //渲染列表
    NSArray *_mineDicts;
    //headerV中的 View
    UIView *_topV;

    UIImageView *_iconV;

    UILabel *_user_name;

    UILabel *_phone_str;

    UIView *_orderV;

    UILabel *_orderLab;

    UIImageView *_toIcon;

    UILabel *_seeAllL;

    UIView *_l_cut_off_V;

    //订单操作View
    UIView *_dealV; //assgin
    //待付款
    UIView *_wait_payV;
    UIImageView *_wait_pay_IV;
    //拼单中
    UIView *_pinDan_V;
    UIImageView *_pinDan_IV;
    //待收货
    UIView *_wait_receV;
    UIImageView *_wait_receIV;
    //已完成
    UIView *_over_V;
   UIImageView *_over_IV;
}
@end
@implementation MineV
//@synthesize mineMs = _mineMs;
- (void)drawRect:(CGRect)rect {
    _mineDicts = @[
        @[
            @{@"png":@"wodeyinhangka.png",@"vals":@"我的优惠券"},@{@"png":@"wodetanwei.png",@"vals":@"摊位管理"}
        ],
        @[
            @{@"png":@"shouhuodizhi.png",@"vals":@"收货地址"}
        ],
        @[
            @{@"png":@"lianxikefu.png",@"vals":@"联系客服"},@{@"png":@"shezhi.png",@"vals":@"设置"}
        ],
        @[
            @{@"png":@"aboutUs.png",@"vals":@"关于我们"}
        ]
    ];
    [self setUpUI];
}
- (void)setUpUI{
    _navBarV = [[UIView alloc] init];
    _navBarV.backgroundColor = styleColor;
    [self addSubview:_navBarV];

    _midFontL = [[UILabel alloc] init];
    _midFontL.text = @"我的";
    _midFontL.textAlignment = NSTextAlignmentCenter;
    _midFontL.textColor = [UIColor whiteColor];
    [_navBarV addSubview:_midFontL];

    _msgV = [[UIView alloc] init];
    [_msgV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toMsg:)];
    [_msgV addGestureRecognizer:touchTap];
    [_navBarV addSubview:_msgV];

    _msgIV = [[UIImageView alloc] init];
    _msgIV.image = [UIImage imageNamed:@"msg.png"];
    [_msgV addSubview:_msgIV];

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[MineTbCells class] forCellReuseIdentifier: @"mineTbCells"];
    //添加下拉刷新头
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDs)];

    // 马上进入刷新状态
    [self addSubview:_tableV];

    //添加约束
    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_navBarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarAndNavigationBarH);
    }];

    [_msgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_top).offset(StatusBarH);
        make.right.equalTo(_navBarV.mas_right).offset(-spaceM);
        make.width.mas_equalTo(ScreenW/5);
        make.height.mas_equalTo(NavigationBarH);
    }];

    [_msgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_msgV);
        make.right.equalTo(_msgV);
    }];

    [_midFontL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_msgV);
        make.centerX.equalTo(_navBarV);
    }];


    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH - StatusBarAndNavigationBarH - TabBarH);
    }];
}

// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_mineDicts[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    switch (section) {
        case 0:{
            headerV.backgroundColor = allBgColor;
            _topV = [[UIView alloc] init ];
            _topV.backgroundColor = styleColor;
            [_topV setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toInfo:)];
            [_topV addGestureRecognizer:tapInfo];
            [headerV addSubview:_topV];
            [_topV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headerV.mas_top).offset(0);
                make.left.equalTo(headerV.mas_left).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(110*StScaleH);
            }];

            _iconV = [[UIImageView alloc] init ];
            _iconV.layer.cornerRadius = 36*StScaleH;
            //实现效果
            _iconV.clipsToBounds = true;
            [_iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:_mineMs.avatar == NULL ? @"" : _mineMs.avatar]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
            [_topV addSubview:_iconV];
            [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_topV);
                make.left.equalTo(_topV.mas_left).offset(spaceM);
                make.width.mas_equalTo(72*StScaleH);
                make.height.mas_equalTo(72*StScaleH);
            }];
            _user_name = [[UILabel alloc] init];
            _user_name.font = [UIFont systemFontOfSize:15];
            _user_name.textColor = [UIColor whiteColor];
            _user_name.textAlignment = NSTextAlignmentLeft;
            _user_name.text = _mineMs.nick_name;
            //_user_name.font =  [UIFont fontWithName:@"iconFont" size:20];
            //_user_name.text = @"\U0000e6ae 林磊蕾蕾"; //OC语言：@"U0000e645"   //注意：编码查看点击下载文件夹中的demo_unicode.html查
            [_topV addSubview:_user_name];
            [_user_name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_iconV.mas_top).offset(8*StScaleH);
                make.left.equalTo(_iconV.mas_right).offset(12);
            }];

            UIImageView *phone_icon = [[UIImageView alloc] init];
            phone_icon.image = [UIImage imageNamed:@"dianhua.png"];
            [_topV addSubview:phone_icon];
            [phone_icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_user_name.mas_bottom).offset(4*StScaleH);
                make.left.equalTo(_iconV.mas_right).offset(12);
            }];

            _phone_str  = [[UILabel alloc] init];
            _phone_str.font = [UIFont systemFontOfSize:15];
            _phone_str.textColor = [UIColor whiteColor];
            _phone_str.textAlignment = NSTextAlignmentLeft;
            _phone_str.text = _mineMs.tel;
            [_topV addSubview:_phone_str];
            [_phone_str mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(phone_icon);
                make.left.equalTo(phone_icon.mas_right).offset(0);
            }];

            UIImageView *goIcon = [[UIImageView alloc] init];
            goIcon.image = [UIImage imageNamed:@"AtaverArrow.png"];
            [_topV addSubview:goIcon];
            [goIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_topV);
                make.right.equalTo(_topV.mas_right).offset(-spaceM);
            }];

            _orderV = [[UIView alloc] init ];
            _orderV.backgroundColor = [UIColor whiteColor];
            [_orderV setUserInteractionEnabled:YES];
            UITapGestureRecognizer *tapOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toOrder:)];
            [_orderV addGestureRecognizer:tapOrder];
            [headerV addSubview:_orderV];
            [_orderV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_topV.mas_bottom).offset(0);
                make.left.equalTo(headerV.mas_left).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(44*StScaleH);
            }];

            _orderLab  = [[UILabel alloc] init];
            _orderLab.font = [UIFont systemFontOfSize:16];
            _orderLab.textColor = deepBlackC;
            _orderLab.textAlignment = NSTextAlignmentLeft;
            _orderLab.text = @"我的订单";
            [_orderV addSubview:_orderLab];
            [_orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_orderV);
                make.left.equalTo(_orderV.mas_left).offset(spaceM);
            }];

            _toIcon  = [[UIImageView alloc] init];
            _toIcon.image = [UIImage imageNamed:@"SeeAllArrow.png"];
            [_orderV addSubview:_toIcon];
            [_toIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_orderV);
                make.right.equalTo(_orderV.mas_right).offset(-spaceM);
            }];

            _seeAllL  = [[UILabel alloc] init];
            _seeAllL.font = [UIFont systemFontOfSize:13];
            _seeAllL.textColor = midBlackC;
            _seeAllL.textAlignment = NSTextAlignmentRight;
            _seeAllL.text = @"查看全部";
            [_orderV addSubview:_seeAllL];
            [_seeAllL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_orderV);
                make.right.equalTo(_toIcon.mas_left).offset(-6);
            }];

            _l_cut_off_V = [[UIView alloc] init ];
            _l_cut_off_V.backgroundColor = cutOffLineC;
            [headerV addSubview:_l_cut_off_V];
            [_l_cut_off_V mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_orderV.mas_bottom).offset(0);
                make.left.equalTo(headerV.mas_left).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(0.7);
            }];

            _dealV = [[UIView alloc] init ];
            _dealV.backgroundColor = [UIColor whiteColor];
            [headerV addSubview:_dealV];
            [_dealV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_l_cut_off_V.mas_bottom).offset(0);
                make.left.equalTo(headerV.mas_left).offset(0);
                make.width.mas_equalTo(ScreenW);
                make.height.mas_equalTo(70*StScaleH);
            }];

            _wait_payV = [[UIView alloc] init ];
            [_wait_payV setUserInteractionEnabled:YES];
            UITapGestureRecognizer *wait_payOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toWaitPay:)];
            [_wait_payV addGestureRecognizer:wait_payOrder];
            [_dealV addSubview:_wait_payV];
            [_wait_payV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_dealV.mas_top).offset(0);
                make.left.equalTo(headerV.mas_left).offset(0);
                make.width.mas_equalTo(ScreenW/4);
                make.height.mas_equalTo(70*StScaleH);
            }];

            _wait_pay_IV = [[UIImageView alloc] init ];
            _wait_pay_IV.image = [UIImage imageNamed:@"daifukuan.png"];
            [_wait_payV addSubview:_wait_pay_IV];
            [_wait_pay_IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_wait_payV.mas_top).offset(10*StScaleH);
                make.centerX.equalTo(_wait_payV);
            }];

            UILabel * wait_pay_font = [[UILabel alloc] init];
            wait_pay_font.font = [UIFont systemFontOfSize:13];
            wait_pay_font.textColor = midBlackC;
            wait_pay_font.textAlignment = NSTextAlignmentRight;
            wait_pay_font.text = @"待付款";
            [_wait_payV addSubview:wait_pay_font];
            [wait_pay_font mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_wait_payV);
                make.bottom.equalTo(_wait_payV.mas_bottom).offset(-10*StScaleH);
            }];

            UILabel * wait_pay_brage = [[UILabel alloc] init];
            wait_pay_brage.font = [UIFont systemFontOfSize:13];
            wait_pay_brage.textColor = [UIColor color_HexStr:@"d73509"];
            wait_pay_brage.textAlignment = NSTextAlignmentCenter;
            wait_pay_brage.text = _mineSonMs.no_pay == NULL ? @"" : [NSString stringWithFormat:@"%@",_mineSonMs.no_pay];
            wait_pay_brage.layer.borderColor = [UIColor color_HexStr:@"d73509"].CGColor;
            if ([[NSString stringWithFormat:@"%@",_mineSonMs.no_pay] isEqual: @"0"] || _mineSonMs.no_pay == NULL ){
                wait_pay_brage.hidden = YES;
            }else{
                wait_pay_brage.hidden = NO;
                wait_pay_brage.layer.borderWidth = 1;
                wait_pay_brage.layer.cornerRadius = 10*StScaleH;
            }
            [_wait_payV addSubview:wait_pay_brage];
            [wait_pay_brage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_wait_payV.mas_top).offset(2);
                make.right.equalTo(_wait_payV.mas_right).offset(-10*StScaleH);
                make.width.mas_equalTo(20*StScaleH);
                make.height.mas_equalTo(20*StScaleH);
            }];

            _pinDan_V = [[UIView alloc] init ];
            [_pinDan_V setUserInteractionEnabled:YES];
            UITapGestureRecognizer *pin_danOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toPinDan:)];
            [_pinDan_V addGestureRecognizer:pin_danOrder];
            [_dealV addSubview:_pinDan_V];
            [_pinDan_V mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_dealV.mas_top).offset(0);
                make.left.equalTo(_wait_payV.mas_right).offset(0);
                make.width.mas_equalTo(ScreenW/4);
                make.height.mas_equalTo(70*StScaleH);
            }];

            _pinDan_IV = [[UIImageView alloc] init ];
            _pinDan_IV.image = [UIImage imageNamed:@"pindanzhong.png"];
            [_pinDan_V addSubview:_pinDan_IV];
            [_pinDan_IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_pinDan_V.mas_top).offset(10*StScaleH);
                make.centerX.equalTo(_pinDan_V);
            }];

            UILabel * pinDan_font = [[UILabel alloc] init];
            pinDan_font.font = [UIFont systemFontOfSize:13];
            pinDan_font.textColor = midBlackC;
            pinDan_font.textAlignment = NSTextAlignmentRight;
            pinDan_font.text = @"拼单中";
            [_pinDan_V addSubview:pinDan_font];
            [pinDan_font mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_pinDan_V);
                make.bottom.equalTo(_pinDan_V.mas_bottom).offset(-10*StScaleH);
            }];

            UILabel * pinDan_brage = [[UILabel alloc] init];
            pinDan_brage.font = [UIFont systemFontOfSize:13];
            pinDan_brage.textColor = [UIColor color_HexStr:@"d73509"];
            pinDan_brage.textAlignment = NSTextAlignmentCenter;
            pinDan_brage.text = [NSString stringWithFormat:@"%@",_mineSonMs.has_pay];
            pinDan_brage.layer.borderColor = [UIColor color_HexStr:@"d73509"].CGColor;
            if ([[NSString stringWithFormat:@"%@",_mineSonMs.has_pay] isEqual: @"0"] || _mineSonMs.has_pay == NULL ){
                pinDan_brage.hidden = YES;
            }else{
                pinDan_brage.hidden = NO;
                pinDan_brage.layer.borderWidth = 1;
                pinDan_brage.layer.cornerRadius = 10*StScaleH;
            }
            [_pinDan_V addSubview:pinDan_brage];
            [pinDan_brage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_pinDan_V.mas_top).offset(2);
                make.right.equalTo(_pinDan_V.mas_right).offset(-10*StScaleH);
                make.width.mas_equalTo(20*StScaleH);
                make.height.mas_equalTo(20*StScaleH);
            }];

            _wait_receV = [[UIView alloc] init ];
            [_wait_receV setUserInteractionEnabled:YES];
            UITapGestureRecognizer *wait_receOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toWaitRece:)];
            [_wait_receV addGestureRecognizer:wait_receOrder];
            [_dealV addSubview:_wait_receV];
            [_wait_receV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_dealV.mas_top).offset(0);
                make.left.equalTo(_pinDan_V.mas_right).offset(0);
                make.width.mas_equalTo(ScreenW/4);
                make.height.mas_equalTo(70*StScaleH);
            }];

            _wait_receIV = [[UIImageView alloc] init ];
            _wait_receIV.image = [UIImage imageNamed:@"daishouhuo.png"];
            [_wait_receV addSubview:_wait_receIV];
            [_wait_receIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_wait_receV.mas_top).offset(10*StScaleH);
                make.centerX.equalTo(_wait_receV);
            }];

            UILabel * wait_rece_font = [[UILabel alloc] init];
            wait_rece_font.font = [UIFont systemFontOfSize:13];
            wait_rece_font.textColor = midBlackC;
            wait_rece_font.textAlignment = NSTextAlignmentRight;
            wait_rece_font.text = @"待收货";
            [_wait_receV addSubview:wait_rece_font];
            [wait_rece_font mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_wait_receV);
                make.bottom.equalTo(_wait_receV.mas_bottom).offset(-10*StScaleH);
            }];

            UILabel * wait_rece_brage = [[UILabel alloc] init];
            wait_rece_brage.font = [UIFont systemFontOfSize:13];
            wait_rece_brage.textColor = [UIColor color_HexStr:@"d73509"];
            wait_rece_brage.textAlignment = NSTextAlignmentCenter;
            wait_rece_brage.text = [NSString stringWithFormat:@"%@",_mineSonMs.no_delivery];
            wait_rece_brage.layer.borderColor = [UIColor color_HexStr:@"d73509"].CGColor;
            if ([[NSString stringWithFormat:@"%@",_mineSonMs.no_delivery] isEqual: @"0"] || _mineSonMs.no_delivery == NULL ){
                wait_rece_brage.hidden = YES;
            }else{
                wait_rece_brage.hidden = NO;
                wait_rece_brage.layer.borderWidth = 1;
                wait_rece_brage.layer.cornerRadius = 10*StScaleH;
            }
            [_wait_receV addSubview:wait_rece_brage];
            [wait_rece_brage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_wait_receV.mas_top).offset(2);
                make.right.equalTo(_wait_receV.mas_right).offset(-10*StScaleH);
                make.width.mas_equalTo(20*StScaleH);
                make.height.mas_equalTo(20*StScaleH);
            }];

            _over_V = [[UIView alloc] init ];
            [_over_V setUserInteractionEnabled:YES];
            UITapGestureRecognizer *overOrder = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toOver:)];
            [_over_V addGestureRecognizer:overOrder];
            [_dealV addSubview:_over_V];
            [_over_V mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_dealV.mas_top).offset(0);
                make.left.equalTo(_wait_receV.mas_right).offset(0);
                make.width.mas_equalTo(ScreenW/4);
                make.height.mas_equalTo(70*StScaleH);
            }];

            _over_IV = [[UIImageView alloc] init ];
            _over_IV.image = [UIImage imageNamed:@"yishouhuo.png"];
            [_over_V addSubview:_over_IV];
            [_over_IV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_over_V.mas_top).offset(10*StScaleH);
                make.centerX.equalTo(_over_V);
            }];

            UILabel * over_font = [[UILabel alloc] init];
            over_font.font = [UIFont systemFontOfSize:13];
            over_font.textColor = midBlackC;
            over_font.textAlignment = NSTextAlignmentRight;
            over_font.text = @"已完成";
            [_over_V addSubview:over_font];
            [over_font mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_over_V);
                make.bottom.equalTo(_over_V.mas_bottom).offset(-10*StScaleH);
            }];

//            UILabel * over_brage = [[UILabel alloc] init];
//            over_brage.font = [UIFont systemFontOfSize:13];
//            over_brage.textColor = [UIColor color_HexStr:@"d73509"];
//            over_brage.textAlignment = NSTextAlignmentCenter;
//            over_brage.text = @"4";
//            over_brage.layer.borderColor = [UIColor color_HexStr:@"d73509"].CGColor;
//            over_brage.layer.borderWidth = 1;
//            over_brage.layer.cornerRadius = 10;
//            [_over_V addSubview:over_brage];
//            [over_brage mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_over_V.mas_top).offset(2);
//                make.right.equalTo(_over_V.mas_right).offset(-10*StScaleH);
//                make.width.mas_equalTo(20*StScaleH);
//                make.height.mas_equalTo(20*StScaleH);
//            }];

            return headerV;
            break;
        }
        default:{
            headerV.backgroundColor = [UIColor greenColor];
            return headerV;
            break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 234*StScaleH;
        default:
            return 0.00001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10*StScaleH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTbCells *Cell = [tableView dequeueReusableCellWithIdentifier:@"mineTbCells"];

    if (!Cell){
        Cell = [[MineTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineTbCells"];
    }
    Cell.part_icon.image = [UIImage imageNamed:_mineDicts[indexPath.section][indexPath.row][@"png"]];
    Cell.part_name.text = _mineDicts[indexPath.section][indexPath.row][@"vals"];
    if (indexPath.section  == 0 &&  indexPath.row == 0){
        Cell.lineV.backgroundColor = cutOffLineC;
    }else if (indexPath.section  == 2 &&  indexPath.row == 0){
        Cell.lineV.backgroundColor = cutOffLineC;
    }
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate toNextVC:[NSString stringWithFormat:@"%ld",(long)indexPath.section] row:[NSString stringWithFormat:@"%ld",indexPath.row]];
}


//按钮、手势函数写这
//- (void)jump:(id)sender{
//    //如果没有导航栏，就进行这种跳转；
//    [self.navigationController pushViewController:[[HomeDetailVC alloc] init] animated:true];
//}
- (void)toMsg:(id)sender{
    [self.delegate toMsg];
}
- (void)toInfo:(id)sender{
    [self.delegate toAccount];
}
- (void)toOrder:(id)sender{
    [self.delegate toOrder];
}
- (void)loadDs{
    [self.delegate toRefresh];
}

- (void)toWaitPay:(id)sender{
    [self.delegate toWpay];
}

- (void)toPinDan:(id)sender{
    [self.delegate toPdan];
}
- (void)toWaitRece:(id)sender{
    [self.delegate toWrece];
}
- (void)toOver:(id)sender{
    [self.delegate toOver];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
