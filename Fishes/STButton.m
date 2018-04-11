//
//  STButton.m
//  Fishes
//
//  Created by test on 2018/4/8.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import "STButton.h"


@implementation STButton

/**
 * 第二种方法
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden)
    {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets
{
    _hitTestEdgeInsets = hitTestEdgeInsets;
}

/**
 * 第一种方法
 */
//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    return CGRectContainsPoint(HitTestingBounds(self.bounds, self.minimumHitTestWidth, self.minimumHitTestHeight), point);
//}
//
//CGRect HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight)
//{
//    CGRect hitTestingBounds = bounds;
//    if (minimumHitTestWidth > bounds.size.width)
//    {
//        hitTestingBounds.size.width = minimumHitTestWidth;
//        hitTestingBounds.origin.x -= (hitTestingBounds.size.width - bounds.size.width)/2;
//    }
//
//    if (minimumHitTestHeight > bounds.size.height)
//    {
//        hitTestingBounds.size.height = minimumHitTestHeight;
//        hitTestingBounds.origin.y -= (hitTestingBounds.size.height - bounds.size.height)/2;
//    }
//    return hitTestingBounds;
//}

@end
