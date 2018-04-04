//
//  HomeViewC.m
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import "HomeVC.h"
#import "OnStartVC.h"
#import "WillStartVC.h"
#import "CarouselMs.h"
#import "StartVC.h"
#import "HomeDetailVC.h"
#import "SetVC.h"
@implementation HomeVC
- (id)init
{
    self.dataArrs = [NSMutableArray array];
    self.imgStrGroup = [NSMutableArray array];
    // 情景二：采用网络图片实现
    return [super init];
}
- (UIScrollView *)scrollView {

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0,PageMenuH, ScreenW, ScreenH-PageMenuH);
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(ScreenW*2, 0);
        _scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    }
    return _scrollView;
}

- (HomeBaseTbV *)tableView {

    if (!_tableView) {
        _tableView = [[HomeBaseTbV alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
    [self setUpUI];
    [self startR];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}

- (void)setUpUI{
    _navBarV = [[UIView alloc] init];
    _navBarV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navBarV];

    _cutOffV = [[UIView alloc] init];
    _cutOffV.backgroundColor = cutOffLineC;
    [_navBarV addSubview:_cutOffV];

    _msgV = [[UIView alloc] init];
    _msgV.backgroundColor = [UIColor clearColor];//cutOffLineC;
    [_msgV setUserInteractionEnabled:YES];
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toMsg:)];
    [_msgV addGestureRecognizer:touchTap];
    [_navBarV addSubview:_msgV];

    _msgIV = [[UIImageView alloc] init];
    _msgIV.image = [UIImage imageNamed:@"toMsg.png"];
    [_msgV addSubview:_msgIV];


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
    [_searchBar addTarget:self action:@selector(valC:)forControlEvents:UIControlEventEditingDidBegin];
    [_navBarV addSubview:_searchBar];

    _searchV = [[UIImageView alloc] init];
    _searchV.image = [UIImage imageNamed:@"sousuo.png"];
    [_searchBar addSubview:_searchV];

    // 网络加载 --- 创建带标题的图片轮播器
    _cycleScrollV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"pic_loading_shouye.png"]];

    _cycleScrollV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollV.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色

    /*block监听点击方式（解决循环引用）*/    
    __weak typeof(self) weakSelf = self;
    self.cycleScrollV.clickItemOperationBlock = ^(NSInteger index) {
        //点击闭包
        CarouselMs *carouselMs = weakSelf.dataArrs[index];
        STLog(@">>>>>  %@", carouselMs.ids);
    };


    [self.view addSubview:self.tableView];

    // 添加2个子控制器
    [self addChildViewController:[[OnStartVC alloc] init]];
    [self addChildViewController:[[WillStartVC alloc] init]];
    // 先将第一个子控制的view添加到scrollView上去
    [self.scrollView addSubview:self.childViewControllers[0].view];

    // 添加头部视图
    self.tableView.tableHeaderView = _cycleScrollV;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, ScreenW, HeaderViewH);

    // 监听子控制器发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subTableViewDidScroll:) name:@"SubTableViewDidScroll" object:nil];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新
        [self downPullUpdateData];
    }];
    //添加约束
    [self setMas];
}
- (void) setMas{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_navBarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(_navBarV);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarAndNavigationBarH);
    }];
    [_cutOffV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navBarV.mas_bottom).offset(0);
        make.left.equalTo(_navBarV).offset(0);
        make.right.equalTo(_navBarV).offset(0);
        make.height.mas_equalTo(0.7);
    }];

    [_msgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_top).offset(StatusBarH);
        make.right.equalTo(_navBarV.mas_right).offset(0);
        make.height.mas_equalTo(NavigationBarH);
    }];

    [_msgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_msgV);
        make.centerX.equalTo(_msgV);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(21);
        make.left.equalTo(_msgV.mas_left).offset(spaceM);
        make.right.equalTo(_msgV.mas_right).offset(-spaceM);
    }];

    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_top).offset(StatusBarH+10);
        make.left.equalTo(_navBarV).offset(spaceM);
        make.right.equalTo(_msgV.mas_left).offset(0);
        make.height.mas_equalTo(24);
    }];

    [_searchV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_searchBar);
        make.left.equalTo(_searchBar.mas_left).offset(6);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navBarV.mas_bottom).offset(0);
        make.left.equalTo(_navBarV.mas_left).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH + TabBarH);
    }];
}
//网络请求代码：
//发送网络请求：（查询轮播图R）
-(void)startR{
    if ([_netUseVals isEqualToString: @"Useable"]){
        if (_placeholderV != nil){
            [_placeholderV removeFromSuperview];
            _placeholderV = nil;
        }
        [HudTips showHUD:self];
        [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"carousel/list" withParaments:@{} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
            [HudTips hideHUD:self];
            for (int i = 0; i < [feedBacks[@"data"] count]; i++) {
                CarouselMs *carouselMs = [[CarouselMs alloc] initMs:feedBacks[@"data"][i][@"banner"] enable:feedBacks[@"data"][i][@"enable"] ids:feedBacks[@"data"][i][@"id"] params:feedBacks[@"data"][i][@"params"] sn:feedBacks[@"data"][i][@"sn"] status:feedBacks[@"data"][i][@"status"] title:feedBacks[@"data"][i][@"title"] type:feedBacks[@"data"][i][@"type"]];
                [self.imgStrGroup addObject: [picUrl stringByAppendingString:feedBacks[@"data"][i][@"banner"]]];
                [self.dataArrs addObject:carouselMs];
            }
            self.cycleScrollV.imageURLStringsGroup = self.imgStrGroup;
        } withFailureBlock:^(NSError *error) {
            [HudTips hideHUD:self];
            STLog(@"%@",error)
        }];
    }else{
        if (_placeholderV == nil){
            _placeholderV = [[STPlaceholderView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarH, ScreenW, ScreenH - StatusBarAndNavigationBarH ) type:STPlaceholderViewTypeNoNetwork delegate:self];
            [self.view addSubview:_placeholderV];
        }
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
 // 下拉刷新
 - (void)downPullUpdateData {
     // 模拟网络请求，1秒后结束刷新
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.tableView.mj_header endRefreshing];
     });
 }

//按钮、手势函数写这
//- (void)jump:(id)sender{
//    //如果没有导航栏，就进行这种跳转；
//    [self.navigationController pushViewController:[[HomeDetailVC alloc] init] animated:true];
//}
- (void)toMsg:(id)sender{
//    if (![[NSString stringWithFormat:@"%@",[UICKeyChainStore keyChainStore][@"orLogin"]]  isEqual: @"true"]){
//        //MARK:弹出登录视图：在主页消息、主页立即购买、商品详情界面登录:status_code:1
//        StartVC * startV = [[StartVC alloc] init];
//        startV.pass_Vals = @{@"status_code":@"1"};
//        [MethodFunc presentToNaviVC:self destVC:startV];
//    }else{
//        STLog(@"已登录,去消息");
//    }
//    HomeDetailVC * homeDetailV = [[HomeDetailVC alloc] init];
//    homeDetailV.pass_Vals = @{@"group_id":@"20"};
//    [MethodFunc pushToNextVC:self destVC:homeDetailV];
    [MethodFunc pushToNextVC:self destVC:[[SetVC alloc]init] ];
}
//监听textfeild的内容改变
- (void)valC:(id)UITextField{
    [self.searchBar resignFirstResponder];
    STLog(@"去搜索模块");
}
//通知模块代码：
 -(void)setNet:(NSNotification *)notification{
     NSDictionary *dict = notification.userInfo;
     _netUseVals =  dict[@"ifnetUse"];
 }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    // 添加悬浮菜单
    [cell.contentView addSubview:self.pageMenu];
    [cell.contentView addSubview:self.scrollView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScreenH;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.tableView) {
        if (self.childVCScrollView && _childVCScrollView.contentOffset.y > 0) {
            self.tableView.contentOffset = CGPointMake(0, HeaderViewH);
        }
        CGFloat offSetY = scrollView.contentOffset.y;

        if (offSetY < HeaderViewH) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"headerViewToTop" object:nil];
        }
    }
}

- (void)subTableViewDidScroll:(NSNotification *)noti {
    UIScrollView *scrollView = noti.object;
    self.childVCScrollView = scrollView;
    if (self.tableView.contentOffset.y < HeaderViewH) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    } else {
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

#pragma mark - SPPageMenuDelegate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    if (!self.childViewControllers.count) { return;}
    // 如果上一次点击的button下标与当前点击的buton下标之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * toIndex, 0) animated:YES];
    }

    UIViewController *targetViewController = self.childViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;

    targetViewController.view.frame = CGRectMake(ScreenW*toIndex, 0, ScreenW, ScreenH);
    UIScrollView *s = targetViewController.view.subviews[0];
    CGPoint contentOffset = s.contentOffset;
    if (contentOffset.y >= HeaderViewH) {
        contentOffset.y = HeaderViewH;
    }
    s.contentOffset = contentOffset;
    [self.scrollView addSubview:targetViewController.view];
}
- (SPPageMenu *)pageMenu {

    if (!_pageMenu) {
        _pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, ScreenW, PageMenuH) trackerStyle:SPPageMenuTrackerStyleLineAttachment];
        [_pageMenu setItems:@[@"正在进行",@"即将开始"] selectedItemIndex:0];
        _pageMenu.delegate = self;
        _pageMenu.itemTitleFont = [UIFont systemFontOfSize:16];
        _pageMenu.selectedItemTitleColor = styleColor;
        _pageMenu.unSelectedItemTitleColor = deepBlackC;
        _pageMenu.tracker.backgroundColor = styleColor;
        _pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
        _pageMenu.bridgeScrollView = self.scrollView;
    }
    return _pageMenu;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
            [self startR];
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


