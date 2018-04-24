//
//  MinePlaceV.h
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirmOrderMs.h"
@protocol MinePlaceVDel
//这里只需要声明方法
- (void)tableVClick:(NSInteger)section andRow:(NSInteger)row andDatas:(MineAds *)datas;
//下拉刷新
- (void)toRefresh;
@end
@interface MinePlaceV : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<MinePlaceVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UITableView *tableV;

//用来存数据(地址数据)
@property NSMutableArray* minePls;

@end

