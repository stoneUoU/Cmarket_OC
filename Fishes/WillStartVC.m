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
- (void)setUpUI{
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
    //给tableView注册Cells
    [self.tableView registerClass:[HomeTbCells class] forCellReuseIdentifier: @"onStartTbs"];

    [self startPR:@"2" withFreeze:@"" withUpdate:@"desc" andIfR:1];
}

-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.tableView.visibleCells; //取出屏幕可见cell
    for (HomeTbCells *cell in cells) {
        HomeMs *homeMs = self.dataArrs[cell.tag];
        cell.count_down.text = [self getInTimeWithStr:homeMs.end_time];
        if ([cell.count_down.text isEqualToString:@"活动已经结束！"]) {
            cell.count_down.textColor = [UIColor redColor];
        }else{
            cell.count_down.textColor = [UIColor orangeColor];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrs.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = allBgColor;
    return headerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];
    footerV.backgroundColor = allBgColor ;
    if (self.dataArrs.count >= 10){
        [footerV setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapMore = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toMore:)];
        [footerV addGestureRecognizer:tapMore];
        UIButton *moreBtn = [[UIButton alloc] init];
        moreBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [moreBtn setTitleColor:styleColor  forState:UIControlStateNormal];
        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [footerV addSubview:moreBtn];
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(footerV);
            make.right.equalTo(footerV.mas_right).offset(-spaceM);
        }];
    }
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dataArrs.count >= 10){
        return 44*StScaleH;
    }else{
        return 24*StScaleH;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTbCells *homeTbCells = (HomeTbCells *)[tableView dequeueReusableCellWithIdentifier:@"onStartTbs"];
    homeTbCells.selectionStyle =NO;
    HomeMs *homeMs = self.dataArrs[indexPath.row];
    //除去选中时的颜色
    homeTbCells.selectionStyle = UITableViewCellSelectionStyleNone;
    [homeTbCells.product_icon sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:homeMs.spic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    homeTbCells.product_title.text = [NSString stringWithFormat:@"%@",homeMs.title];
    homeTbCells.product_small_title.text = [NSString stringWithFormat:@"%@",homeMs.subtitle];
    homeTbCells.product_attr.text = [[FormatDs retainPoint:@"0.00" floatV:[homeMs.discount_price floatValue]/[[homeMs.attr_value stringByReplacingOccurrencesOfString:@"kg" withString:@""] floatValue]/2] stringByAppendingString:@"元/斤"];
    homeTbCells.progress_bar.progress =  [homeMs.freeze_inventory floatValue]/[homeMs.total_inventory floatValue];
    homeTbCells.progress_bar_vals.text = [[@"已购" stringByAppendingString:[FormatDs retainPoint:@"0" floatV:[homeMs.freeze_inventory floatValue]/[homeMs.total_inventory floatValue]*10000] ] stringByAppendingString:@"%"];
    [homeTbCells.doBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    homeTbCells.product_price.text =  [FormatDs retainPoint:@"0.00" floatV:[homeMs.discount_price floatValue]];
    homeTbCells.doBtn.backgroundColor = styleColor;
    homeTbCells.start_end.text = @"距结束";
    homeTbCells.count_down.text = [self getInTimeWithStr:[NSString stringWithFormat:@"%@",homeMs.end_time]];
    if ([homeTbCells.count_down.text isEqualToString:@"活动已经结束！"]) {
        homeTbCells.count_down.textColor = [UIColor redColor];
    }else{
        homeTbCells.count_down.textColor = [UIColor orangeColor];
    }
    if ([[FormatDs retainPoint:@"0" floatV:[homeMs.freeze_inventory floatValue]/[homeMs.total_inventory floatValue]*100] isEqualToString:@"1"]) {
        [homeTbCells.doBtn setTitle:@"已拼满" forState:UIControlStateNormal];
        homeTbCells.doBtn.backgroundColor = btnDisableC;
    }
    homeTbCells.tag = indexPath.row;
    return homeTbCells;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STLog(@"%ld",(long)indexPath.row)
}
/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @return 返回天数
 */
//-(NSInteger)getDayNumberWithYear:(NSInteger )y month:(NSInteger )m{
//    int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
//    if (2 == m && 0 == (y % 4) && (0 != (y % 100) || 0 == (y % 400))) {
//        days[1] = 29;
//    }
//    return (days[m - 1]);
//}
//点击函数
- (void)toMore:(id)sender{
    STLog(@"查看更多");
}
-(NSString *)getInTimeWithStr:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];

    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];

    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;

    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

#pragma mark - Delegate - 占位图
/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(STPlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender{
    switch (placeholderView.type) {
        case STPlaceholderViewTypeNoGoods:       // 没商品
        {
            STLog(@"没商品");
        }
            break;

        case STPlaceholderViewTypeNoData:       // 没有订单
        {
            STLog(@"没有订单");
        }
            break;

        case STPlaceholderViewTypeNoNetwork:     // 没网
        {
            STLog(@"没网");
        }
            break;

        case STPlaceholderViewTypeBeautifulGirl: // 妹纸
        {
            STLog(@"没商品");
        }
            break;

        default:
            break;
    }
}
@end
