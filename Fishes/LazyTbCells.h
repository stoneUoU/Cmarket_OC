//
//  LazyTbCells.h
//  Fishes
//
//  Created by test on 2018/4/3.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LazyTbCells : UITableViewCell{
    
        UILabel *_product_title;
}
//商品主标题
@property (nonatomic ,strong) UILabel *product_title;

//商品时间
@property (nonatomic ,strong) UILabel *product_time;


@end
