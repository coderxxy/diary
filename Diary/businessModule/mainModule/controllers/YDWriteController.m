//
//  YDWriteController.m
//  Diary
//
//  Created by coderxxy on 2024/4/4.
//

#import "YDWriteController.h"

@interface YDWriteController ()<YYTextViewDelegate>
/** 提示 */
@property (nonatomic, strong) UILabel *shortLab;
/** 简介 */
@property (nonatomic, strong) YYTextView *shortDesTF;
/** 内容 */
/**  */
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) YYTextView *textTF;

/** yyyy-mm-dd */
@property (nonatomic, copy) NSString *dayDate;
/** 日记model */
@property (nonatomic, strong) YDDiaryModel *model;
@end

@implementation YDWriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationItemEvent];
    [self writeSubviews];
    [self writeConfig];
}

- (void)writeSubviews{
    self.view.backgroundColor = XYThemeColor;
    [self.view addSubview:self.shortLab];
    [self.view addSubview:self.shortDesTF];
    //
    [self.view addSubview:self.textLab];
    [self.view addSubview:self.textTF];
    //
    [self.shortLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset([UIDevice navBarHeight]);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
    [self.shortDesTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shortLab.mas_bottom);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.height.equalTo(self.shortLab);
    }];
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shortDesTF.mas_bottom);
        make.left.right.height.equalTo(self.shortLab);
    }];
    [self.textTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLab.mas_bottom);
        make.right.equalTo(self.shortLab);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.bottom.equalTo(self.view.mas_centerY).offset(100);
    }];
    //
    self.shortDesTF.layer.cornerRadius = 5;
    self.textTF.layer.cornerRadius = 8;
    self.shortDesTF.clipsToBounds = YES;
    self.textTF.clipsToBounds = YES;
}

- (void)navigationItemEvent{
    self.navigationItem.title = @"随记";
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"drawer_icon") style:UIBarButtonItemStylePlain target:self action:@selector(openDrawerAction)];
//    self.navigationItem.leftBarButtonItem = item;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"Confirm-filled") style:UIBarButtonItemStylePlain target:self action:@selector(saveEvent)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)writeConfig{
    NSDate *date = [[NSDate date] getNowDateFromat];
    NSString *dateT = [NSString stringWithFormat:@"%@", date];
    self.dayDate = [dateT substringWithRange:NSMakeRange(0, 10)];
    NSString *beginT = [dateT substringWithRange:NSMakeRange(0, dateT.length - 6)];
    NSString *content = [NSString stringWithFormat:@"%@ 随记", beginT];
    self.textLab.text = content;
    //
    self.model.dayDate = self.dayDate;
    self.model.time = beginT;
}

- (void)saveEvent{
    [self.view endEditing:YES];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    if (self.shortDesTF.text.length <= 0 || self.textTF.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"请先添加..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    //
    NSDate *saveDate = [[NSDate date] getNowDateFromat];
    NSTimeInterval timeStamp = [saveDate timeIntervalSince1970];
    NSString *saveTime = [NSString stringWithFormat:@"%.0f", timeStamp*1000];
    XY_Log(@"[yd-edit], saveTime:%@", saveTime);
    self.model.diaryId = saveTime;
    //
    [[YDDbManager shareInstance] addModel:self.model];
    [SVProgressHUD showInfoWithStatus:@"保存中..."];
    weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            strongify(self)
            !self.callback?:self.callback();
            self.callback = nil;
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

#pragma mark - YYTextViewDelegate
- (void)textViewDidBeginEditing:(YYTextView *)textView{
    NSUInteger tag = textView.tag - 4000;
    textView.verticalForm = (1 == tag);
}

- (void)textViewDidEndEditing:(YYTextView *)textView{
    NSUInteger tag = textView.tag - 4000;
    XY_Log(@"[yd-edit] textViewDidEndEditing:%@", textView.text);
}

- (void)textViewDidChange:(YYTextView *)textView{
    NSUInteger tag = textView.tag - 4000;
    textView.verticalForm = (textView.text.length > 0 && 1 == tag);
    if (0 == tag) {
        self.model.title = textView.text;
    }
    if (1 == tag) {
        self.model.diaryContent = textView.text;
    }
    XY_Log(@"[yd-edit] textViewDidChange:%@", textView.text);
}

- (UILabel *)shortLab{
    if (!_shortLab) {
        _shortLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _shortLab.text = @"标题";
        _shortLab.textColor = XYWhiteColor;
        _shortLab.backgroundColor = XYThemeColor;
        _shortLab.font = XYFont_PF_Semibold(13);
    }
    return _shortLab;
}
- (YYTextView *)shortDesTF{
    if (!_shortDesTF) {
        _shortDesTF = [[YYTextView alloc] initWithFrame:CGRectZero];
        _shortDesTF.delegate = self;
        //        _shortDesTF.textAlignment = NSTextAlignmentCenter;
        _shortDesTF.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _shortDesTF.placeholderFont = XYFont_PF_Regular(12.0);//XYFont_PF_Medium(12.0);
        _shortDesTF.placeholderTextColor = XYPlaceolderColor;
        _shortDesTF.placeholderText = @"给今天的随记写个标题吧......";
        _shortDesTF.font = XYFont_PF_Regular(15.0);
        _shortDesTF.textColor = XYThemeColor;
        _shortDesTF.backgroundColor = XYWhiteColor;
        _shortDesTF.tintColor = XYThemeColor;
        _shortDesTF.tag = 4000;
        if (@available(iOS 13.0, *)) {
            _shortDesTF.automaticallyAdjustsScrollIndicatorInsets = YES;
        } else {
            // Fallback on earlier versions
            _shortDesTF.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
    }
    return _shortDesTF;
}
- (UILabel *)textLab{
    if (!_textLab) {
        _textLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLab.text = @"今日随记";
        _textLab.textColor = XYWhiteColor;
        _textLab.backgroundColor = XYThemeColor;
        _textLab.font = XYFont_PF_Semibold(13);
    }
    return _textLab;
}
- (YYTextView *)textTF{
    if (!_textTF) {
        _textTF = [[YYTextView alloc] initWithFrame:CGRectZero];
        _textTF.font = XYFont_PF_Medium(15);
        _textTF.textColor = XYTextColor;
        _textTF.delegate = self;
        _textTF.placeholderFont = XYFont_PF_Medium(12.0);
        _textTF.placeholderText = @"今日日行记...";
        _textTF.placeholderTextColor = XYPlaceolderColor;
        //        _textTF.verticalForm = YES;
        //        _textView.dataDetectorTypes =
        _textTF.backgroundColor = XYWhiteColor;
        _textTF.tintColor = XYThemeColor;
        _textTF.tag = 4001;
        if (@available(iOS 13.0, *)) {
            _textTF.automaticallyAdjustsScrollIndicatorInsets = YES;
        } else {
            // Fallback on earlier versions
            _textTF.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }
    }
    return _textTF;
}

- (YDDiaryModel *)model{
    if (!_model) {
        _model = [[YDDiaryModel alloc] init];
    }
    return _model;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![self.textTF isExclusiveTouch] || ![self.shortDesTF isExclusiveTouch]){
        [self.textTF endEditing:YES];
        [self.shortDesTF resignFirstResponder];
    }
}

@end
