//
//  WillStartVC.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "WillStartVC.h"

@interface WillStartVC ()

@end

@implementation WillStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
- (void)viewDidAppear:(BOOL)animated{
    STLog(@"出现");
}
- (void)setUpUI{
    //给tableView注册Cells
    [self.tableView registerClass:[HomeTbCells class] forCellReuseIdentifier: @"onStartTbs"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = allBgColor;
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTbCells *homeTbCells = [tableView dequeueReusableCellWithIdentifier:@"onStartTbs"];

    if (!homeTbCells){
        homeTbCells = [[HomeTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"onStartTbs"];
    }
    homeTbCells.product_icon.image = [UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"];
    homeTbCells.product_title.text = @"山药 山东 5斤每件";
    homeTbCells.product_small_title.text = @"单品重量不低于1克";
    homeTbCells.product_attr.text = @"5.00元/斤";
    homeTbCells.progress_bar.progress = 0.4;
    homeTbCells.progress_bar_vals.text = @"已购0%";
    [homeTbCells.doBtn setTitle:@"即将开始" forState:UIControlStateNormal];
    homeTbCells.product_price.text = @"0.20";
    homeTbCells.doBtn.backgroundColor = btnDisableC;
    return homeTbCells;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STLog(@"%ld",(long)indexPath.row)
}
@end
