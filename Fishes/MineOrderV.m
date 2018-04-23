//
//  MineOrderV.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineOrderV.h"
#import "OrderListVC.h"
@implementation MineOrderV

- (instancetype)initWithFrame:(CGRect)frame andVC:(UIViewController *)VC andIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:0.8f];
        [self setUpUI:VC andIndex:index];
    }
    return self;
}- (void)setUpUI:(UIViewController *)andVC andIndex:(NSInteger)index{
    NSArray * titles=@[@"全部",@"待付款",@"拼单中",@"待收货",@"已完成"];
    NSArray * ids=@[@0,@1,@2,@3,@4];
    SGPageTitleViewConfigure *configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
    configure.titleColor = deepBlackC;
    configure.titleSelectedColor = styleColor;
    configure.indicatorColor = styleColor;

    /// pageTitleView
    _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, ScreenW, 44) delegate:self titleNames:titles configure:configure];
    [self addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = index;

    NSMutableArray * childVcs=[NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        OrderListVC * vc=[[OrderListVC alloc]init];
        vc.pass_Vals = @{@"ids":ids[i]};
        [childVcs addObject:vc];
    }
    /// pageContentView
    CGFloat contentViewHeight = ScreenH - CGRectGetMaxY(_pageTitleView.frame)-StatusBarAndNavigationBarH;
    _pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_pageTitleView.frame), ScreenW, contentViewHeight) parentVC:andVC childVCs:childVcs];
    _pageContentView.delegatePageContentView = self;
    [self addSubview:_pageContentView];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageContentViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(SGPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

@end
