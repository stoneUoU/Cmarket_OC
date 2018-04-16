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

- (instancetype)initWithFrame:(CGRect)frame andVC:(UIViewController *)VC
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:0.8f];
        [self setUpUI:VC];
    }
    return self;
}- (void)setUpUI:(UIViewController *)VC{
    NSArray * titles=@[@"全部",@"待付款",@"拼单中",@"待收货",@"已完成"];
    NSArray * ids=@[@0,@1,@2,@3,@4];
    NSMutableArray * childVcs=[NSMutableArray array];
    for (int i=0; i<titles.count; i++) {
        OrderListVC * vc=[[OrderListVC alloc]init];
        vc.pass_Vals = @{@"ids":ids[i]};
        [childVcs addObject:vc];
    }

    _style=[[ZPSegmentBarStyle alloc] init];
    _style.titleViewBG=[UIColor whiteColor];
    _style.titleFont = [UIFont adjustFont:15];
    _style.normalColor = deepBlackC;
    _style.selecteColor = styleColor;
    _style.bottomLineColor = styleColor;
    _style.isShowBottomLine=YES;
    _style.isShowCover = NO;
    _style.isScrollEnabled = NO;
    _style.isNeedScale=NO;     //标题文字是否缩放,默认为true;

    _segmentView=[[ZPSegmentView alloc]initWithFrame:CGRectMake(0, -StatusBarAndNavigationBarH, ScreenW, ScreenH)];
    [_segmentView setupWithtitles:titles style:_style childVcs:childVcs parentVc:VC];
    //segmentView?.titleView.setCurrentIndex(self.jumpIds)
    //segmentView?.contentView.titleView((segmentView?.titleView)!, targetIndex: self.jumpIds
    //_segmentView.cu
    [self addSubview:_segmentView];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
