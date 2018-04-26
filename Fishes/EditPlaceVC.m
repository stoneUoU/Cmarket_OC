//
//  EditPlaceVC.m
//  Fishes
//
//  Created by test on 2018/4/24.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "EditPlaceVC.h"

@interface EditPlaceVC ()

@end

@implementation EditPlaceVC

- (id)init
{
    _editPlaceV = [[EditPlaceV alloc] init]; //对MyUIView进行初始化
    _editPlaceV.backgroundColor = allBgColor;
    _editPlaceV.delegate = self; //将SecondVC自己的实例作为委托对象
    return [super init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp:@"收货地址" sideVal:@"" backIvName:@"custom_serve_back.png" navC:[UIColor clearColor] midFontC:deepBlackC sideFontC:deepBlackC];
    [self setUpUI];
    [self startR];
    [self performSelector:@selector(setVals) withObject:nil afterDelay:0.1f];
}
- (void)setVals{
    _editPlaceV.manField.text = _minePls.addressee;
    _editPlaceV.telField.text = _minePls.tel;
    _editPlaceV.delField.text = _minePls.detail;
    if ([_minePls.area  isEqual: @""]){
        _editPlaceV.placeField.text = [NSString stringWithFormat:@"%@-%@",_minePls.province,_minePls.city];
    }else{
        _editPlaceV.placeField.text = [NSString stringWithFormat:@"%@-%@-%@",_minePls.province,_minePls.city,_minePls.area];
    }
    if ([_minePls.defaultA  isEqual: @"0"]){
        _editPlaceV.switchBtn.on = YES;
    }else{
        _editPlaceV.switchBtn.on = NO;
    }
}
- (void)setUpUI{
    [self.view addSubview:_editPlaceV];
    //添加约束
    [self setMas];
}
- (void) setMas{
    [_editPlaceV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(StatusBarAndNavigationBarH);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenW);
        make.height.mas_equalTo(ScreenH);
    }];
}
-(void)startR{
    if ([self.netUseVals isEqualToString: @"Useable"]){
        if (self.placeholderV != nil){
            [self.placeholderV removeFromSuperview];
            self.placeholderV = nil;
        }
    }else{
        if (self.placeholderV == nil){
            self.placeholderV = [[STPlaceholderView alloc]initWithFrame:CGRectMake(0, StatusBarAndNavigationBarH, ScreenW, ScreenH - StatusBarAndNavigationBarH ) type:STPlaceholderViewTypeNoNetwork delegate:self];
            [self.view addSubview:self.placeholderV];
        }
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
// MARK: - EditPlaceVDel
- (void)toSubmit {
    if ([self.netUseVals isEqualToString: @"Useable"]){
        if ([_editPlaceV.manField.text isEqual:@""]) {
            [HudTips showToast: @"请输入收货人姓名哈" showType:Pos animationType:StToastAnimationTypeScale];
        }else if (![ValidatedFile MobileIsValidated:_editPlaceV.telField.text]){
            [HudTips showToast: @"请输入正确的手机号码哈" showType:Pos animationType:StToastAnimationTypeScale];
        }else{
            [NetWorkManager requestWithType:HttpRequestTypePost withUrlString:followRoute@"user/address/modify" withParaments:@{@"province":_minePls.province,@"city":_minePls.city,@"area":_minePls.area,@"detail":_minePls.detail,@"addressee":_editPlaceV.manField.text,@"tel":_editPlaceV.telField.text,@"default":_minePls.defaultA,@"tag":@"家",@"id":_minePls.ids} Authos:self.Auths withSuccessBlock:^(NSDictionary *feedBacks) {
                STLog(@"%@",[feedBacks modelToJSONString]);
                //进行容错处理丫:
                if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"0"]){
                    [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                    [MethodFunc popToPrevVC:self];
                    if (_placeEditB != NULL){
                        _placeEditB(@{@"succ":@YES}, YES);
                    }
                }else if ([[NSString stringWithFormat:@"%@",feedBacks[@"code"]]  isEqual: @"10009"]){
                    [MethodFunc dealAuthMiss:self tipInfo:feedBacks[@"msg"]];
                }else{
                    [HudTips showToast: feedBacks[@"msg"] showType:Pos animationType:StToastAnimationTypeScale];
                }
            } withFailureBlock:^(NSError *error) {
                STLog(@"%@",error)
            }];
        }
    }else{
        [HudTips showToast: missNetTips showType:Pos animationType:StToastAnimationTypeScale];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
