//
//  UILabel+Deal.m
//  Fishes
//
//  Created by test on 2018/4/18.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "UILabel+Deal.h"

@implementation DealLabel
//设置颜色
- (void)drawRect:(CGRect)rect{
    // 调用super的drawRect:方法,会按照父类绘制label的文字
    [super drawRect:rect];
    // 取文字的颜色作为删除线的颜色
    [self.textColor set];
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    // 绘制(0.35是label的中间位置,可以自己调整)
    UIRectFill(CGRectMake(0, h * 0.35, w, 1));
}
@end
