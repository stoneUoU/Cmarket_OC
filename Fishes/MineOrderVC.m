//
//  MineOrderVC.m
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "MineOrderVC.h"

@implementation MineOrderVC
- (id)init
{
    _mineOrderV = [[MineOrderV alloc] initWithFrame:CGRectZero andVC:self]; //对MyUIView进行初始化
    _mineOrderV.backgroundColor = [UIColor whiteColor];
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUp:@"我的订单" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_mineOrderV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_mineOrderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}
//-(void)demo1
//{
//    _style.isDealFirstItem = YES;//用户是否手动设置滚动到某个item
//    _segmentView.contentView.isCustomScroll = YES;
//
//    [_segmentView.contentView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
