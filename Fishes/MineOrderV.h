//
//  MineOrderV.h
//  Fishes
//
//  Created by test on 2018/4/13.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPagingView.h"
@interface MineOrderV : UIView<SGPageTitleViewDelegate, SGPageContentViewDelegate>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

- (instancetype)initWithFrame:(CGRect)frame andVC:(UIViewController *)VC andIndex:(NSInteger )index;
@end
