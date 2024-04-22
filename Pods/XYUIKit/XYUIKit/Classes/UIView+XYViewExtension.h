//
//  UIView+XYViewExtension.h
//  XYUIKit
//
//  Created by 许须耀 on 2022/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XYViewExtension)

@property (assign, nonatomic) CGFloat xy_x;
@property (assign, nonatomic) CGFloat xy_y;
@property (assign, nonatomic) CGFloat xy_w;
@property (assign, nonatomic) CGFloat xy_h;
@property (assign, nonatomic) CGFloat xy_centerX;
@property (assign, nonatomic) CGFloat xy_centerY;
@property (assign, nonatomic) CGSize xy_size;
@property (assign, nonatomic) CGPoint xy_origin;

@end

NS_ASSUME_NONNULL_END
