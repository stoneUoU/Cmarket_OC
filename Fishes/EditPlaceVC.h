//
//  EditPlaceVC.h
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EditPlaceV.h"
#import "FirmOrderMs.h"
// 定义一个block:  返回值(^Block名)(参数类型)
typedef void(^PlaceEditB)(NSDictionary *, BOOL);

@interface EditPlaceVC : BaseToolVC<EditPlaceVDel>
@property (nonatomic,strong) EditPlaceV *editPlaceV;
@property (nonatomic,strong) MineAds *minePls;
// 声明一个闭包
@property (nonatomic, strong) PlaceEditB placeEditB;
@end
