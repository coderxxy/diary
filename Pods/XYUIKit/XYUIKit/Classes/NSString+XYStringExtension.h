//
//  NSString+XYStringExtension.h
//  XYUIKit
//
//  Created by 许须耀 on 2022/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XYStringExtension)
/** 判断字符串是否有效 */
- (BOOL)isValidStr;

/// if content.lenght is zero, the method will return CGZero, and the title default font-value is 15,return CGSize.
- (CGSize)fitSizeWithContent;

/// if content.lenght is zero, the method will return CGZero, and the title default font-value is 15,return CGSize.
/// @param limitSize the limit-size
- (CGSize)fitSizeLimitSize:(CGSize)limitSize;

/// if content.lenght is zero, the method will return CGZero, and if you do not take font-value,the title default font-value is 15.
/// @param fontValue the font-value,default is 15
/// @param weight the weight-value
- (CGSize)fitSizeWithFontValue:(CGFloat)fontValue weight:(CGFloat)weight;

/** 根据字符串获取size
 @param font 字符串font
 */
- (CGSize)fitSizeWithFont:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
