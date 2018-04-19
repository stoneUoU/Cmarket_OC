//
//  CouponV.h
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
// 优惠券

#import <UIKit/UIKit.h>
#import "FirmOrderMs.h"
@protocol CouponVDel
//这里只需要声明方法
- (void)toSelectC:(CouponMs *)couponMs andRow:(NSInteger)row;

- (void)toCloseSelf;
@end
@interface CouponV : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<CouponVDel> delegate; //定义一个属性，可以用来进行get set操作

@property (nonatomic ,strong)UILabel *submitB;

@property (nonatomic ,strong)UILabel *titleV;

@property (nonatomic ,strong)UIView *lineV;

@property (nonatomic ,strong)UITableView *tableV;

@property (nonatomic ,strong)UIView *botV;
//用来存优惠券信息
@property NSMutableArray* couponMs;

//用来存用户选择了哪个优惠券   选择:1  未选中:0
@property NSMutableArray* selInxs;
@end
