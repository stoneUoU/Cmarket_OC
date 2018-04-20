//
//  PopPresentV.h
//  Fishes
//
//  Created by test on 2018/4/19.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
#import "HomeDetailMs.h"
@protocol PopPresentVDel
//这里只需要声明方法
- (void)toCloseSelf:(NSInteger)AC;
@end
@interface PopPresentV : UIView<UITableViewDelegate,PPNumberButtonDelegate>

@property (nonatomic, weak) id<PopPresentVDel> delegate; //定义一个属性，可以用来进行get set操作
//确定+个tableview
@property (nonatomic ,strong)UILabel *submitB;

@property (nonatomic ,strong)UITableView *tableV;

@property (nonatomic,strong)PPNumberButton *numBtn;

//数量
@property (nonatomic ,assign)NSInteger AC;

//定义数据源
@property (nonatomic,retain)HomeDetailMs *homeDetailMs;
@end
