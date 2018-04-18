//
//  MineAdsTbCells.h
//  Fishes
//
//  Created by test on 2018/4/17.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineAdsTbCells : UITableViewCell
//收货人名
@property (nonatomic ,strong) UILabel *shipName;
//电话
@property (nonatomic ,strong) UILabel *telInfo;
//详情
@property (nonatomic ,strong) UILabel *delInfo;
//editV
@property (nonatomic ,strong) UIView *editV;
//editIV
@property (nonatomic ,strong) UIImageView *editIV;
@end
