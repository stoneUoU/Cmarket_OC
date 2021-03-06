//
//  SetV.m
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SetV.h"
#import "SetTbCells.h"
@implementation SetV
- (id)init
{
    self.setMs = [NSMutableArray array];
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
    [_tableV registerClass:[SetTbCells class] forCellReuseIdentifier: @"setTbCells"];
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
    return [self.setMs count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.setMs[section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*StScaleH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    switch (section) {
        case 0:
            break;
        default:
        {
            UIButton *exitBtn = [[UIButton alloc] init];
            exitBtn.titleLabel.font=[UIFont systemFontOfSize:16];
            exitBtn.backgroundColor = styleColor;
            exitBtn.layer.cornerRadius = 22;
            [exitBtn setTitle:@"注销" forState:UIControlStateNormal];
            [exitBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
            [exitBtn addTarget:self action:@selector(toDo:)forControlEvents:UIControlEventTouchUpInside];
            [footerV addSubview:exitBtn];
            [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(100*StScaleH);
                make.left.mas_equalTo(spaceM);
                make.width.mas_equalTo(ScreenW - (spaceM*2));
                make.height.mas_equalTo(44*StScaleH);
            }];
            break;
        }
    }
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0.00001;
            break;
        default:
            return 180*StScaleH;
            break;
    }
    return 100*StScaleH;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetTbCells *Cell = [tableView dequeueReusableCellWithIdentifier:@"setTbCells"];
    if (!Cell){
        Cell = [[SetTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setTbCells"];
    }
    Cell.infoV.text = [self.setMs[indexPath.section][indexPath.row] objectForKey:@"modelName"];
    Cell.sideV.text = [self.setMs[indexPath.section][indexPath.row] objectForKey:@"vals"];
    if (indexPath.section  == 1 &&  indexPath.row == 0){
        Cell.lineV.backgroundColor = cutOffLineC;
    }else if (indexPath.section  == 1 &&  indexPath.row == 1){
        Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Cell.goV.image = [UIImage imageNamed:@""];
    }
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate tableVClick:indexPath.section andRow:indexPath.row];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toExit];
}

@end
