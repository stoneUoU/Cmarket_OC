//
//  STPlaceholderView.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "STPlaceholderView.h"

@implementation STPlaceholderView

#pragma mark - 构造方法
/**
 构造方法

 @param frame 占位图的frame
 @param type 占位图的类型
 @param delegate 占位图的代理方
 @return 指定frame、类型和代理方的占位图
 */
- (instancetype)initWithFrame:(CGRect)frame type:(STPlaceholderViewType)type delegate:(id)delegate{
    if (self = [super initWithFrame:frame]) {
        // 存值
        _type = type;
        _delegate = delegate;
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];

    //------- 图片在正中间 -------//
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW/ 2 - 50, ScreenH / 2 - 100 - StatusBarAndNavigationBarH, 100, 100)];
    [self addSubview:imageView];

    //------- 说明label在图片下方 -------//
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, self.frame.size.width, 20)];
    [self addSubview:descLabel];
    descLabel.textAlignment = NSTextAlignmentCenter;

    //------- 按钮在说明label下方 -------//
    UIButton *reloadButton = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 - 60, CGRectGetMaxY(descLabel.frame) + 5, 120, 25)];
    [self addSubview:reloadButton];
    [reloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reloadButton.layer.borderColor = [UIColor blackColor].CGColor;
    reloadButton.layer.borderWidth = 1;
    [reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    //------- 根据type创建不同样式的UI -------//
    switch (_type) {
        case STPlaceholderViewTypeNoNetwork: // 没网
        {
            imageView.image = [UIImage imageNamed:@"noNet"];
            descLabel.text = @"没网，不约";
            [reloadButton setTitle:@"点击重试" forState:UIControlStateNormal];
        }
            break;

        case STPlaceholderViewTypeNoData: // 没订单
        {
            imageView.image = [UIImage imageNamed:@"noData"];
            descLabel.text = @"暂无订单";
            [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        }
            break;

        case STPlaceholderViewTypeNoGoods: // 没商品
        {
            imageView.image = [UIImage imageNamed:@"safa"];
            descLabel.text = @"红旗连锁你的好邻居";
            [reloadButton setTitle:@"buybuybuy" forState:UIControlStateNormal];
        }
            break;

        case STPlaceholderViewTypeBeautifulGirl: // 妹纸
        {
            imageView.image = [UIImage imageNamed:@"safa"];
            descLabel.text = @"你会至少在此停留3秒钟";
            [reloadButton setTitle:@"不爱妹纸" forState:UIControlStateNormal];
        }
            break;

        default:
            break;
    }
}

#pragma mark - 重新加载按钮点击
/** 重新加载按钮点击 */
- (void)reloadButtonClicked:(UIButton *)sender{
    // 代理方执行方法
    if ([_delegate respondsToSelector:@selector(placeholderView:reloadButtonDidClick:)]) {
        [_delegate placeholderView:self reloadButtonDidClick:sender];
    }
    // 从父视图上移除
    // [self removeFromSuperview];
}

@end


