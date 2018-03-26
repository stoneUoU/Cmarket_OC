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
- (void)toRefresh;
- (void)toNextVC:(NSString *) section row:(NSString *) row;
@end
@interface MineV : UIView<UITableViewDelegate,UITableViewDataSource>{
    id<MineVDel> _delegate; //这个定义会在后面的解释，它是一个协议，用来实现委托。
}
//自定义导航栏
@property (nonatomic ,strong)UIView *navBarV;
//创建中间标题
@property (nonatomic ,strong)UILabel *midFontL;

@property (nonatomic ,strong)UIView *msgV;

@property (nonatomic ,strong)UIImageView *msgIV;
//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

@property id<MineVDel> delegate; //定义一个属性，可以用来进行get set操作

//渲染列表
@property (nonatomic,retain)NSArray *mineDicts;

//定义数据源
@property (nonatomic,retain)MineMs *mineMs;


//headerV中的 View
@property (nonatomic ,strong)UIView *topV;

@property (nonatomic ,strong)UIImageView *iconV;

@property (nonatomic ,strong)UILabel *user_name;

@property (nonatomic ,strong)UILabel *phone_str;

@end
