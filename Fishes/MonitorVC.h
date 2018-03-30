//
//  MonitorVC.h
//  Fishes
//
//  Created by test on 2018/3/28.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonitorV.h"
#import "WebSocketNetwork.h"
@interface MonitorVC : UIViewController<NSURLSessionDataDelegate,MonitorVDel>

@property (nonatomic, strong)MonitorV *monitorV;
@property (nonatomic, strong)NSMutableData *data;
@property (nonatomic ,strong)UIImage *img;

@property (nonatomic ,strong)WebSocketNetwork *socketNet;
@end
