//
//  StallManageVC.h
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StallManageV.h"
@interface StallManageVC : BaseToolVC<StallManageVDel>
@property (nonatomic,strong) StallManageV *stallManageV;

@property (nonatomic,copy) NSString *stateInfo;
@end
