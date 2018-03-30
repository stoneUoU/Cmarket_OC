//
//  CarouselMs.h
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselMs : NSObject
@property (nonatomic, assign)NSString *banner;
@property (nonatomic, assign)NSString *enable;
@property (nonatomic, assign)NSString *ids;
@property (nonatomic, assign)NSString *params;
@property (nonatomic, assign)NSString *sn;
@property (nonatomic, assign)NSString *status;
@property (nonatomic, assign)NSString *title;
@property (nonatomic, assign)NSString *type;
//- (void)importFromObject:(id)obj; //from DB or API
//构造方法
- (id)initMs:(NSString *)banner enable:(NSString *)enable ids:(NSString *)ids params:(NSString *)params sn:(NSString *)sn status:(NSString *)status title:(NSString *)title type:(NSString *)type;
@end
