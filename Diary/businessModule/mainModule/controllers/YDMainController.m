//
//  YDMainController.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDMainController.h"
#import "YDMainPresenter.h"
#import "YDHomeDiaryItem.h"

@interface YDMainController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/** YDMainPresenter */
@property (nonatomic, strong) YDMainPresenter *mainPresenter;

@end

@implementation YDMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationItemEvent];
    [self mainSubviews];
    [self.mainPresenter queryData];
}

- (void)navigationItemEvent{
    self.navigationItem.title = @"日行记";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"drawer_icon") style:UIBarButtonItemStylePlain target:self action:@selector(openDrawerAction)];
    self.navigationItem.leftBarButtonItem = item;
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:XY_Img(@"add_icon03") style:UIBarButtonItemStylePlain target:self action:@selector(addEvent)];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)mainSubviews{
    self.collectionView.backgroundColor = XYThemeColor;
    
    [self.view addSubview:self.searchBar];
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    // 计算每个item大小
    CGFloat itemSize = (XYSCREEN_WIDTH - 10*3)/2;
    self.flowLayout.itemSize = CGSizeMake(itemSize, itemSize*1.2);
    self.collectionView.delegate = (id<UICollectionViewDelegate>)self.mainPresenter;
    self.collectionView.dataSource = (id<UICollectionViewDataSource>)self.mainPresenter;
    [self.collectionView registerClass:[YDHomeDiaryItem class] forCellWithReuseIdentifier:NSStringFromClass([YDHomeDiaryItem class])];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}
// open
- (void)openDrawerAction{
    MMDrawerController *mmdc = (MMDrawerController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    [mmdc toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return XY_Img(@"empty_icon");
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"随时随地记录生活的点点滴滴...";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13.0f],
                                 NSForegroundColorAttributeName: XYPlaceolderColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (YDMainPresenter *)mainPresenter{
    if (!_mainPresenter) {
        _mainPresenter = [[YDMainPresenter alloc] initWithController:self];
    }
    return _mainPresenter;
}

- (JKSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[JKSearchBar alloc] initWithFrame:CGRectMake(0, [UIDevice navBarHeight], XYSCREEN_WIDTH, 50)];
        _searchBar.backgroundColor = XYThemeColor;
        _searchBar.placeholder = @"请输入记录标题...";
        _searchBar.placeholderColor = XYPlaceolderColor;
        _searchBar.delegate = (id<JKSearchBarDelegate>)self.mainPresenter;
        [_searchBar.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_searchBar.cancelButton setTitleColor:XYWhiteColor forState:UIControlStateNormal];
    }
    return _searchBar;
}

@end
