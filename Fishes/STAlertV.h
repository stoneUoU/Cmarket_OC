//
//  STAlertV.h
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,STPopStyle) {
    STPopStyleFromBottom = 0,
    STPopStyleFromTop,
};

@protocol STAlertVDel;
@interface STAlertV : NSObject
/**
 弹出方式，默认STPopStyleFromBottom
 */
@property (nonatomic,assign) STPopStyle popStyle;
/**
 弹窗背景色,默认0.6灰度
 */
@property (nonatomic,strong) UIColor *popViewBackgroundColor;
/**
 是否需要遮罩，默认YES
 */
@property (nonatomic,assign) BOOL isMasked;
/**
 代理
 */
@property (nonatomic,assign) id <STAlertVDel>delegate;



/**
 初始化
 @param contentView 自定义的view
 @return popview
 */
- (instancetype)initWithContentView:(UIView *)contentView;
/**
 弹窗弹出
 @param animated 是否需要动画
 */
- (void)presentPopupControllerAnimate:(BOOL)animated;
/**
 弹窗收回

 @param animated 是否需要动画
 */
- (void)dismissPopupControllerAnimated:(BOOL)animated;
@end




@protocol STAlertVDel <NSObject>
@optional
/**
 已经弹出

 @param contentView contentView
 */
- (void)STPopContentViewDidPresent:(UIView*)contentView;
/**
 已经退出

 @param contentView contentView
 */
- (void)STPopContentViewDidDismiss:(UIView*)contentView;
@end
