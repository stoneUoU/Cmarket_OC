//
//  CircleView.m
//  Fishes
//
//  Created by test on 2018/4/8.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "CircleView.h"

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
#define StartAngle (-90)
#define EndAngle (270)

@interface CircleView ()

@property (nonatomic,strong) CAShapeLayer *backgroundLayer;
@property (nonatomic,strong) CAShapeLayer *trackLayer;
@property (nonatomic,assign) CGFloat arcRadius;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initData];
        [self initSubview];
    }
    return self;
}

#pragma mark - initData
- (void)initData
{
    self.arcRadius = self.frame.size.width / 2.0 > self.frame.size.height / 2.0 ? self.frame.size.height / 2.0 : self.frame.size.width / 2.0;
}

#pragma mark - initSubview
- (void)initSubview
{
    UIBezierPath *backgroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 startAngle:StartAngle endAngle:EndAngle clockwise:YES];
    self.backgroundLayer.path = backgroundPath.CGPath;

    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:self.frame.size.width/2.0 startAngle:DEGREES_TO_RADIANS(StartAngle) endAngle:DEGREES_TO_RADIANS(EndAngle) clockwise:YES];
    self.trackLayer.path = trackPath.CGPath;
    self.trackLayer.strokeEnd = 0.0;

    [self.layer addSublayer:self.backgroundLayer];
    [self.layer addSublayer:self.trackLayer];
}

#pragma mark - Getters And Setters
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationDuration:1.5];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];

    //设置进度
    self.trackLayer.strokeEnd = progress;

    [CATransaction commit];
}

- (CAShapeLayer *)backgroundLayer
{
    if (!_backgroundLayer)
    {
        _backgroundLayer = [CAShapeLayer layer];
        _backgroundLayer.fillColor = [UIColor clearColor].CGColor;
        _backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
        _backgroundLayer.lineCap = kCALineCapRound;
        _backgroundLayer.lineJoin = kCALineJoinRound;
        _backgroundLayer.lineWidth = 5.0;
    }
    return _backgroundLayer;
}

- (CAShapeLayer *)trackLayer
{
    if (!_trackLayer)
    {
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
        _trackLayer.strokeColor = [UIColor redColor].CGColor;
        _trackLayer.lineWidth = 5.0;
    }
    return _trackLayer;
}

@end

