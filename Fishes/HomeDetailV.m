//
//  HomeDetailV.m
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HomeDetailV.h"

@implementation HomeDetailV
- (id)init
{
    self.imgStrGroup = [NSMutableArray array];
    // 情景二：采用网络图片实现
    return [super init];
}
- (void)drawRect:(CGRect)rect {
    [self setUpUI];
}
- (void)setUpUI{
    self.backgroundColor =  [UIColor whiteColor];
    _statusV = [[UIView alloc] init];
    _statusV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_statusV];

    _buyBtn = [[UIButton alloc] init];
    _buyBtn.backgroundColor = styleColor;
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buyBtn setTitle:@"去拼单" forState:UIControlStateNormal];
    [_buyBtn sizeToFit];
    _buyBtn.st_acceptEventInterval = 2;
    //6.通过代码为控件注册一个单机事件
    [_buyBtn addTarget:self action:@selector(goBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buyBtn];

    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.estimatedRowHeight = 160;
    _tableV.estimatedSectionHeaderHeight = 100;
    _tableV.estimatedSectionFooterHeight = 100;
    //给tableV注册Cells
    [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier: @"Cells"];
    //添加下拉刷新头
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDs)];
    // 马上进入刷新状态
    [self addSubview:_tableV];

    // 网络加载 --- 创建带标题的图片轮播器
    _cycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"pic_loading_shouye.png"]];
//    _cycleScrollV.imageURLStringsGroup = @[@"http://img2.niutuku.com/desk/1208/1413/ntk-1413-619.jpg",
//                                           @"http://img.bizhi.sogou.com/images/2013/07/17/347636.jpg",
//                                           @"http://img2.niutuku.com/desk/1208/2031/ntk-2031-2733.jpg",
//                                           @"http://dl.bizhi.sogou.com/images/2013/07/17/347434.jpg"];
    _cycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollV.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色

    /*block监听点击方式（解决循环引用）*/
    //__weak typeof(self) weakSelf = self;
    self.cycleScrollV.clickItemOperationBlock = ^(NSInteger index) {
        STLog(@">>>>>  %ld", (long)index);
    };
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_statusV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarH);
    }];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-TabbarSafeBottomM);
        make.left.equalTo(self);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(44*StScaleH);
    }];

    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(_statusV.mas_bottom).offset(0);
        make.bottom.equalTo(_buyBtn.mas_top).offset(0);
        make.width.mas_equalTo(ScreenW);
    }];
}



#pragma  - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc] init];
    headerV.backgroundColor = [UIColor whiteColor];
    _cycleScrollV.imageURLStringsGroup = _homeDetailMs.banner_list;
    [headerV addSubview:_cycleScrollV];
    [_cycleScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(headerV);
        make.height.mas_equalTo(230*StScaleH);
    }];

    _product_title = [[UILabel alloc] init];
    _product_title.font = [UIFont systemFontOfSize:13];
    _product_title.numberOfLines = 2;
    _product_title.lineBreakMode = NSLineBreakByTruncatingTail;
    _product_title.text = _homeDetailMs.title;
    [headerV addSubview:_product_title];
    [_product_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cycleScrollV.mas_bottom).offset(10*StScaleH);
        make.left.equalTo(headerV.mas_left).offset(spaceM);
        make.right.equalTo(headerV.mas_right).offset(-spaceM);
    }];

    _product_small_title = [[CustomLabel alloc] init];
    _product_small_title.font = [UIFont systemFontOfSize:10];
    _product_small_title.backgroundColor = [UIColor color_HexStr:@"f8dbd3"];
    _product_small_title.textColor = [UIColor color_HexStr:@"d73509"];
    _product_small_title.layer.cornerRadius = 3;
    _product_small_title.layer.masksToBounds = true;
    _product_small_title.textAlignment = NSTextAlignmentCenter;
    _product_small_title.leftEdge = 5;
    _product_small_title.rightEdge = 5;
    _product_small_title.text = _homeDetailMs.subtitle;
    [headerV addSubview:_product_small_title];
    [_product_small_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerV.mas_left).offset(spaceM);
        make.top.equalTo(_product_title.mas_bottom).offset(12*StScaleH);
    }];

    _product_price = [[UILabel alloc] init];
    _product_price.font = [UIFont systemFontOfSize:18];
    _product_price.textColor = [UIColor color_HexStr:@"d73509"];
    _product_price.attributedText = [MethodFunc strWithSymbolsS:[@"￥" stringByAppendingString:[FormatDs retainPoint:@"0.00" floatV:[_homeDetailMs.discount_price floatValue]]] andSymbolsC:styleColor];
    [headerV addSubview:_product_price];
    [_product_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_product_small_title.mas_bottom).offset(20*StScaleH);
        make.left.equalTo(headerV.mas_left).offset(spaceM);
        make.bottom.equalTo(headerV.mas_bottom).offset(-16*StScaleH);
    }];

    _product_attr = [[CustomLabel alloc] init];
    _product_attr.font = [UIFont systemFontOfSize:10];
    _product_attr.backgroundColor = [UIColor color_HexStr:@"e16847"];
    _product_attr.textColor = [UIColor whiteColor];
    _product_attr.layer.cornerRadius = 3;
    _product_attr.layer.masksToBounds = true;
    _product_attr.textAlignment = NSTextAlignmentCenter;
    _product_attr.text = _homeDetailMs.desc;
    _product_attr.leftEdge = 5;
    _product_attr.rightEdge = 5;
    [headerV addSubview:_product_attr];
    [_product_attr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_product_price.mas_right).offset(5);
        make.centerY.equalTo(_product_price);
    }];

    _progress_bar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progress_bar.layer.cornerRadius = 3;
    _progress_bar.layer.masksToBounds = true;
    _progress_bar.layer.borderColor = [progress_barC CGColor];
    _progress_bar.layer.borderWidth = 1;
    _progress_bar.progressTintColor = progress_barC;  // 已走过的颜色
    _progress_bar.trackTintColor = [UIColor whiteColor];  // 为走过的颜色
    _progress_bar.progress = [_homeDetailMs.freeze_inventory floatValue]/[_homeDetailMs.total_inventory floatValue];
    [headerV addSubview:_progress_bar];
    [_progress_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_product_price);
        make.right.equalTo(headerV.mas_right).offset(-spaceM);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(8);
    }];

    _progress_bar_vals = [[UILabel alloc] init];
    _progress_bar_vals.font = [UIFont systemFontOfSize:11];
    _progress_bar_vals.textColor = deepBlackC;
    _progress_bar_vals.text = _homeDetailMs.freeze_inventory == NULL ? @"" : [[@"已购" stringByAppendingString:[FormatDs retainPoint:@"0" floatV:[_homeDetailMs.freeze_inventory floatValue]/[_homeDetailMs.total_inventory floatValue]*10000] ] stringByAppendingString:@"%"];
    [headerV addSubview:_progress_bar_vals];
    [_progress_bar_vals mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_progress_bar);
        make.right.equalTo(_progress_bar.mas_left).offset(-5);
    }];

    //倒计时
    _count_down = [[TimeLabel alloc] init];
    _count_down.font = [UIFont systemFontOfSize:12];
    _count_down.textColor = deepBlackC;
    if (_homeDetailMs.status != NULL){
        if ([_homeDetailMs.status isEqual:@"4"]){
            _count_down.descTimer = _homeDetailMs.end_time;
            _count_down.attributedText = [FormatDs returnAttrStr:[self getInTimeWithStr:[NSString stringWithFormat:@"%@",_homeDetailMs.end_time]]];
        }else if([_homeDetailMs.status isEqual:@"2"]){
            _count_down.descTimer = _homeDetailMs.start_time;
            _count_down.attributedText = [FormatDs returnAttrStr:[self getInTimeWithStr:[NSString stringWithFormat:@"%@",_homeDetailMs.end_time]]];
        }else{
            _count_down.descTimer = @"00 : 00 : 00";
            _count_down.attributedText = [FormatDs returnAttrStr:@"00 : 00 : 00"];
        }
    }
    _count_down.countStop = ^(NSDictionary *dict, BOOL b){
        STLog(@"计时停止");
    };
    [headerV addSubview:_count_down];
    [_count_down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_progress_bar.mas_top).offset(-12*StScaleH);
        make.centerX.equalTo(_progress_bar);
    }];

    //距开始：：：距结束
    _start_end = [[UILabel alloc] init];
    _start_end.font = [UIFont systemFontOfSize:13];
    _start_end.textColor = deepBlackC;
    if ([_homeDetailMs.status isEqual:@"4"]){
        _start_end.text =@"距结束";
    }else if([_homeDetailMs.status isEqual:@"2"]){
        _start_end.text =@"距开始";
    }else{
        _start_end.text = @"";
    }
    [headerV addSubview:_start_end];
    [_start_end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_count_down.mas_top).offset(-12*StScaleH);
        make.centerX.equalTo(_count_down);
    }];

    return headerV;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerV = [[UIView alloc] init];

    UIView *h_f_V = [[UIView alloc] init];
    h_f_V.backgroundColor = allBgColor;
    [footerV addSubview:h_f_V];
    [h_f_V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerV.mas_top).offset(0);
        make.left.equalTo(footerV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(10*StScaleH);
    }];

    UIView *info_V = [[UIView alloc] init];
    info_V.backgroundColor = [UIColor whiteColor];
    [footerV addSubview:info_V];
    [info_V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(h_f_V.mas_bottom).offset(0);
        make.left.equalTo(footerV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(32*StScaleH);
    }];

    UILabel *order_info = [[UILabel alloc] init];
    order_info.font = [UIFont systemFontOfSize:13];
    order_info.textColor = deepBlackC;
    order_info.text = @"产品信息";
    [info_V addSubview:order_info];
    [order_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(info_V);
        make.left.equalTo(info_V.mas_left).offset(spaceM);
    }];

    UILabel *html_V = [[UILabel alloc] init];
    html_V.numberOfLines = 0;
    NSString *decodedStr = [[NSString alloc] initWithData: [[NSData alloc] initWithBase64EncodedString:_homeDetailMs.detail == NULL ? @"" : _homeDetailMs.detail options:0] encoding:NSUTF8StringEncoding];
    NSString *htmlStr =[[[[@"<!doctype html><html><head><meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\"><style>img{width:" stringByAppendingString:[NSString stringWithFormat:@"%f", ScreenW - 2*spaceM]] stringByAppendingString:@"px}</style></head><body>"] stringByAppendingString: decodedStr] stringByAppendingString:@"</body></html>"];
    //1.将字符串转化为标准HTML字符串
    htmlStr = [self htmlEntityDecode:htmlStr];
    //2.将HTML字符串转换为attributeString
    NSAttributedString * attrStr = [self attributedStringWithHTMLString:htmlStr];
    //3.使用label加载html字符串
    html_V.attributedText = attrStr;
    [footerV addSubview:html_V];
    [html_V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info_V.mas_bottom).offset(0);
        make.left.equalTo(footerV.mas_left).offset(spaceM);
        make.right.equalTo(footerV.mas_right).offset(-spaceM);
        make.bottom.equalTo(footerV.mas_bottom).offset(0);
    }];
    return footerV;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *nullCell = [tableView dequeueReusableCellWithIdentifier:@"Cells"];
    return nullCell;
}
#pragma 代理方法
- (void)loadDs{
    [_delegate toDo];
}

- (void)goBuy:(id)sender{
    [_delegate toDo];
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

//将 &lt 等类似的字符转化为HTML中的“<”等
- (NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"]; // Do this last so that, e.g. @"&amp;lt;" goes to @"&lt;" not @"<"

    return string;
}

//将HTML字符串转化为NSAttributedString富文本字符串
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };

    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];

    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

- (void)dealloc
{
    [self.count_down.timer invalidate];
    self.count_down.timer = nil;
}
//if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
//    //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
//    StartVC * startV = [[StartVC alloc] init];
//    startV.pass_Vals = @{@"status_code":@"1"};
//    [MethodFunc presentToNaviVC:self destVC:startV];
//}else{
//    STLog(@"已登录,去拼单");
//}
@end

