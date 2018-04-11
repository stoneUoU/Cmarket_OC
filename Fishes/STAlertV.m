//
//  STAlertV.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "STAlertV.h"

@interface STAlertV()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *popBackgroundView;
@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,assign) CGPoint presentCenter;
@property (nonatomic,assign) CGPoint afterCenter;
@end
@implementation STAlertV
#define STPopScreenBounds [UIScreen mainScreen].bounds
#define STPopStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define STPopNavBarHeight 44.0

- (instancetype)initWithContentView:(UIView *)contentView{
    self = [super init];
    if (self) {
        self.contentView = contentView;
        [self completeDefaultPropsSet];
        [self setupUI];
    }
    return self;
}

//完成属性默认值设置
- (void)completeDefaultPropsSet{
    self.isMasked = YES;
    self.popStyle = STPopStyleFromBottom;
    self.popViewBackgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
}
//UI设置
- (void)setupUI{
    [self.popBackgroundView addSubview:self.contentView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewTap)];
    tap.delegate = self;
    [self.popBackgroundView addGestureRecognizer:tap];
}
#pragma mark - popView的弹出和收回
- (void)presentPopupControllerAnimate:(BOOL)animated{
    [self setBackgroundViewFrame];
    [self setContentViewFrame];
    UIView *mainView = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    [mainView addSubview:self.popBackgroundView];
    if (animated) {
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakself.contentView.center = weakself.afterCenter;
            if (weakself.isMasked) {
                weakself.popBackgroundView.backgroundColor = weakself.popViewBackgroundColor;
            }
        }];
    } else {
        self.contentView.center = self.afterCenter;
        if (self.isMasked) {
            self.popBackgroundView.backgroundColor = self.popViewBackgroundColor;
        }
    }
    if ([self.delegate respondsToSelector:@selector(STPopContentViewDidPresent:)]) {
        [self.delegate STPopContentViewDidPresent:self.contentView];
    }
}

- (void)dismissPopupControllerAnimated:(BOOL)animated{
    if (animated) {
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakself.contentView.center = weakself.presentCenter;
            weakself.popBackgroundView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [weakself.popBackgroundView removeFromSuperview];
        }];
    } else {
        self.contentView.center = self.presentCenter;
        self.popBackgroundView.backgroundColor = [UIColor clearColor];
        [self.popBackgroundView removeFromSuperview];
    }
    if ([self.delegate respondsToSelector:@selector(STPopContentViewDidDismiss:)]) {
        [self.delegate STPopContentViewDidDismiss:self.contentView];
    }
}

#pragma mark - 背景手势
- (void)backgroundViewTap{
    [self dismissPopupControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer locationInView:self.popBackgroundView].y>=self.contentView.frame.origin.y && self.popStyle==STPopStyleFromBottom) {
        return NO;
    }
    if ([gestureRecognizer locationInView:self.popBackgroundView].y<=CGRectGetMaxY(self.contentView.frame) && self.popStyle == STPopStyleFromTop) {
        return NO;
    }
    if ([self.delegate respondsToSelector:@selector(STPopContentViewDidDismiss:)]) {
        [self.delegate STPopContentViewDidDismiss:self.contentView];
    }
    return YES;
}
#pragma mark - frame设置
- (void)setBackgroundViewFrame{
    if (self.isMasked) {return;}
    switch (self.popStyle) {
        case STPopStyleFromTop:
            self.popBackgroundView.frame = CGRectMake(self.popBackgroundView.frame.origin.x, self.popBackgroundView.frame.origin.y, self.popBackgroundView.frame.size.width, self.contentView.frame.size.height);
            break;
        case STPopStyleFromBottom:
            self.popBackgroundView.frame = CGRectMake(self.popBackgroundView.frame.origin.x, STPopScreenBounds.size.height-self.contentView.frame.size.height, self.popBackgroundView.frame.size.width, self.contentView.frame.size.height);
            break;
        default:
            break;
    }
}


- (void)setContentViewFrame{
    switch (self.popStyle) {
        case STPopStyleFromTop:
            self.presentCenter = CGPointMake(self.popBackgroundView.frame.size.width/2, -self.contentView.frame.size.height/2);
            self.afterCenter = CGPointMake(self.popBackgroundView.frame.size.width/2, self.contentView.frame.size.height/2);
            break;
        case STPopStyleFromBottom:
            self.presentCenter = CGPointMake(self.popBackgroundView.frame.size.width/2, self.popBackgroundView.frame.size.height+self.contentView.frame.size.height/2);
            self.afterCenter = CGPointMake(self.popBackgroundView.frame.size.width/2, self.popBackgroundView.frame.size.height-self.contentView.frame.size.height/2);
            break;
        default:
            break;
    }
    self.contentView.center = self.presentCenter;
}
#pragma mark - getter和setter
- (UIView *)popBackgroundView{
    if (!_popBackgroundView) {
        _popBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, STPopScreenBounds.size.width, STPopScreenBounds.size.height)];
        _popBackgroundView.layer.masksToBounds = YES;
    }
    return _popBackgroundView;
}

- (void)setPopStyle:(STPopStyle)popStyle{
    _popStyle = popStyle;
    if (popStyle == STPopStyleFromTop) {
        self.popBackgroundView.frame = CGRectMake(0, STPopStatusBarHeight+STPopNavBarHeight, STPopScreenBounds.size.width, STPopScreenBounds.size.height-STPopStatusBarHeight-STPopNavBarHeight);
    }
}
@end
