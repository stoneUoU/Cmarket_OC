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
    //注册观察键盘的变化(修复键盘上移bug)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
-(void)toCloseV{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//移动UIView
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
