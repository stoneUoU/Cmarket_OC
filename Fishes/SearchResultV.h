//
//  SearchResultV.h
//  Fishes
//
//  Created by test on 2018/5/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CountDown.h"
#import "HomeMs.h"
#import <UIKit/UIKit.h>
@protocol SearchResultVDel
//这里只需要声明方法
- (void)toCancel;
- (void)toSearch;
//上面的筛选框
- (void)toSort:(UIButton *)sender;
//上拉加载
- (void)toLoadM;
//这里只需要声明方法
- (void)tableVClick:(NSInteger)row andDatas:(HomeMs *)datas;
- (void)toPlaceO:(NSDictionary *)str;
@end
@interface SearchResultV : UIView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    id<SearchResultVDel> _delegate; //这个定义会在后面的解释，它是一个协议，用来实现委托。
}
@property id<SearchResultVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UIView *navBarV;

@property (nonatomic ,strong)UIView *cutOffV;

@property (nonatomic ,strong)UIButton *backBtn;

@property (nonatomic ,strong)UITextField *searchBar;

@property (nonatomic ,strong)UIButton *cancelBtn;

@property (nonatomic ,strong)UIImageView *searchV;

@property (nonatomic ,strong)UIButton *timeBtn;

@property (nonatomic ,strong)UIButton *priceBtn;

@property (nonatomic ,strong)UIButton *progressBtn;

@property (nonatomic ,strong)UIButton *selectBtn;

@property (nonatomic ,strong)UIView *firstV;

@property (nonatomic ,strong)UIView *secondV;

@property (nonatomic ,strong)UIView *thirdV;

//定义一个tableView
@property (nonatomic,strong)UITableView *tableV;

@property (strong, nonatomic)  CountDown *countDown;

@property (nonatomic,retain)NSMutableArray *dataArrs;




@end

