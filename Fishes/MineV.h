//
//  MineV.h
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineTbCells.h"
#import "MineMs.h"
@protocol MineVDel
//这里只需要声明方法
- (void)toMsg;
- (void)toAccount;
- (void)toOrder;
- (void)toRefresh;
- (void)toNextVC:(NSString *) section row:(NSString *) row;

- (void)toWpay;
- (void)toPdan;
- (void)toWrece;
- (void)toOver;
@end
@interface MineV : UIView<UITableViewDelegate,UITableViewDataSource>{
    MineMs *_mineMs;
}
//自定义导航栏
@property (nonatomic ,strong)UIView *navBarV;
//创建中间标题
@property (nonatomic ,strong)UILabel *midFontL;

@property (nonatomic ,strong)UIView *msgV;

@property (nonatomic ,strong)UIImageView *msgIV;
//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

@property (nonatomic, weak) id<MineVDel> delegate; //定义一个属性，可以用来进行get set操作
//定义数据源
@property (nonatomic,retain)MineMs *mineMs;
//定义数据源
@property (nonatomic,retain)MineSonMs *mineSonMs;
@end
