//
//  AppUpdate.h
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUpdate : NSObject
+(instancetype) shareIns;
//检查版本
- (void)appVersion;
@end
