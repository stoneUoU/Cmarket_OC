//
//  CarouselMs.h
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarouselMs : NSObject {
    NSString *banner;
    NSString *enable;
    NSString *ids;
    NSString *params;
    NSString *sn;
    NSString *status;
    NSString *title;
    NSString *type;
}
@property (nonatomic, strong)NSString *banner;
@property (nonatomic, strong)NSString *enable;
@property (nonatomic, strong)NSString *ids;
@property (nonatomic, strong)NSString *params;
@property (nonatomic, strong)NSString *sn;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *type;
//- (void)importFromObject:(id)obj; //from DB or API
//构造方法
- (id)initMs:(NSString *)banner enable:(NSString *)enable ids:(NSString *)ids params:(NSString *)params sn:(NSString *)sn status:(NSString *)status title:(NSString *)title type:(NSString *)type;
@end
