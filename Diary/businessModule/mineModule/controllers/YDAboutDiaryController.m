//
//  YDAboutDiaryController.m
//  Diary
//
//  Created by coderxxy on 2024/4/5.
//

#import "YDAboutDiaryController.h"

@interface YDAboutDiaryController ()

/** logoImgView */
@property (nonatomic, strong) UIImageView *logoImgView;
/** name */
@property (nonatomic, strong) UILabel *appName;

@end

@implementation YDAboutDiaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self aboutSubviews];
}

- (void)aboutSubviews{
    self.navigationItem.title = @"日行记";
    NSString *shortDes = @"随时随地用文字记录生活、记录每一刻，Eye On Diary！";
    self.appName.text = [NSString stringWithFormat:@"%@ (%@)\n\n%@",[self appInfo][@"CFBundleDisplayName"], [self appInfo][@"CFBundleShortVersionString"], shortDes];
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.appName];
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_centerY).offset(-150);
        make.width.height.mas_equalTo(80);
    }];
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgView.mas_bottom).offset(20);
        make.left.equalTo(self.logoImgView.mas_left).offset(-100);
        make.right.equalTo(self.logoImgView.mas_right).offset(100);
//        make.height.mas_equalTo(50);
    }];
    self.logoImgView.layer.cornerRadius = 8;
    self.logoImgView.clipsToBounds = YES;
}

- (NSDictionary *)appInfo {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSMutableDictionary *appInfo = [NSMutableDictionary dictionary];
//
//    [appInfo setObject:infoDictionary[(NSString *)kCFBundleIdentifierKey] forKey:@"Bundle Identifier"];
//    [appInfo setObject:infoDictionary[(NSString *)kCFBundleNameKey] forKey:@"Bundle Name"];
//    [appInfo setObject:infoDictionary[(NSString *)kCFBundleVersionKey] forKey:@"Version"];
//    [appInfo setObject:infoDictionary[(NSString *)kCFBundleShortVersionStringKey] forKey:@"Build"];
//    [appInfo setObject:infoDictionary[(NSString *)kCFBundleDisplayNameKey] forKey:@"Display Name"];
//    [appInfo setObject:infoDictionary[(NSString *)kCFBundleIconFilesKey] forKey:@"Icon Name"];
    return infoDictionary;
}


- (UIImageView *)logoImgView{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _logoImgView.image = XY_Img(@"logo_icon");
    }
    return _logoImgView;
}

- (UILabel *)appName{
    if (!_appName) {
        _appName = [[UILabel alloc] initWithFrame:CGRectZero];
        _appName.textColor = XYTitleColor;
        _appName.font = XYFont_PF_Semibold(18.0);
        _appName.numberOfLines = 0;
        _appName.textAlignment = NSTextAlignmentCenter;
    }
    return _appName;
}

@end
