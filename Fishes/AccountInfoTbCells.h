//
//  AccountInfoTbCells.h
//  Fishes
//
//  Created by test on 2018/4/11.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AccountInfoTbCells : UITableViewCell
//左边的label
@property (nonatomic ,strong) UILabel *info_label;
//头像
@property (nonatomic ,strong) UIImageView *avatar;
//右边的label
@property (nonatomic ,strong) UILabel *right_label;
//右向箭头
@property (nonatomic ,strong) UIImageView *goV;
//分割线
@property (nonatomic ,strong) UIView *lineV;
@end
