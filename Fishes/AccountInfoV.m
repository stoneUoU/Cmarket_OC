//
//  AccountInfoV.m
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AccountInfoV.h"

@implementation AccountInfoV
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}

- (id)init
{
    self.accountInfoMs = [NSMutableArray array];

    return [super init];
}

- (void)setUpUI{

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[AccountInfoTbCells class] forCellReuseIdentifier: @"accountInfoTbCells"];
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
        make.height.mas_equalTo(ScreenH - StatusBarAndNavigationBarH - TabbarSafeBottomM);
    }];
}


// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.accountInfoMs count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.accountInfoMs[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 55;
        default:
            return 44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 10*StScaleH;
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
    AccountInfoTbCells *Cell = [tableView dequeueReusableCellWithIdentifier:@"accountInfoTbCells"];
    if (!Cell){
        Cell = [[AccountInfoTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accountInfoTbCells"];
    }
    if (indexPath.section  == 0 &&  indexPath.row == 0){
        Cell.lineV.backgroundColor = [UIColor whiteColor];
        Cell.info_label.text = [self.accountInfoMs[indexPath.section][indexPath.row] objectForKey:@"modelName"];
        // 图片，圆角，边线 -- OK
        [Cell.avatar zy_cornerRadiusAdvance:22*StScaleH rectCornerType:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
        [Cell.avatar sd_setImageWithURL:[self.accountInfoMs[indexPath.section][indexPath.row] objectForKey:@"vals"] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
        [Cell.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(Cell);
            make.right.equalTo(Cell.goV.mas_left).offset(-8);
            make.width.mas_equalTo(44*StScaleH);
            make.height.mas_equalTo(44*StScaleH);
        }];
    }else{
        Cell.info_label.text = [self.accountInfoMs[indexPath.section][indexPath.row] objectForKey:@"modelName"];
        Cell.right_label.text = [self.accountInfoMs[indexPath.section][indexPath.row] objectForKey:@"vals"];
        [Cell.right_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(Cell);
            make.right.equalTo(Cell.goV.mas_left).offset(-8);
        }];
        if (indexPath.section  == 1 &&  indexPath.row == 0){
            Cell.lineV.backgroundColor = [UIColor whiteColor];
        }else if (indexPath.section  == 2 &&  indexPath.row == 2){
            Cell.lineV.backgroundColor = [UIColor whiteColor];
        }else{
            Cell.lineV.backgroundColor = cutOffLineC;
        }
    }
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate toGo:indexPath.section row:indexPath.row];
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
