//
//  MineOrderV.h
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPSegmentView.h"
@interface MineOrderV : UIView
@property (nonatomic, strong)ZPSegmentView *segmentView;

@property (nonatomic, strong)ZPSegmentBarStyle *style;
- (instancetype)initWithFrame:(CGRect)frame andVC:(UIViewController *)VC;
@end
