//
//  NSString+XYStringExtension.m
//  XYUIKit
//
//  Created by 许须耀 on 2022/4/22.
//

#import "NSString+XYStringExtension.h"

const CGFloat defaultFontValue = 12.0;  // 文字默认大小

@implementation NSString (XYStringExtension)

/** 判断字符串是否有效 */
- (BOOL)isValidStr{
    if (self == nil || self == NULL) return NO;
    if ([self isKindOfClass:[NSNull class]]) return NO;
    if ([self isKindOfClass:[NSString class]] && ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 || 0 == self.length)) return NO;
    if ([self isKindOfClass:[NSString class]] && ([self isEqualToString:@"<null>"] || [self isEqualToString:@"(null)"])) return NO;
    return YES;
}

/// if content.lenght is zero, the method will return CGZero, and the title default font-value is 15,return CGSize.
- (CGSize)fitSizeWithContent{
    CGSize size = CGSizeZero;
    if (self.length <= 0) return size;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:defaultFontValue]} context:nil];
    size = rect.size;
    return size;
}
/// if content.lenght is zero, the method will return CGZero, and the title default font-value is 15,return CGSize.
/// @param limitSize the limit-size
- (CGSize)fitSizeLimitSize:(CGSize)limitSize{
    CGSize size = CGSizeZero;
    if (self.length <= 0) return size;
    CGRect rect = [self boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:defaultFontValue]} context:nil];
    size = rect.size;
    return size;
}
/// if content.lenght is zero, the method will return CGZero, and if you do not take font-value,the title default font-value is 15.
/// @param fontValue the font-value,default is 15
/// @param weight the weight-value
- (CGSize)fitSizeWithFontValue:(CGFloat)fontValue weight:(CGFloat)weight{
    CGSize size = CGSizeZero;
    if (self.length <= 0) return size;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:(fontValue == 0)?defaultFontValue:fontValue weight:weight]} context:nil];
    size = rect.size;
    return size;
}
/** 根据字符串获取size
 @param font 字符串font
 */
- (CGSize)fitSizeWithFont:(UIFont *)font{
    CGSize size = CGSizeZero;
    if (self.length <= 0) return size;
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    size = rect.size;
    return size;
}

+ (CGSize)getSizeWithContent:(NSString *)content{
    CGSize size = CGSizeZero;
    if (content.length <= 0) return size;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:defaultFontValue]} context:nil];
    size = rect.size;
    return size;
}

+ (CGSize)getSizeWithContent:(NSString *)content limitSize:(CGSize)limitSize{
    CGSize size = CGSizeZero;
    if (content.length <= 0) return size;
    CGRect rect = [content boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:defaultFontValue]} context:nil];
    size = rect.size;
    return size;
}

+ (CGSize)getSizeWithContent:(NSString *)content fontValue:(CGFloat)fontValue weight:(CGFloat)weight{
    CGSize size = CGSizeZero;
    if (content.length <= 0) return size;
    CGRect rect = [content boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:(fontValue == 0)?defaultFontValue:fontValue weight:weight]} context:nil];
    size = rect.size;
    return size;
}



@end
