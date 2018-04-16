//
//  OrderDetailVC.h
//  Fishes
//
//  Created by test on 2018/4/16.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailV.h"
@interface OrderDetailVC : BaseToolVC<OrderDetailVDel>

@property(nonatomic,strong)NSDictionary *pass_Vals;

@property (nonatomic,strong) OrderDetailV *orderDetailV;

@end
