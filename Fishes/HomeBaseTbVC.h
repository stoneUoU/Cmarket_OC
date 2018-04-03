//
//  HomeBaseTbVC.h
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMs.h"
@interface HomeBaseTbVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
//定义数据源
@property (nonatomic,retain)HomeMs *homeMs;
@property (nonatomic,retain)NSMutableArray *dataArrs;

@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;

//产品列表：
@property (nonatomic,assign)double pageSize;

//定义一个没有数据时的View
@property (nonatomic,strong)STPlaceholderView *placeholderV;

//查询商品
- (void)startPR:(NSString *)selIdx  withFreeze:(NSString *)freeze_inventory withUpdate:(NSString *)update_time;
@end
