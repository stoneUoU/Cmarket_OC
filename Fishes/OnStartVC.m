//
//  OnStartVC.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "OnStartVC.h"
#import "HomeDetailVC.h"

@interface OnStartVC ()
@end

@implementation OnStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
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
- (void)setUpUI{
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
    //给tableView注册Cells
    [self.tableView registerClass:[HomeTbCells class] forCellReuseIdentifier: @"onStartTbs"];

    [self startPR];
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
//    if (self.dataArrs.count >= 10){
//        return self.dataArrs.count + 1;
//    }else{
//        return self.dataArrs.count;
//    }
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if  ([[NSString stringWithFormat:@"%ld",(long)indexPath.row] isEqualToString:[NSString stringWithFormat:@"%lu",(unsigned long)self.dataArrs.count]]) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//        if (!cell){
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        }
//        UIButton *moreBtn = [[UIButton alloc] init];
//        moreBtn.titleLabel.font=[UIFont systemFontOfSize:14];
//        [moreBtn setTitleColor:styleColor  forState:UIControlStateNormal];
//        [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//        [moreBtn addTarget:self action:@selector(btnMore:)forControlEvents:UIControlEventTouchUpInside];
//        [cell addSubview:moreBtn];
//        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(cell);
//            make.right.equalTo(cell.mas_right).offset(2*spaceM);
//        }];
//        return cell;
//
//    }else{
        HomeTbCells *homeTbCells = (HomeTbCells *)[tableView dequeueReusableCellWithIdentifier:@"onStartTbs"];
        HomeMs *homeMs = self.dataArrs[indexPath.row];
        //除去选中时的颜色
        homeTbCells.selectionStyle = UITableViewCellSelectionStyleNone;
        [homeTbCells.product_icon sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:homeMs.spic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
        homeTbCells.product_title.text = [NSString stringWithFormat:@"%@",homeMs.title];
        homeTbCells.product_small_title.text = [NSString stringWithFormat:@"%@",homeMs.subtitle];
        homeTbCells.product_attr.text = [[FormatDs retainPoint:@"0.00" floatV:[homeMs.discount_price floatValue]/[[homeMs.attr_value stringByReplacingOccurrencesOfString:@"kg" withString:@""] floatValue]/2] stringByAppendingString:@"元/斤"];
        //"\(String(format: "%.2f",(Double(datas.discount_price)!/(Double("\(datas.attr_value)".replacingOccurrences(of:"kg", with: ""))! * 2))/100))元/斤"
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
    //}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeDetailVC * homeDetailV = [[HomeDetailVC alloc] init];
    [self.navigationController pushViewController:homeDetailV animated:true];
}
//点击函数
- (void)btnMore:(UIButton *)button{
    STLog(@"查看更多");
}
-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @param year
 *            年份-正整数
 * @param month
 *            月份-正整数
 * @return 返回天数
 */
-(NSInteger)getDayNumberWithYear:(NSInteger )y month:(NSInteger )m{
    int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if (2 == m && 0 == (y % 4) && (0 != (y % 100) || 0 == (y % 400))) {
        days[1] = 29;
    }
    return (days[m - 1]);
}
@end
