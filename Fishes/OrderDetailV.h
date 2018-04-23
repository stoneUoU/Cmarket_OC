//
//  OrderDetailV.h
//  Fishes
//
//  Created by test on 2018/4/16.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMs.h"
@protocol OrderDetailVDel
//这里只需要声明方法(收缩退款详情)
- (void)toToggleV;
@end
@interface OrderDetailV : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<OrderDetailVDel> delegate; //定义一个属性，可以用来进行get set操作
//@property UISegmentedControl *segmentedControl;

//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

@property (nonatomic,strong)UILabel *cancelTime;
 
//用来存数据
@property OrderMs* orderMs;

@property (nonatomic,assign)BOOL ifHideR; //是否隐藏退款详情

@property (nonatomic,assign)BOOL ifCloseD; //toggle退款详情

@end
