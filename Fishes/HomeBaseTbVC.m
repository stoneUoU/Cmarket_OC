//
//  HomeBaseTbVC.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//


#import "HomeBaseTbVC.h"

@implementation HomeBaseTbVC
- (id)init
{
    self.dataArrs = [NSMutableArray array];
    self.pageSize = 15;
    return [super init];
}
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-PageMenuH-StatusBarAndNavigationBarH - TabBarH) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, PageMenuH+StatusBarAndNavigationBarH+TabBarH, 0);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageTitleViewToTop) name:@"headerViewToTop" object:nil];
    //添加一个footerV
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];

}
//查询商品
-(void)startPR{
    if ([_netUseVals isEqualToString: @"Useable"]){
        [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"search" withParaments:@{@"cond":@{@"keywords":@"",@"status":@4},@"sort":@{@"freeze_inventory":@"desc",@"group_product_price":@"",@"update_time":@""},@"limit":@(_pageSize),@"page":@1} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]] isEqualToString:@"0"]){
                for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                    HomeMs *homeMs = [[HomeMs alloc] initMs:feedBacks[@"data"][i][@"group_id"] title:feedBacks[@"data"][i][@"title"] price:feedBacks[@"data"][i][@"price"] discount_price:feedBacks[@"data"][i][@"discount_price"] spic:feedBacks[@"data"][i][@"spic"] status:feedBacks[@"data"][i][@"status"] total_inventory:feedBacks[@"data"][i][@"total_inventory"] freeze_inventory:feedBacks[@"data"][i][@"freeze_inventory"] start_time:feedBacks[@"data"][i][@"start_time"] end_time:feedBacks[@"data"][i][@"end_time"] type:feedBacks[@"data"][i][@"type"] subtitle:feedBacks[@"data"][i][@"subtitle"] attr_value:feedBacks[@"data"][i][@"attr_value"][0][@"attr_value"]];
                    [self.dataArrs addObject:homeMs];
                }
                [self.tableView reloadData];
            }else{
                [HudTips showToast:self text:feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
            }
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)pageTitleViewToTop {
    self.tableView.contentOffset = CGPointZero;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 滚动时发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubTableViewDidScroll" object:scrollView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}
//通知模块代码：
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    _netUseVals =  dict[@"ifnetUse"];
}
@end

