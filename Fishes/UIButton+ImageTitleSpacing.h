//
//  UIButton+ImageTitleSpacing.h
//  Fishes
//
//  Created by test on 2018/5/2.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, STButtonEdgeInsetsStyle) {
    STButtonEdgeInsetsStyleTop, // image在上，label在下
    STButtonEdgeInsetsStyleLeft, // image在左，label在右
    STButtonEdgeInsetsStyleBottom, // image在下，label在上
    STButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(STButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
