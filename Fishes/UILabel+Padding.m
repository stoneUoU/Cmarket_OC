//
//  UILabel+Padding.m
//  Fishes
//
//  Created by test on 2018/3/22.
//  Copyright © 2018年 com.youlu. All rights reserved.
//
//给label增加内边距
#import "UILabel+Padding.h"
@implementation CustomLabel

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
    }
    return self;
}
// 文字区域
- (void)drawTextInRect:(CGRect)rect {
    self.edgeInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}
// UILabel的内容区域
- (CGSize)intrinsicContentSize {
    self.edgeInsets = UIEdgeInsetsMake(self.topEdge, self.leftEdge, self.bottomEdge, self.rightEdge);
    CGSize size = [super intrinsicContentSize];
    size.width  += self.edgeInsets.left + self.edgeInsets.right;
    size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return size;
}
@end
