//
//  AppUpdateV.h
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppUpdateVDelegate<NSObject>

- (void)toAppStore;
- (void)toCancel;

@end

@interface AppUpdateV : UIView

@property (weak, nonatomic) id<AppUpdateVDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame isForcedUpdate:(BOOL)forcedUpdate versionStr:(NSString *)versionStr;

@end
