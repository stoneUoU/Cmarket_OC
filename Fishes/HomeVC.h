//
//  HomeViewC.h
//  Fishes
//
//  Created by test on 2017/9/22.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPageMenu.h"
#import "HomeBaseTbV.h"
#import "STAlertV.h"

@interface HomeVC : UIViewController<UITextFieldDelegate,SPPageMenuDelegate,UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,STPlaceholderViewDelegate,STAlertVDel>
@property (nonatomic ,strong)UIView *navBarV;

@property (nonatomic ,strong)UIView *cutOffV;

@property (nonatomic ,strong)UITextField *searchBar;

@property (nonatomic ,strong)UIView *msgV;

@property (nonatomic ,strong)UIImageView *msgIV;

@property (nonatomic ,strong)UIImageView *searchV;

@property(nonatomic, copy) NSString *Auths;
@property(nonatomic, copy) NSString *netUseVals;
//悬浮tableV
@property (nonatomic, strong) HomeBaseTbV *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SPPageMenu *pageMenu;
@property (nonatomic, assign) CGPoint lastPoint;

@property (nonatomic, assign) BOOL headerScrollViewScrolling;
@property (nonatomic, strong) UIScrollView *childVCScrollView;

@property (nonatomic, assign) BOOL other;

//轮播图
@property SDCycleScrollView *cycleScrollV;

@property (nonatomic,strong)NSMutableArray *dataArrs;

@property (nonatomic,strong)NSMutableArray *imgStrGroup;

//定义一个没有数据时的View
@property (nonatomic,strong)STPlaceholderView *placeholderV;

//啦啦啦：我要设置一个flag  判断是不是在正在进行  即将开始
@property (nonatomic,assign)NSInteger tabStatus;
@end
