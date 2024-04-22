#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSString+XYStringExtension.h"
#import "UIColor+XYExtension.h"
#import "UIView+XYViewExtension.h"
#import "XYButton.h"
#import "XYUIKit.h"

FOUNDATION_EXPORT double XYUIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char XYUIKitVersionString[];

