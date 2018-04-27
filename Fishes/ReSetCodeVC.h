//
//  ReSetCodeVC.h
//  Fishes
//
//  Created by test on 2018/4/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReSetCodeV.h"
@interface ReSetCodeVC : BaseToolVC<ReSetCodeVDel>
@property (nonatomic,strong) ReSetCodeV *reSetCodeV;
@property(nonatomic,assign)BOOL boolSee;
@end
