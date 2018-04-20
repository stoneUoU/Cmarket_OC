//
//  PopPresentVC.h
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopPresentV.h"
typedef void(^DictB)(NSDictionary *, BOOL);

@interface PopPresentVC : UIViewController<PopPresentVDel>

@property (nonatomic,strong) PopPresentV *popPresentV;

@property (nonatomic, strong) DictB dictB;

@end

