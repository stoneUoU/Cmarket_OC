//
//  MinePlaceV.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MinePlaceV.h"
#import "MineAdsTbCells.h"

@implementation MinePlaceV
- (id)init
{
    _minePls = [NSMutableArray array];
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[MineAdsTbCells class] forCellReuseIdentifier: @"mineAdsTbCells"];
    _tableV.showsVerticalScrollIndicator=NO;
    _tableV.backgroundColor = someTableCellC;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.rowHeight = UITableViewAutomaticDimension;
    _tableV.estimatedRowHeight = 160;
    _tableV.estimatedSectionHeaderHeight = 100;
    _tableV.estimatedSectionFooterHeight = 100;
    //添加下拉刷新头
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDs)];
    // 马上进入刷新状态
    [self addSubview:_tableV];

    //添加约束
    [self setMas];
}
- (void) setMas{
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-TabbarSafeBottomM);
        make.width.mas_equalTo(ScreenW);
    }];
}


// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_minePls count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*StScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10*StScaleH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineAds *minePls = _minePls[indexPath.section];
    MineAdsTbCells *cells = [tableView dequeueReusableCellWithIdentifier:@"mineAdsTbCells"];
    if (!cells){
        cells = [[MineAdsTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mineAdsTbCells"];
    }
    cells.selectionStyle =NO;
    cells.shipName.text = minePls.addressee;
    cells.telInfo.text = minePls.tel;
    cells.delInfo.text = [minePls.province stringByAppendingString:[minePls.city stringByAppendingString:[minePls.area stringByAppendingString:minePls.detail]]];
    [cells.editV addSubview:cells.editIV];
    return cells;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate tableVClick:indexPath.section andRow:indexPath.row andDatas:_minePls[indexPath.section]];
}

- (void)loadDs{
    [_delegate toRefresh];
}

@end
