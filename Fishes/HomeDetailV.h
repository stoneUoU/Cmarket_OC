//
//  HomeDetailV.h
//  Fishes
//
//  Created by test on 2018/3/29.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol HomeDetailVDel
//这里只需要声明方法
- (void)toDo;
@end
@interface HomeDetailV : UIView<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>{
    id<HomeDetailVDel> _delegate; //这个定义会在后面的解释，它是一个协议，用来实现委托。
}
@property id<HomeDetailVDel> delegate; //定义一个属性，可以用来进行get set操作

//定义一个状态栏
@property (nonatomic,strong)UIView *statusV;

//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

//定义一个底部View (去拼单)
@property (nonatomic,strong)UIButton *buyBtn;


//轮播图
@property SDCycleScrollView *cycleScrollV;

@property (nonatomic,strong)NSMutableArray *dataArrs;

@property (nonatomic,strong)NSMutableArray *imgStrGroup;


//商品主标题
@property (nonatomic ,strong) UILabel *product_title;
//商品副标题
@property (nonatomic ,strong) CustomLabel *product_small_title;
//商品价钱单位
@property (nonatomic ,strong) UILabel *product_unit;
//商品价钱
@property (nonatomic ,strong) UILabel *product_price;
//商品属性
@property (nonatomic ,strong) CustomLabel *product_attr;
//距开始：：：距结束
@property (nonatomic ,strong) UILabel *start_end;
//倒计时
@property (nonatomic ,strong) UILabel *count_down;
//进度条文字
@property (nonatomic ,strong) UILabel *progress_bar_vals;
//进度条
@property (nonatomic ,strong) UIProgressView *progress_bar;

@end
