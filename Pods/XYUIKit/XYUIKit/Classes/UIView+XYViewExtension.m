//
//  UIView+XYViewExtension.m
//  XYUIKit
//
//  Created by 许须耀 on 2022/4/21.
//

#import "UIView+XYViewExtension.h"

@implementation UIView (XYViewExtension)

- (void)setXy_x:(CGFloat)xy_x{
    CGRect frame = self.frame;
    frame.origin.x = xy_x;
    self.frame = frame;
}

- (CGFloat)xy_x{
    return self.frame.origin.x;
}

- (void)setXy_y:(CGFloat)xy_y
{
    CGRect frame = self.frame;
    frame.origin.y = xy_y;
    self.frame = frame;
}

- (CGFloat)xy_y
{
    return self.frame.origin.y;
}

- (void)setXy_w:(CGFloat)xy_w
{
    CGRect frame = self.frame;
    frame.size.width = xy_w;
    self.frame = frame;
}

- (CGFloat)xy_w
{
    return self.frame.size.width;
}

- (void)setXy_h:(CGFloat)xy_h
{
    CGRect frame = self.frame;
    frame.size.height = xy_h;
    self.frame = frame;
}

- (CGFloat)xy_h
{
    return self.frame.size.height;
}

- (void)setXy_size:(CGSize)xy_size
{
    CGRect frame = self.frame;
    frame.size = xy_size;
    self.frame = frame;
}

- (CGSize)xy_size
{
    return self.frame.size;
}

- (void)setXy_origin:(CGPoint)xy_origin
{
    CGRect frame = self.frame;
    frame.origin = xy_origin;
    self.frame = frame;
}

- (CGPoint)xy_origin
{
    return self.frame.origin;
}

- (void)setXy_centerX:(CGFloat)xy_centerX{
    CGPoint point = self.center;
    point.x = xy_centerX;
    self.center = point;
}
- (CGFloat)xy_centerX{
    return self.center.x;
}

- (void)setXy_centerY:(CGFloat)xy_centerY{
    CGPoint point = self.center;
    point.y = xy_centerY;
    self.center = point;
}

- (CGFloat)xy_centerY{
    return self.center.y;
}

@end
