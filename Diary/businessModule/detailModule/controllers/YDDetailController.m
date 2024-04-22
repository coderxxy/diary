//
//  YDDetailController.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDDetailController.h"

@interface YDDetailController ()

@property (nonatomic, strong) YYTextView *textTF;

@end

@implementation YDDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationItemEvent];
    [self detailSubviews];
}

- (void)detailSubviews{
    [self.view addSubview:self.textTF];
    [self.textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
    //
    NSMutableString *diaryContent = [NSMutableString string];
    [diaryContent appendFormat:@"%@\n\n", self.model.title];
    [diaryContent appendFormat:@"%@\n\n", self.model.time];
    [diaryContent appendString:self.model.diaryContent];
    // 1. 创建一个属性文本
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:diaryContent];
    // 2. 为文本设置属性
    text.yy_font = [UIFont boldSystemFontOfSize:18];
    text.yy_color = XYThemeColor;
    text.yy_alignment = NSTextAlignmentCenter;
//    [text yy_setColor:XYThemeColor range:NSMakeRange(0, self.model.title.length)];
    [text yy_setColor:XYHEXCOLOR(@"#000000", 0.35) range:NSMakeRange(self.model.title.length+2, self.model.time.length)];
    [text yy_setFont:XYFont_PF_Semibold(15) range:NSMakeRange(self.model.title.length+2, self.model.time.length)];
    text.yy_lineSpacing = 5;
    // 3. 赋值到 YYTextView
    self.textTF.attributedText = text;
}

- (void)navigationItemEvent{
    self.navigationItem.title = @"今日随记";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"back_gray") style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (YYTextView *)textTF{
    if (!_textTF) {
        _textTF = [[YYTextView alloc] initWithFrame:CGRectZero];
        _textTF.font = XYFont_PF_Medium(15);
        _textTF.textColor = XYTextColor;
        _textTF.editable = NO;
        _textTF.backgroundColor = XYWhiteColor;
        _textTF.tintColor = XYThemeColor;
        _textTF.textAlignment = NSTextAlignmentCenter;
        if (@available(iOS 13.0, *)) {
            _textTF.automaticallyAdjustsScrollIndicatorInsets = YES;
        } else {
            // Fallback on earlier versions
            _textTF.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
    }
    return _textTF;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bgColor:XYWhiteColor titleColor:XYHEXCOLOR(@"#2F2E2B", 0.2)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self bgColor:XYThemeColor titleColor:XYWhiteColor];
}

- (void)bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor{
    //改变导航栏背景色
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        //设置背景色
        appearance.backgroundColor = bgColor;//XYWhiteColor;//[UIColor whiteColor];
        //设置标题颜色
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: titleColor};
        //设置返回按键和返回字体为白色
        self.navigationController.navigationBar.tintColor = XYWhiteColor;//[UIColor blackColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        // 导航栏下划线隐藏
        [appearance setShadowColor:nil];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
    else {
        UINavigationBar *bar = [UINavigationBar appearance];
        bar.barTintColor = bgColor;//[UIColor whiteColor];
        bar.tintColor = XYWhiteColor;//[UIColor blackColor];
        [self.navigationController.navigationBar setTranslucent:YES];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIFont systemFontOfSize:15 weight:0.3], NSFontAttributeName, titleColor,nil];
        [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
}

@end
