//
//  MineV.m
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineV.h"

@implementation MineV
- (void)drawRect:(CGRect)rect {
    self.mineDicts = @[
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
    //给tableV注册Cells
    [_tableV registerClass:[MineTbCells class] forCellReuseIdentifier: @"mineTbCells"];
    //添加下拉刷新头
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDs)];
    //添加一个footerV
    _tableV.tableFooterView = [[UIView alloc] init];
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
            headerV.backgroundColor = [UIColor cyanColor];
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
                make.height.mas_equalTo(110);
            }];

            _iconV = [[UIImageView alloc] init ];
            _iconV.layer.cornerRadius = 36;
            //实现效果
            _iconV.clipsToBounds = true;
            [_iconV sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:_mineMs.avatar == NULL ? @"" : _mineMs.avatar]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
            [_topV addSubview:_iconV];
            [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_topV);
                make.left.equalTo(_topV.mas_left).offset(spaceM);
                make.width.mas_equalTo(72);
                make.height.mas_equalTo(72);
            }];
            _user_name = [[UILabel alloc] init];
            _user_name.font = [UIFont systemFontOfSize:15];
            _user_name.textColor = [UIColor whiteColor];
            _user_name.textAlignment = NSTextAlignmentLeft;
            _user_name.text = _mineMs.nick_name;
            [_topV addSubview:_user_name];
            [_user_name mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_iconV.mas_top).offset(8);
                make.left.equalTo(_iconV.mas_right).offset(12);
            }];

            UIImageView *phone_icon = [[UIImageView alloc] init];
            phone_icon.image = [UIImage imageNamed:@"dianhua.png"];
            [_topV addSubview:phone_icon];
            [phone_icon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_user_name.mas_bottom).offset(4);
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
            return 234;
        default:
            return 0.00001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTbCells *Cell = [tableView dequeueReusableCellWithIdentifier:@"mineTbCells"];

    if (!Cell){
        Cell = [[MineTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineTbCells"];
    }
    Cell.part_icon.image = [UIImage imageNamed:_mineDicts[indexPath.section][indexPath.row][@"png"]];
    Cell.part_name.text = _mineDicts[indexPath.section][indexPath.row][@"vals"];
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
    [self.delegate toMsg];
}
- (void)loadDs{
    [self.delegate toRefresh];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
