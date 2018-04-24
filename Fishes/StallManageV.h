//
//  StallManageV.h
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol StallManageVDel
//这里只需要声明方法
- (void)tableVClick:(NSInteger)section andRow:(NSInteger)row;
@end
@interface StallManageV : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<StallManageVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UITableView *tableV;

@property (nonatomic,strong)NSMutableArray *stallMs;

@end
