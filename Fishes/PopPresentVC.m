//
//  PopPresentVC.m
//  Fishes
//
//  Created by test on 2018/4/4.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "PopPresentVC.h"

@implementation PopPresentVC
- (id)init
{
    _popPresentV= [[PopPresentV alloc] init]; //对MyUIView进行初始化
    _popPresentV.backgroundColor = [UIColor whiteColor];
    _popPresentV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    self.view.layer.shadowOpacity = 0.8;
    self.view.layer.shadowRadius = 5;
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpUI];
}
- (void)setUpUI{
    [self.view addSubview:_popPresentV];
    //添加约束
    [self setMas];
}


- (void) setMas{
    [_popPresentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.height.mas_equalTo(self.view);
    }];
}
-(void) toCloseSelf:(NSInteger)AC{
    [self dismissViewControllerAnimated:YES completion:nil];
    _dictB(@{@"AC":[NSNumber numberWithInt:(int)AC]}, YES);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
