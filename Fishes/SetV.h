//
//  SetV.h
//  Fishes
//
//  Created by test on 2018/3/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SetVDel
//这里只需要声明方法
- (void)tableVClick:(NSInteger)section andRow:(NSInteger)row;

- (void)toExit;
@end
@interface SetV : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<SetVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIButton *exitBtn;

@property (nonatomic ,strong)UITableView *tableV;

@property (nonatomic,strong)NSMutableArray *setMs;


@end
