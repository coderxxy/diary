//
//  XYButton.m
//  XYUIKit
//
//  Created by 许须耀 on 2022/4/21.
//

#import "XYButton.h"
#import "NSString+XYStringExtension.h"
#import "UIView+XYViewExtension.h"

const CGFloat imgWidth = 20.0;
const CGFloat imgHeight = 20.0;
const CGFloat leading = 5.0;

@interface XYButton ()

@property (nonatomic, strong) UILabel *titLab;      // title
@property (nonatomic, strong) UIImageView *imgView; // 图片
@property (nonatomic, strong) UIImage *img;

@property (nonatomic, assign) XYImgDirectionType directionType;     //  图片位置
@property (nonatomic, copy) NSString *imageName;                    //  图片
@property (nonatomic, copy) NSString *title;                        //  文字
@property (nonatomic, assign) CGFloat titleFontValue;
@property (nonatomic, assign) CGFloat weight;

@end

@implementation XYButton

+ (XYButton *) buttonWithTitle:(NSString *)title
                       imageName:(NSString *)imageName
                  actionTarget:(id)actionTarget
                          action:(SEL)action
                  imageDirection:(XYImgDirectionType)imageDirection{
    return [[XYButton alloc] initWithTitle:title imageName:imageName titleFontValue:12.0 weight:0.0 actionTarget:actionTarget action:action imageDirection:XYImgDirectionType_default];
}

+ (XYButton *) buttonWithTitle:(NSString *)title
                       imageName:(NSString *)imageName
                  titleFontValue:(CGFloat)titleFontValue
                          weight:(CGFloat)weight
                  actionTarget:(id)actionTarget
                          action:(SEL)action
                  imageDirection:(XYImgDirectionType)imageDirection{
    return [[XYButton alloc] initWithTitle:title imageName:imageName titleFontValue:titleFontValue weight:weight actionTarget:actionTarget action:action imageDirection:imageDirection];
}

+ (XYButton *) buttonWithTitle:(NSString *)title titleFontValue:(CGFloat)titleFontValue weight:(CGFloat)weight actionTarget:(id)actionTarget action:(SEL)action{
    return [[XYButton alloc] initWithTitle:title imageName:nil titleFontValue:titleFontValue weight:weight actionTarget:actionTarget action:action imageDirection:XYImgDirectionType_default];
}

+ (XYButton *) buttonWithImageName:(NSString *)imageName actionTarget:(id)actionTarget action:(SEL)action{
    return [[XYButton alloc] initWithTitle:nil imageName:imageName titleFontValue:0.0 weight:0 actionTarget:actionTarget action:action imageDirection:XYImgDirectionType_default];
}

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
               titleFontValue:(CGFloat)titleFontValue
                       weight:(CGFloat)weight
                 actionTarget:(id)actionTarget
                       action:(SEL)action
               imageDirection:(XYImgDirectionType)imageDirection{
    self = [super init];
    if (self) {
        
        self.title = title;
        self.imageName = imageName;
        self.
        self.directionType = imageDirection;
        self.space = 5.0;   // default is 5.0
        self.titleFontValue = titleFontValue;
        self.titLab.textColor = [UIColor blackColor];
        
        [self addSubview:self.imgView];
        [self addSubview:self.titLab];
        
        [self layoutUIHandle];
        self.titLab.font = [UIFont systemFontOfSize:titleFontValue weight:weight];
        [self addTarget:actionTarget action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) layoutUIHandle{
    CGSize titleSize = [_title fitSizeWithFontValue:_titleFontValue weight:_weight];
    switch (_directionType) {
        case XYImgDirectionType_left | XYImgDirectionType_default:
        {
            [self imageLeftHandle:titleSize];
        }
            break;
        case XYImgDirectionType_top:
        {
            [self imageTopHandle:titleSize];
        }
            break;
        case XYImgDirectionType_right:
        {
            [self imageRightHandle:titleSize];
        }
            break;
        case XYImgDirectionType_bottom:
        {
            [self imageBottomHandle:titleSize];
        }
            break;
            
        default:
        {
            [self imageLeftHandle:titleSize];
        }
            break;
    }
}

- (void)imageLeftHandle:(CGSize)titleSize{
    CGRect imgRect = CGRectMake(5, 5, imgWidth, imgHeight);
    CGRect labelRect = CGRectMake(CGRectGetMaxX(imgRect)+_space, CGRectGetMinY(imgRect), titleSize.width+0.5, titleSize.height+0.5);
    self.imgView.frame = imgRect;
    self.titLab.frame = labelRect;
    self.xy_w = leading*2+CGRectGetWidth(imgRect)+_space+CGRectGetWidth(labelRect);
    CGFloat height = (titleSize.height+0.5)>imgHeight?(titleSize.height+0.5):imgHeight;
    self.xy_h = leading*2+height;
    
    self.titLab.xy_centerY = self.imgView.xy_centerY;
}
- (void)imageTopHandle:(CGSize)titleSize{
    CGRect imgRect = CGRectMake(5, 5, imgWidth, imgHeight);
    CGRect labelRect = CGRectMake(5, CGRectGetMaxY(imgRect)+_space, titleSize.width+0.5, titleSize.height+0.5);
    self.imgView.frame = imgRect;
    self.titLab.frame = labelRect;
    self.xy_w = ((imgRect.size.width > titleSize.width) ? imgRect.size.width+leading*2:titleSize.width+leading*2+0.5);
    self.xy_h = leading*2+imgRect.size.height+_space+titleSize.height+0.5;
    
    if (titleSize.width>imgWidth) {
        self.imgView.xy_centerX = self.titLab.xy_centerX;
    }else if (imgWidth>titleSize.width){
        self.titLab.xy_centerX = self.imgView.xy_centerX;
    }
}
- (void)imageRightHandle:(CGSize)titleSize{
    
    CGRect labelRect = CGRectMake(5, 5, titleSize.width+0.5, titleSize.height+0.5);
    CGRect imgRect = CGRectMake(CGRectGetMaxX(labelRect)+_space, 5, imgWidth, imgHeight);
    
    self.imgView.frame = imgRect;
    self.titLab.frame = labelRect;
    
    self.xy_w = leading*2+CGRectGetWidth(imgRect)+_space+CGRectGetWidth(labelRect);
    CGFloat height = (titleSize.height+0.5)>imgHeight?(titleSize.height+0.5):imgHeight;
    self.xy_h = leading*2+height;
    
    self.titLab.xy_centerY = self.imgView.xy_centerY;
}
- (void)imageBottomHandle:(CGSize)titleSize{
    
    CGRect labelRect = CGRectMake(5, 5, titleSize.width+0.5, titleSize.height+0.5);
    CGRect imgRect = CGRectMake(5, CGRectGetMaxY(labelRect)+_space, imgWidth, imgHeight);
    self.imgView.frame = imgRect;
    self.titLab.frame = labelRect;
    
    self.xy_w = ((imgRect.size.width > titleSize.width) ? imgRect.size.width+leading*2:titleSize.width+leading*2+0.5);
    self.xy_h = leading*2+titleSize.height+_space+imgRect.size.height+0.5;
    
    if (titleSize.width>imgWidth) {
        self.imgView.xy_centerX = self.titLab.xy_centerX;
    }else if (imgWidth>titleSize.width){
        self.titLab.xy_centerX = self.imgView.xy_centerX;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (CGFloat)width{
    return self.xy_w;
}

- (CGFloat)height{
    return self.xy_h;
}

#pragma mark - setter method

- (void)setTitle:(NSString *)title{
    _title = title;
    if (title.length <= 0) return;
    self.titLab.text = title;
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    if (imageName.length <= 0) return;
    self.img = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.imgView.image = self.img;
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.titLab.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    self.titLab.textColor = titleColor;
}

- (void)setTitleFontValue:(CGFloat)titleFontValue{
    _titleFontValue = titleFontValue;
}

- (void)setWeight:(CGFloat)weight{
    _weight = weight;
}

- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    self.titLab.backgroundColor = bgColor;
    self.backgroundColor = bgColor;
}

- (void)setTitleBackgroundColor:(UIColor *)titleBackgroundColor{
    _titleBackgroundColor = titleBackgroundColor;
    self.titLab.backgroundColor = titleBackgroundColor;
}

- (void)setDirectionType:(XYImgDirectionType)directionType{
    _directionType = directionType;
}

- (void)setSpace:(CGFloat)space{
    if (space<=3.0) {
        space = 3.0;
    }else if (space>= 10.0){
        space = 10.0;
    }
    _space = space;
    [self layoutUIHandle];
}

#pragma mark - lazy UI method
- (UILabel *)titLab{
    if (!_titLab) {
        _titLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titLab;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imgView;
}

@end
