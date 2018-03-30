//
//  HomeDetailV.m
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "HomeDetailV.h"

@implementation HomeDetailV
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
    //给tableV注册Cells
    [_tableV registerClass:[UITableViewCell class] forCellReuseIdentifier: @"Cells"];
    //添加下拉刷新头
    _tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDs)];
    // 马上进入刷新状态
    [self addSubview:_tableV];

    // 网络加载 --- 创建带标题的图片轮播器
    _cycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"pic_loading_shouye.png"]];
    _cycleScrollV.imageURLStringsGroup = @[@"http://img2.niutuku.com/desk/1208/1413/ntk-1413-619.jpg",
                                           @"http://img.bizhi.sogou.com/images/2013/07/17/347636.jpg",
                                           @"http://img2.niutuku.com/desk/1208/2031/ntk-2031-2733.jpg",
                                           @"http://dl.bizhi.sogou.com/images/2013/07/17/347434.jpg"];
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
    [headerV addSubview:_cycleScrollV];
    [_cycleScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(headerV);
        make.height.mas_equalTo(230*StScaleH);
    }];

    _product_title = [[UILabel alloc] init];
    _product_title.font = [UIFont systemFontOfSize:13];
    _product_title.numberOfLines = 2;
    _product_title.lineBreakMode = NSLineBreakByTruncatingTail;
    _product_title.text = @"阿里pay丫，想";
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
    _product_small_title.text = @"阿里pay丫，想00000";
    [headerV addSubview:_product_small_title];
    [_product_small_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerV.mas_left).offset(spaceM);
        make.top.equalTo(_product_title.mas_bottom).offset(12*StScaleH);
    }];

    //距开始：：：距结束
    _start_end = [[UILabel alloc] init];
    _start_end.font = [UIFont systemFontOfSize:13];
    _start_end.textColor = deepBlackC;
    [headerV addSubview:_start_end];
    [_start_end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_product_small_title);
        make.right.equalTo(headerV.mas_right).offset(-spaceM);
    }];

    //倒计时
    _count_down = [[UILabel alloc] init];
    _count_down.font = [UIFont systemFontOfSize:12];
    _count_down.textColor = deepBlackC;
    [headerV addSubview:_count_down];
    [_count_down mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_start_end.mas_bottom).offset(15*StScaleH);
        make.right.equalTo(headerV.mas_right).offset(-spaceM);
    }];

    _product_unit = [[UILabel alloc] init];
    _product_unit.font = [UIFont systemFontOfSize:12];
    _product_unit.textColor = [UIColor color_HexStr:@"d73509"];
    _product_unit.text = @"￥";
    [headerV addSubview:_product_unit];
    [_product_unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_product_small_title.mas_bottom).offset(20*StScaleH);
        make.left.equalTo(headerV.mas_left).offset(spaceM);
        make.bottom.equalTo(headerV.mas_bottom).offset(-16*StScaleH);
    }];

    _product_price = [[UILabel alloc] init];
    _product_price.font = [UIFont systemFontOfSize:18];
    _product_price.textColor = [UIColor color_HexStr:@"d73509"];
    _product_price.text = @"20.09";
    [headerV addSubview:_product_price];
    [_product_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_product_unit.mas_right).offset(0);
        make.bottom.equalTo(_product_unit.mas_bottom).offset(0);
    }];

    _product_attr = [[CustomLabel alloc] init];
    _product_attr.font = [UIFont systemFontOfSize:10];
    _product_attr.backgroundColor = [UIColor color_HexStr:@"e16847"];
    _product_attr.textColor = [UIColor whiteColor];
    _product_attr.layer.cornerRadius = 3;
    _product_attr.layer.masksToBounds = true;
    _product_attr.textAlignment = NSTextAlignmentCenter;
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
    _progress_bar.progress = 0.4;
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
    _progress_bar_vals.text = @"已抢购";
    [headerV addSubview:_progress_bar_vals];
    [_progress_bar_vals mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_progress_bar);
        make.right.equalTo(_progress_bar.mas_left).offset(-5);
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
    NSString *str1 = [[@"<!doctype html><html><head><meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\"><style>img{width:" stringByAppendingString:[NSString stringWithFormat:@"%f", ScreenW - 2*spaceM]] stringByAppendingString:@"px}</style></head><body><p><img src='https://pic.cht.znrmny.com/static_file/upload/image/2f3913aa08d311e89eae021e2a1dc1af.png'></p><p><img src='https://pic.cht.znrmny.com/static_file/upload/image/358856f808d311e89eae021e2a1dc1af.png'></p><p><img src='https://pic.cht.znrmny.com/static_file/upload/image/3c8aa08208d311e89eae021e2a1dc1af.png'></p><p><img src='https://pic.cht.znrmny.com/static_file/upload/image/46cdd82008d311e89eae021e2a1dc1af.png'></p></body></html>"];
    //1.将字符串转化为标准HTML字符串
    str1 = [self htmlEntityDecode:str1];
    //2.将HTML字符串转换为attributeString
    NSAttributedString * attributeStr = [self attributedStringWithHTMLString:str1];

    //3.使用label加载html字符串
    html_V.attributedText = attributeStr;

    [footerV addSubview:html_V];
    [html_V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(info_V.mas_bottom).offset(0);
        make.left.equalTo(footerV.mas_left).offset(spaceM);
        make.right.equalTo(footerV.mas_right).offset(-spaceM);
        make.bottom.equalTo(footerV.mas_bottom).offset(0);
    }];

    return footerV;
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

//if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
//    //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
//    StartVC * startV = [[StartVC alloc] init];
//    startV.pass_Vals = @{@"status_code":@"1"};
//    [MethodFunc presentToNaviVC:self destVC:startV];
//}else{
//    STLog(@"已登录,去拼单");
//}
@end

