//
//  CarouselMs.h
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselMs : NSObject{
    NSString *_banner;
}
@property (nonatomic, copy)NSString *banner;
@property (nonatomic, copy)NSString *enable;
@property (nonatomic, copy)NSString *ids;
@property (nonatomic, copy)NSString *params;
@property (nonatomic, copy)NSString *sn;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *type;
//构造方法
- (id)initMs:(NSString *)banner enable:(NSString *)enable ids:(NSString *)ids params:(NSString *)params sn:(NSString *)sn status:(NSString *)status title:(NSString *)title type:(NSString *)type;
@end


@interface MoveMs : NSObject

@property (nonatomic, assign) BOOL enable;
@property (nonatomic, copy) NSString* banner;
@property (nonatomic, copy) NSString* params;
@property (nonatomic, copy) NSString* ids;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* sn;
@property (nonatomic, copy) NSString* type;

@end
