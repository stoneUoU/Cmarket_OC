//
//  TimeLabel.h
//  Fishes
//
//  Created by test on 2018/4/27.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CountStop)(NSDictionary *, BOOL);
@interface TimeLabel : UILabel
@property (nonatomic, strong) CountStop countStop;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic,assign)NSString *descTimer;
@end

