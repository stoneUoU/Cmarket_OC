//
//  OrderDetailV.h
//  Fishes
//
//  Created by test on 2018/4/16.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderMs.h"
@protocol OrderDetailVDel
//这里只需要声明方法
- (void)toR;
@end
@interface OrderDetailV : UIView

@property (nonatomic, weak) id<OrderDetailVDel> delegate; //定义一个属性，可以用来进行get set操作
@property UISegmentedControl *segmentedControl;
//用来存数据
@property OrderMs* orderMs;
@end
