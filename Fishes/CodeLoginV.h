//
//  CodeLoginV.h
//  Fishes
//
//  Created by test on 2018/3/23.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CodeLoginVDel
//这里只需要声明方法
- (void)toSubmit;
- (void)toSmsVC;
@end
@interface CodeLoginV : UIView

@property (nonatomic, weak) id<CodeLoginVDel> delegate; //它是一个协议，用来实现委托

@end
