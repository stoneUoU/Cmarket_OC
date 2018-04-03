//
//  YYCache.m
//  Fishes
//
//  Created by test on 2018/4/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "YYCacheVC.h"
#import "YYCacheTools.h"
#import "CarouselMs.h"
#import "TestModel.h"
#import "LazyTbCells.h"
#import "AppUpdateV.h"
@interface YYCacheVC ()<UITableViewDelegate,UITableViewDataSource,AppUpdateVDelegate>{
    UITableView * _tableV;
}

//可以自定义提醒View，跟着需求走
//@property (nonatomic, strong)AppUpdateV *appUpdateV;

@end
@implementation YYCacheVC
- (id)init
{
    self.dataArrs = [NSMutableArray array];

    self.expressArrs = [NSMutableArray array];
    // 情景二：采用网络图片实现
    return [super init];
}
#pragma mark - Lazy Load
//- (AppUpdateV *)appUpdateV {
//    if (!_appUpdateV) {
//        _appUpdateV = [[AppUpdateV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH ) isForcedUpdate:YES versionStr:@"000000"];
//        _appUpdateV.delegate = (id)self;
//        //有用navigationbar和tabbar的需要加在window上
//        //        [[UIApplication sharedApplication].keyWindow addSubview:_remindUpdateView];
//        [self.view addSubview:_appUpdateV];
//        NSLog(@"初始化");
//    }
//    return _appUpdateV;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    //[self setUpUI];

    //[self startQ];

    //[self startO];
    //[self testYYCache];
    //[self setAlert];
}

//-(void) setAlert{
//    self.appUpdateV.hidden = NO;
//}

-(void) setUpUI{
    //注册cell的名称
    _tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    //给tableV注册Cells
    [_tableV registerClass:[LazyTbCells class] forCellReuseIdentifier: @"cells"];
    [self.view addSubview:_tableV];
    [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view).offset(0);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH - StatusBarAndNavigationBarH - TabBarH);
    }];
}

//-(void) testYYCache{
//    YYCache *yyCache=[YYCache cacheWithName:@"userSecret"];
//    //根据key写入缓存value
//    [yyCache setObject:@"Stone" forKey:@"name"];
//    //判断缓存是否存在
////    BOOL isContains=[yyCache containsObjectForKey:@"name"];
////    STLog(@"containsObject : %@", isContains?@"YES":@"NO");
//    //根据key读取数据
//    STLog(@"value : %@",[yyCache objectForKey:@"name"]);
//    //根据key移除缓存
//    [yyCache removeObjectForKey:@"name"];
//
//
//    //根据key写入缓存value
//    [yyCache setObject:@"I want to know who is Stone ?" forKey:@"msg" withBlock:^{
//        STLog(@"setObject sucess成功");
//    }];
//
//    //根据key读取数据
//    [yyCache objectForKey:@"msg" withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
//        STLog(@"objectForKey : %@",object);
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)startQ{
    [NetWorkManager requestWithType:HttpRequestTypeGet withUrlString:followRoute@"carousel/list" withParaments:@{} Authos:@"" withSuccessBlock:^(NSDictionary *feedBacks) {
        [YYCacheTools setResCache:feedBacks url:@"carousel/list"];
        STLog(@"%@",[[YYCacheTools resCacheForURL:@"carousel/list"] modelToJSONString]);
        for (int i = 0; i < [[YYCacheTools resCacheForURL:@"carousel/list"][@"data"] count]; i++) {
            MoveMs *moveMs = [MoveMs modelWithJSON:[YYCacheTools resCacheForURL:@"carousel/list"][@"data"][i]];
            [self.dataArrs addObject:moveMs];
        }
        MoveMs *moveMs = self.dataArrs[0];
        STLog(@"%@",moveMs.title);
    } withFailureBlock:^(NSError *error) {
        [HudTips hideHUD:self];
        STLog(@"%@",error)
    }];
}
-(void)startO{
    if([YYCacheTools isCacheExist:@"ApiSearch.php"]){
        [self setCache];
    }
    //1.创建AFHTTPSessionManager管理者
    //AFHTTPSessionManager内部是基于NSURLSession实现的
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //注意：responseObject:请求成功返回的响应结果（AFN内部已经把响应体转换为OC对象，通常是字典或数组）
    /**分别设置请求以及相应的序列化器*/
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    //self.LogisticCode = "538681744406"  "887102266424600383"  self.ShipperCode = "ZTO"  "YTO"
    [manager POST:@"http://139.199.169.203/ApiSearch.php" parameters:@{@"OrderCode": @"",@"ShipperCode": @"ZTO",@"LogisticCode": @"538681744406"} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull res) {
        if (![[NSString stringWithFormat:@"%@",res] isEqualToString:[NSString stringWithFormat:@"%@",[YYCacheTools resCacheForURL:@"ApiSearch.php"]]]){
            [YYCacheTools setResCache:res url:@"ApiSearch.php"];
            [self.expressArrs removeAllObjects];
            for (int i = 0; i < [res[@"Traces"] count]; i++) {
                ExpressMs *expressMs = [ExpressMs modelWithJSON:res[@"Traces"][i]];
                [self.expressArrs addObject:expressMs];
            }
            [_tableV reloadData];
            STLog(@"不相等");
        }else{
            STLog(@"相等");
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"失败---%@",error);
    }];
}

-(void)setCache{
    [self.expressArrs removeAllObjects];
    for (int i = 0; i < [[YYCacheTools resCacheForURL:@"ApiSearch.php"][@"Traces"] count]; i++) {
        ExpressMs *expressMs = [ExpressMs modelWithJSON:[YYCacheTools resCacheForURL:@"ApiSearch.php"][@"Traces"][i]];
        [self.expressArrs addObject:expressMs];
    }
    [_tableV reloadData];
}


// MARK: - UITableViewDelegate,UITableViewDataSource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.expressArrs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LazyTbCells *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    if (!cell) {
        cell = [[LazyTbCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
    }
    ExpressMs *expressM = self.expressArrs[indexPath.row];
    cell.product_title.text = [NSString stringWithFormat:@"%@",expressM.accept_station];
    cell.product_time.text = [NSString stringWithFormat:@"%@",expressM.accept_time];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end


