//
//  AccountInfoV.h
//  Fishes
//
//  Created by test on 2018/3/26.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "AccountInfoTbCells.h"

@protocol AccountInfoVDel
//这里只需要声明方法
- (void)toGo:(NSInteger) section row:(NSInteger) row;
@end
@interface AccountInfoV : UIView<UITableViewDelegate,UITableViewDataSource>

//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

@property (nonatomic, weak) id<AccountInfoVDel> delegate; //定义一个属性，可以用来进行get set操作

//@property (nonatomic ,strong)UIButton *testBtn;
@property (nonatomic,strong)NSMutableArray *accountInfoMs;

@end
