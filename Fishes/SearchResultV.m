//
//  SearchResultV.m
//  Fishes
//
//  Created by test on 2018/5/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "SearchResultV.h"
#import "UIButton+ImageTitleSpacing.h"
#import "HomeTbCells.h"
@implementation SearchResultV
- (id)init
{
    self.countDown = [[CountDown alloc] init];
    self.dataArrs = [NSMutableArray array];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{
    _navBarV = [[UIView alloc] init];
    _navBarV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_navBarV];

    _cutOffV = [[UIView alloc] init];
    _cutOffV.backgroundColor = cutOffLineC;
    [_navBarV addSubview:_cutOffV];

    _backBtn = [[UIButton alloc] init];
    [_backBtn setImage:[UIImage imageNamed:@"custom_serve_back.png"]forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(toCancel:)forControlEvents:UIControlEventTouchUpInside];
    [_backBtn adjustToSize:CGSizeMake(2*spaceM,0)];
    [_navBarV addSubview:_backBtn];

    _cancelBtn = [STVFactory createBtnWithFrame:CGRectZero title:@"取消" color:styleColor font:[UIFont systemFontOfSize:14] target:self action:@selector(toCancel:)];
    [_cancelBtn adjustToSize:CGSizeMake(2*spaceM,0)];
    [_navBarV addSubview:_cancelBtn];

    _searchBar = [[UITextField alloc] init];
    _searchBar.placeholder = @"搜索";
    _searchBar.font = [UIFont systemFontOfSize:13];
    _searchBar.tintColor = [UIColor whiteColor];
    _searchBar.textAlignment = NSTextAlignmentLeft;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.layer.cornerRadius = 12;
    _searchBar.layer.masksToBounds = true;
    _searchBar.layer.borderWidth = 0.7;
    _searchBar.layer.borderColor = [midBlackC CGColor];
    _searchBar.delegate=self;
    UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,2*spaceM,40)];
    _searchBar.leftViewMode = UITextFieldViewModeAlways;//设置左边距显示的时机，这个表示一直显示
    _searchBar.leftView = leftview;
    [_searchBar addTarget:self action:@selector(valSearch:)forControlEvents:UIControlEventEditingDidBegin];
    [_navBarV addSubview:_searchBar];

    _searchV = [[UIImageView alloc] init];
    _searchV.image = [UIImage imageNamed:@"sousuo.png"];
    [_searchBar addSubview:_searchV];

    _timeBtn = [STVFactory createBtnWithFrame:CGRectZero title:@"时间" color:deepBlackC font:[UIFont systemFontOfSize:16] target:self action:@selector(toDo:)];
    _timeBtn.tag = 0;
    [_timeBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
    [_timeBtn layoutButtonWithEdgeInsetsStyle:STButtonEdgeInsetsStyleRight imageTitleSpace:8];
    [self addSubview:_timeBtn];

    _firstV = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [self addSubview:_firstV];

    _priceBtn = [STVFactory createBtnWithFrame:CGRectZero title:@"价格" color:deepBlackC font:[UIFont systemFontOfSize:16] target:self action:@selector(toDo:)];
    _priceBtn.tag = 1;
    [_priceBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
    [_priceBtn layoutButtonWithEdgeInsetsStyle:STButtonEdgeInsetsStyleRight imageTitleSpace:8];
    [self addSubview:_priceBtn];

    _secondV = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [self addSubview:_secondV];

    _progressBtn = [STVFactory createBtnWithFrame:CGRectZero title:@"进度" color:deepBlackC font:[UIFont systemFontOfSize:16] target:self action:@selector(toDo:)];
    _progressBtn.tag = 2;
    [_progressBtn setImage:[UIImage imageNamed:@"defaultArrow.png"] forState:UIControlStateNormal];
    [_progressBtn layoutButtonWithEdgeInsetsStyle:STButtonEdgeInsetsStyleRight imageTitleSpace:8];
    [self addSubview:_progressBtn];

    _thirdV = [STVFactory createVWithFrame:CGRectZero color:cutOffLineC];
    [self addSubview:_thirdV];

    _selectBtn = [STVFactory createBtnWithFrame:CGRectZero title:@"筛选" color:deepBlackC font:[UIFont systemFontOfSize:16] target:self action:@selector(toDo:)];
    _selectBtn.tag = 3;
    [_selectBtn setImage:[UIImage imageNamed:@"unClickSelect.png"] forState:UIControlStateNormal];
    [_selectBtn layoutButtonWithEdgeInsetsStyle:STButtonEdgeInsetsStyleRight imageTitleSpace:8];
    [self addSubview:_selectBtn];

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //给tableV注册Cells
    [_tableV registerClass:[HomeTbCells class] forCellReuseIdentifier: @"homeTbCells"];
    //添加上拉加载尾
    _tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDs)];
    // 马上进入刷新状态
    [self addSubview:_tableV];

    //添加约束
    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_navBarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarAndNavigationBarH);
    }];
    [_cutOffV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navBarV.mas_bottom).offset(0.5);
        make.left.equalTo(_navBarV).offset(0);
        make.right.equalTo(_navBarV).offset(0);
        make.height.mas_equalTo(0.5);
    }];

    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(StatusBarH);
        make.left.equalTo(_navBarV.mas_left).offset(0);
        make.height.mas_equalTo(NavigationBarH);
    }];

    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_top).offset(StatusBarH);
        make.right.equalTo(_navBarV.mas_right).offset(0);
        make.height.mas_equalTo(NavigationBarH);
    }];

    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_top).offset(StatusBarH+10);
        make.left.equalTo(_backBtn.mas_right).offset(0);
        make.right.equalTo(_cancelBtn.mas_left).offset(0);
        make.height.mas_equalTo(24);
    }];

    [_searchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_searchBar);
        make.left.equalTo(_searchBar.mas_left).offset(6);
    }];

    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self);
        make.width.mas_equalTo(ScreenW/4);
        make.height.mas_equalTo(44);
    }];
    [_firstV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_timeBtn);
        make.right.equalTo(_timeBtn.mas_right).offset(-0.5);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(24);
    }];
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(StatusBarAndNavigationBarH);
        make.left.mas_equalTo(_firstV);
        make.width.mas_equalTo(ScreenW/4);
        make.height.mas_equalTo(44);
    }];
    [_secondV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_priceBtn);
        make.right.equalTo(_priceBtn.mas_right).offset(-0.5);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(24);
    }];
    [_progressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(StatusBarAndNavigationBarH);
        make.left.mas_equalTo(_secondV);
        make.width.mas_equalTo(ScreenW/4);
        make.height.mas_equalTo(44);
    }];
    [_thirdV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_progressBtn);
        make.right.equalTo(_progressBtn.mas_right).offset(-0.5);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(24);
    }];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(StatusBarAndNavigationBarH);
        make.left.mas_equalTo(_thirdV);
        make.width.mas_equalTo(ScreenW/4);
        make.height.mas_equalTo(44);
    }];

    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeBtn.mas_bottom).offset(0);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(ScreenW);
        make.bottom.mas_equalTo(-TabbarSafeBottomM);
    }];
}

-(void)updateTimeInVisibleCells{
    NSArray  *cells = _tableV.visibleCells; //取出屏幕可见cell
    for (HomeTbCells *cell in cells) {
        HomeMs *homeMs = self.dataArrs[cell.tag];
        if ([cell.count_down.text isEqualToString:@"00 : 00 : 00"]) {
            cell.count_down.attributedText = [FormatDs returnAttrStr:@"00 : 00 : 00"];
        }else{
            cell.count_down.text = [self getInTimeWithStr:homeMs.end_time];
            cell.count_down.attributedText = [FormatDs returnAttrStr:cell.count_down.text];
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrs.count;
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
    return footerV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10*StScaleH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTbCells *homeTbCells = (HomeTbCells *)[tableView dequeueReusableCellWithIdentifier:@"homeTbCells"];
    homeTbCells.selectionStyle =NO;
    HomeMs *homeMs = self.dataArrs[indexPath.row];
    //除去选中时的颜色
    homeTbCells.selectionStyle = UITableViewCellSelectionStyleNone;
    [homeTbCells.product_icon sd_setImageWithURL:[NSURL URLWithString:[picUrl stringByAppendingString:homeMs.spic]] placeholderImage:[UIImage imageNamed:@"pic_loading_shangpingxiangqing.png"]];
    homeTbCells.product_title.text = [NSString stringWithFormat:@"%@",homeMs.title];
    homeTbCells.product_small_title.text = [NSString stringWithFormat:@"%@",homeMs.subtitle];
    homeTbCells.product_attr.text = homeMs.desc;
    if([homeMs.desc isEqual:@""]){
        homeTbCells.product_attr.hidden = YES;
    }
    homeTbCells.progress_bar.progress =  [homeMs.freeze_inventory floatValue]/[homeMs.total_inventory floatValue];
    homeTbCells.progress_bar_vals.text = [[@"已购" stringByAppendingString:[FormatDs retainPoint:@"0" floatV:[homeMs.freeze_inventory floatValue]/[homeMs.total_inventory floatValue]*10000] ] stringByAppendingString:@"%"];
    homeTbCells.doBtn.transferDs = @{@"datas":homeMs.group_id};
    [homeTbCells.doBtn setTitle:@"立即下单" forState:UIControlStateNormal];
    [homeTbCells.doBtn addTarget:self action:@selector(toPlaceO:) forControlEvents:UIControlEventTouchUpInside];
    homeTbCells.doBtn.backgroundColor = styleColor;
    homeTbCells.product_price.text =  [FormatDs retainPoint:@"0.00" floatV:[homeMs.discount_price floatValue]];

    if ([homeMs.total_inventory isEqual: homeMs.freeze_inventory]) {
        [homeTbCells.doBtn setTitle:@"已拼满" forState:UIControlStateNormal];
        homeTbCells.doBtn.backgroundColor = btnDisableC;
        homeTbCells.count_down.attributedText = [FormatDs returnAttrStr:@"00 : 00 : 00"];
    }else{
        homeTbCells.count_down.attributedText = [FormatDs returnAttrStr:[self getInTimeWithStr:[NSString stringWithFormat:@"%@",homeMs.end_time]]];
    }
    if ([[NSString stringWithFormat:@"%@",homeMs.status]  isEqual: @"2"]) {
        homeTbCells.doBtn.userInteractionEnabled = NO;
        homeTbCells.doBtn.backgroundColor = btnDisableC;
        homeTbCells.start_end.text = @"距开始";
    }else{
        homeTbCells.start_end.text = @"距结束";
    }
    homeTbCells.tag = indexPath.row;
    return homeTbCells;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [_delegate tableVClick:indexPath.row andDatas:self.dataArrs[indexPath.row]];
//}
-(void)toPlaceO:(TransferBtn *)btn{
    [_delegate toPlaceO:btn.transferDs];
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
    if(days<10)
        dayStr = [NSString stringWithFormat:@"0%d",days];
    else
        dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    if(hours<10)
        hoursStr = [NSString stringWithFormat:@"0%d",hours];
    else
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
        return @"00 : 00 : 00";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@ : %@ : %@ : %@", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@ : %@ : %@",hoursStr , minutesStr,secondsStr];
}
//按钮、手势函数写这
- (void)toDo:(UIButton *)sender{
    [_delegate toSort:(UIButton *)sender];
}
- (void)toCancel:(UIButton *)sender{
    [_delegate toCancel];
}
- (void)valSearch:(UITapGestureRecognizer *)sender{
    [_delegate toSearch];
}
- (void)loadDs{
    [_delegate toLoadM];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
