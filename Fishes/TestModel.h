//
//  TestModel.h
//  Fishes
//
//  Created by test on 2018/4/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface TestModel : BaseModel
@property (nonatomic, copy)NSString *banner;
@property (nonatomic, copy)NSString *enable;
@property (nonatomic, copy)NSString *ids;
@property (nonatomic, copy)NSString *params;
@property (nonatomic, copy)NSString *sn;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *type;
@end


@interface ExpressMs : NSObject
@property (nonatomic, strong) NSString* accept_time;
@property (nonatomic, strong) NSString* accept_station;
@end


