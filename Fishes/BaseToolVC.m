//
//  BaseVC.m
//  Fishes
//
//  Created by test on 2018/3/21.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "BaseToolVC.h"

@interface BaseToolVC ()

@end

@implementation BaseToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听是否有网
    _netUseVals = [UICKeyChainStore keyChainStore][@"ifnetUse"];
    _Auths = [UICKeyChainStore keyChainStore][@"authos"];
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setNet:)
                                                 name:@"netChange"
                                               object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
    self.navigationController.navigationBarHidden = true;
}
- (void)setUp:(NSString *) midVal sideVal:(NSString *)sideVal backIvName:(NSString *)backIvName navC:(UIColor *)navC midFontC:(UIColor *)midFontC sideFontC:(UIColor *)sideFontC{

    _statusV = [[UIView alloc] init];
    _statusV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_statusV];

    _navBarV = [[UIView alloc] init];
    _navBarV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navBarV];

    _backBtn = [[UIButton alloc] init];
    //_backBtn.backgroundColor = [UIColor redColor];
    [_backBtn setImage:[UIImage imageNamed:backIvName]forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(toBack)forControlEvents:UIControlEventTouchUpInside];
    [_backBtn adjustToSize:CGSizeMake(2*spaceM,0)];
    [_navBarV addSubview:_backBtn];

    _sideBtn = [[UIButton alloc] init];
    _sideBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    _sideBtn.contentHorizontalAlignment = NSTextAlignmentRight;
    [_sideBtn setTitle:sideVal forState:UIControlStateNormal];
    [_sideBtn setTitleColor:sideFontC  forState:UIControlStateNormal];
    [_sideBtn addTarget:self action:@selector(toSide)forControlEvents:UIControlEventTouchUpInside];
    [_sideBtn adjustToSize:CGSizeMake(2*spaceM,0)];
    [_navBarV addSubview:_sideBtn];

    _midFontL = [[UILabel alloc] init];
    _midFontL.text = midVal;
    _midFontL.textAlignment = NSTextAlignmentCenter;
    _midFontL.textColor = midFontC;
    [_navBarV addSubview:_midFontL];

    _cutOffV = [[UIView alloc] init];
    _cutOffV.backgroundColor = cutOffLineC;
    [_navBarV addSubview:_cutOffV];

    [self setBaseMas:sideVal];
}
- (void) setBaseMas:(NSString *)sideVal{
    // mas_makeConstraints 就是 Masonry 的 autolayout 添加函数，将所需的约束添加到block中就行。
    [_statusV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(StatusBarH);
    }];
    [_navBarV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_statusV.mas_bottom).offset(0);
        make.left.equalTo(_navBarV);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(NavigationBarH);
    }];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_navBarV);
        make.left.equalTo(_navBarV.mas_left).offset(0);
        make.height.mas_equalTo(NavigationBarH);
    }];
    [_sideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(_navBarV);
        make.right.equalTo(_navBarV.mas_right).offset(0);
        make.height.mas_equalTo(NavigationBarH);
    }];
    [_midFontL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_navBarV);
        //根据右边按钮的长度动态改变中间字的宽度
        if ([sideVal length] == 0){
            make.width.mas_equalTo(ScreenW - 2*40);
        }else if([sideVal length] == 2){
            make.width.mas_equalTo(ScreenW - 2*60);
        }else if([sideVal length] == 4){
            make.width.mas_equalTo(ScreenW/2);
        }

    }];
    [_cutOffV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_navBarV.mas_bottom).offset(0);
        make.left.equalTo(_navBarV).offset(0);
        make.right.equalTo(_navBarV).offset(0);
        make.height.mas_equalTo(0.7);
    }];
}
- (void)toBack{
    [MethodFunc popToPrevVC:self];
}
- (void)toSide{
    STLog(@"toSide");
}
-(void)setNet:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    NSLog(@"dict = %@",dict);
    _netUseVals =  dict[@"ifnetUse"];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (BOOL)hidesBottomBarWhenPushed
{
    return (self.navigationController.topViewController == self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate - 占位图
/** 占位图的重新加载按钮点击时回调 */
- (void)placeholderView:(STPlaceholderView *)placeholderView reloadButtonDidClick:(UIButton *)sender{
    switch (placeholderView.type) {
        case STPlaceholderViewTypeNoGoods:       // 没商品
        {
            STLog(@"没商品");
        }
            break;

        case STPlaceholderViewTypeNoData:       // 没有订单
        {
            STLog(@"没有订单");
        }
            break;

        case STPlaceholderViewTypeNoNetwork:     // 没网
        {
            STLog(@"没网");
        }
            break;

        case STPlaceholderViewTypeBeautifulGirl: // 妹纸
        {
            STLog(@"没商品");
        }
            break;

        default:
            break;
    }
}
@end
