//
//  HomeTbCells.h
//  Fishes
//
//  Created by test on 2018/3/22.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferBtn.h"
//主页的Cells
@interface HomeTbCells : UITableViewCell
//商品图片
@property (nonatomic ,strong) UIImageView *product_icon;
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

//立即下单
@property (nonatomic ,strong) TransferBtn *doBtn;

//进度条文字
@property (nonatomic ,strong) UILabel *progress_bar_vals;
//进度条
@property (nonatomic ,strong) UIProgressView *progress_bar;

//倒计时
@property (nonatomic ,strong) UILabel *count_down;

//距开始：：：距结束
@property (nonatomic ,strong) UILabel *start_end;

@end
