//
//  AppUpdateV.m
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "AppUpdateV.h"
//#import "SZUtils.h"

@interface AppUpdateV()
//立即更新
@property (nonatomic, strong)UIButton *toStoreBtn;
//下次再说
@property (nonatomic, strong)UIButton *toCancelBtn;
//叉号
@property (nonatomic, strong)UIButton *toDissBtn;
//更新图片
@property (nonatomic, strong)UIImageView *updateIV;

@end

static const float kHorizontalDistance  = 40.f;
static const float kVerticalDistance    = 120.f;
static const float kDefaultFont         = 16.f;
static const float kButtonHeight        = 25.f;

typedef enum : NSUInteger {
    AppUpdateVGotoStoreBtn = 1,
    AppUpdateVWithOutUpdateBtn,
} AppUpdateVBtn;

@implementation AppUpdateV

- (instancetype)initWithFrame:(CGRect)frame isForcedUpdate:(BOOL)forcedUpdate versionStr:(NSString *)versionStr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:0.8f];
        [self setUpUI:forcedUpdate];
    }
    return self;
}

-(void)setUpUI:(BOOL)forcedUpdate{
    CGFloat bottomRectWidth  = ScreenW - kHorizontalDistance*2;
    CGFloat bottomRectHeight = ScreenH - kVerticalDistance*2;
    CGRect bottomRect = CGRectZero;
    bottomRect.origin.x = kHorizontalDistance;
    bottomRect.origin.y = kVerticalDistance;
    bottomRect.size.width  = bottomRectWidth;
    bottomRect.size.height = bottomRectHeight;

    UIView *botV = [[UIView alloc] initWithFrame:bottomRect];
    [botV setBackgroundColor:[UIColor whiteColor]];
    [botV.layer setCornerRadius:6.f];
    [botV.layer setMasksToBounds:YES];
    [self addSubview:botV];
    bottomRect.size.height = kButtonHeight;

    _updateIV = [[UIImageView alloc] init ];
    _updateIV.image = [UIImage imageNamed:@"appUpdate_bg.png"];
    [botV addSubview:_updateIV];
    [_updateIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(botV);
        make.width.mas_equalTo(ScreenW - kHorizontalDistance*2);
        make.height.mas_equalTo(150);
    }];

    if (forcedUpdate){
        _toStoreBtn = [[UIButton alloc] init];
        _toStoreBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_toStoreBtn setTitle:[NSString stringWithFormat:@"前往更新"] forState:UIControlStateNormal];
        [_toStoreBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:kDefaultFont]];
        [_toStoreBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_toStoreBtn setTitleColor:[UIColor colorWithRed:63.0f/255.0f green:162.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [_toStoreBtn setTag:AppUpdateVGotoStoreBtn];
        [botV addSubview:_toStoreBtn];
        [_toStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(botV);
            make.width.mas_equalTo(ScreenW - kHorizontalDistance*2);
            make.height.mas_equalTo(44);
        }];
    }else{
        _toDissBtn = [[UIButton alloc] init];
        _toDissBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_toDissBtn setTitle:[NSString stringWithFormat:@"取消"] forState:UIControlStateNormal];
        [_toDissBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:kDefaultFont]];
        [_toDissBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_toDissBtn setTitleColor:[UIColor colorWithRed:63.0f/255.0f green:162.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [_toDissBtn setTag:AppUpdateVWithOutUpdateBtn];
        [botV addSubview:_toDissBtn];
        [_toDissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_equalTo(botV);
        }];

        _toCancelBtn = [[UIButton alloc] init];
        _toCancelBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_toCancelBtn setTitle:[NSString stringWithFormat:@"下次再说"] forState:UIControlStateNormal];
        [_toCancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:kDefaultFont]];
        [_toCancelBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_toCancelBtn setTitleColor:[UIColor colorWithRed:63.0f/255.0f green:162.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [_toCancelBtn setTag:AppUpdateVWithOutUpdateBtn];
        [botV addSubview:_toCancelBtn];
        [_toCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(botV);
            make.width.mas_equalTo((ScreenW - kHorizontalDistance*2)/2);
            make.height.mas_equalTo(44);
        }];

        _toStoreBtn = [[UIButton alloc] init];
        _toStoreBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        [_toStoreBtn setTitle:[NSString stringWithFormat:@"前往更新"] forState:UIControlStateNormal];
        [_toStoreBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:kDefaultFont]];
        [_toStoreBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_toStoreBtn setTitleColor:[UIColor colorWithRed:63.0f/255.0f green:162.0f/255.0f blue:255.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [_toStoreBtn setTag:AppUpdateVGotoStoreBtn];
        [botV addSubview:_toStoreBtn];
        [_toStoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(botV);
            make.width.mas_equalTo((ScreenW - kHorizontalDistance*2)/2);
            make.height.mas_equalTo(44);
        }];
    }
}

- (void)clickEvent:(id)sender {
    UIButton *tempBtn = sender;
    switch (tempBtn.tag) {
        case AppUpdateVGotoStoreBtn:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(toAppStore)]) {
                [_delegate toAppStore];
            }
        }
            break;
        case AppUpdateVWithOutUpdateBtn:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(toCancel)]) {
                [_delegate toCancel];
            }
        }
            break;
    }
}

@end
