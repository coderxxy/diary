# XYUIKit for OC
[![SPM supported](https://img.shields.io/badge/SPM-supported-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![podversion](https://img.shields.io/cocoapods/v/XYUIKit.svg)](https://cocoapods.org/pods/XYUIKit)

* Encapsulate basic controls for quick and easy UI creation. Usually used in the project of the basic UI and tools, in order to facilitate their own and everyone, together to manage it... Join us! 👍👍👍
```objc
/**
 图片在文字的位置
 */
typedef NS_ENUM(NSInteger, XYImgDirectionType){
    XYImgDirectionType_default = 0,                               //  默认 left
    XYImgDirectionType_left,                                      //  left
    XYImgDirectionType_top,                                       //  top
    XYImgDirectionType_right,                                     //  right
    XYImgDirectionType_bottom                                     //  bottom
};

@interface XYButton : UIControl
/** the backgroundColor of XYButton */
@property (nonatomic, strong) UIColor *bgColor;
/** the titleBackgroundColor is different of titleColor */
@property (nonatomic, strong) UIColor *titleBackgroundColor;
/** title-color */
@property (nonatomic, strong) UIColor *titleColor;
/** the size of title,but it is an instance. */
@property (nonatomic, strong) UIFont *titleFont;
/** the space of title and image, suggest set 3.0 ~ 10.0 */
@property (nonatomic, assign) CGFloat space;

/** You can get the width of this button, and you have no permissions to set or modify the width. */
@property (nonatomic, assign, readonly, getter=width) CGFloat buttonWidth;
/** You can get the height of this button, and you have no permissions to set or modify the height. */
@property (nonatomic, assign, readonly, getter=height) CGFloat buttonHeight;


/** You will make a button which only with a background image that you input the parameter. */
+ (XYButton *) buttonWithImageName:(NSString *)imageName actionTarget:(id)actionTarget action:(SEL)action;
/** You will make a button which only with the title that you input the parameter, title, title's font-value and font-weight. */
+ (XYButton *) buttonWithTitle:(NSString *)title titleFontValue:(CGFloat)titleFontValue weight:(CGFloat)weight actionTarget:(id)actionTarget action:(SEL)action;
/** You will make a button which with the title and background image, that you input the parameter, title, background image and the background image direction of this button is you make it ,but title's defalut font-value is 12 and  default font-weight is 0.1. */
+ (XYButton *) buttonWithTitle:(NSString *)title imageName:(NSString *)imageName actionTarget:(id)actionTarget action:(SEL)action imageDirection:(XYImgDirectionType)imageDirection;
/** You will make a button which with the title and background image,title's font-value, font-weight and background image's location,these parameters just by yourself input. */
+ (XYButton *) buttonWithTitle:(NSString *)title imageName:(NSString *)imageName titleFontValue:(CGFloat)titleFontValue weight:(CGFloat)weight actionTarget:(id)actionTarget action:(SEL)action imageDirection:(XYImgDirectionType)imageDirection;
@end
```
# <a id="How_to_use_XYUIKit"></a>How to use XYUIKit
* Installation with CocoaPods：`pod 'XYUIKit'`
* Installation with [Carthage](https://github.com/Carthage/Carthage)：`github "CoderXXY/XYUIKit"`
* Manual import：
    * Drag All files in the `XYUIKit` folder to project
    * Import the main file：`#import "XYUIKit.h"`
    * like as :
```objc
- (void)buttonHandle{
    XYButton *bottomImgButton = [XYButton buttonWithTitle:@"bottomImgButton" imageName:@"apple-login" titleFontValue:14 weight:0.1 actionTarget:self action:@selector(handleAction) imageDirection:XYImgDirectionType_bottom];
    bottomImgButton.frame = CGRectMake(10, 100, bottomImgButton.width, bottomImgButton.height);
    bottomImgButton.bgColor = [UIColor cyanColor];
    bottomImgButton.titleColor = [UIColor blackColor];
    bottomImgButton.space = 5;
    [self.view addSubview:bottomImgButton];
    
    XYButton *leftImgButton = [XYButton buttonWithTitle:@"click" imageName:@"apple-login" titleFontValue:14 weight:0.1 actionTarget:self action:@selector(handleAction) imageDirection:XYImgDirectionType_left];
    leftImgButton.frame = CGRectMake(CGRectGetMaxX(bottomImgButton.frame)+10, 100, leftImgButton.width, leftImgButton.height);
    leftImgButton.bgColor = [UIColor cyanColor];
    leftImgButton.titleColor = [UIColor blackColor];
    leftImgButton.space = 5;
    [self.view addSubview:leftImgButton];
    
    XYButton *rightImgButton = [XYButton buttonWithTitle:@"rightImgButton" imageName:@"apple-login" titleFontValue:14 weight:0.1 actionTarget:self action:@selector(handleAction) imageDirection:XYImgDirectionType_right];
    rightImgButton.frame = CGRectMake(CGRectGetMaxX(leftImgButton.frame)+10, 100, rightImgButton.width, rightImgButton.height);
    rightImgButton.bgColor = [UIColor cyanColor];
    rightImgButton.titleColor = [UIColor blackColor];
    rightImgButton.space = 5;
    [self.view addSubview:rightImgButton];
    
    XYButton *topImgButton = [XYButton buttonWithTitle:@"click" imageName:@"apple-login" titleFontValue:14 weight:0.1 actionTarget:self action:@selector(handleAction) imageDirection:XYImgDirectionType_top];
    topImgButton.frame = CGRectMake(CGRectGetMaxX(rightImgButton.frame)+10, 100, topImgButton.width, topImgButton.height);
    topImgButton.bgColor = [UIColor cyanColor];
    topImgButton.titleColor = [UIColor blackColor];
    topImgButton.space = 5;
    [self.view addSubview:topImgButton];
}

- (void)handleAction{
    
}
```
![281651118335_ pic](https://user-images.githubusercontent.com/16486815/165673653-78de835a-16b4-44a7-9111-dad6f4e60297.jpg)

## Installation

XYUIKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XYUIKit'
```

## Author

coderXXY, coderxxy@163.com

## License

XYUIKit is available under the MIT license. See the LICENSE file for more info.

