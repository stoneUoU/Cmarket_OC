//
//  YYCache.h
//  Fishes
//
//  Created by test on 2018/4/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAdAlertView.h"
#import "DYAdModel.h"
@interface YYCacheVC : UIViewController<DYAdAlertDelegate>
@property (nonatomic,strong)NSMutableArray *dataArrs;

@property (nonatomic,retain)NSMutableArray *expressArrs;

@end
