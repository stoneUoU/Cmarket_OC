//
//  CouponTbCells.h
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTbCells : UITableViewCell

@property (nonatomic ,strong) UILabel *AP;  //金额

@property (nonatomic ,strong) UIButton *typeBtn;  //折扣或满减

@property (nonatomic ,strong) UILabel *useInfo;  //使用信息

@property (nonatomic ,strong) UILabel *timeLimit; //时间限制

@property (nonatomic ,strong) UIButton *trueBtn;  //是否选中
@end
