//
//  SearchResultVC.h
//  Fishes
//
//  Created by test on 2018/5/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultV.h"
#import "STDropMenu.h"
@interface SearchResultVC : UIViewController<UIGestureRecognizerDelegate,SearchResultVDel,STDropMenuDelegate>
@property (nonatomic,strong) SearchResultV *searchResultV;
@property(nonatomic, copy) NSString *netUseVals;
@property(nonatomic, copy) NSString *Auths;
@property (nonatomic,assign)double pageInt;
@property (nonatomic,assign)double pageSize;
@property (nonatomic,assign)double totalMount;

//定义一个没有数据时的View
@property (nonatomic,strong)STPlaceholderView *placeholderV;

@property (nonatomic,strong)STDropMenu *stDropMenu;
//在此处先给6个值：
@property(nonatomic, assign) BOOL timeSign;
//时间升序或降序
@property(nonatomic, copy) NSString *timeStr;

@property(nonatomic, assign) BOOL priceSign;
//价格升序或降序
@property(nonatomic, copy) NSString *priceStr;

@property(nonatomic, assign) BOOL progressSign;
//进度升序或降序
@property(nonatomic, copy) NSString *progressStr;
//状态
@property(nonatomic, copy) NSString *statusStr;
//筛选Sign
@property(nonatomic, assign) BOOL selSign;
//关键词
@property(nonatomic, copy) NSString *keyStr;
//改变字体颜色的
@property (nonatomic, copy) NSMutableArray *selArr;

@property(nonatomic,strong)NSDictionary *pass_Vals;
@end

