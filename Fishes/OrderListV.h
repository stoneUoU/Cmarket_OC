//
//  OrderListV.h
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMs.h"
@protocol OrderListVDel
//这里只需要声明方法
- (void)toRefresh;
- (void)toGo:(NSInteger) section row:(NSInteger) row;
@end
@interface OrderListV : UIView<UITableViewDelegate,UITableViewDataSource>

//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

@property (nonatomic, weak) id<OrderListVDel> delegate; //定义一个属性，可以用来进行get set操作

//用来存数据
@property NSMutableArray* orderMs;
@end
