//
//  YDDiarySubController.m
//  Diary
//
//  Created by coderxxy on 2024/4/5.
//

#import "YDDiarySubController.h"
#import "YDHomeDiaryItem.h"
#import "YDDetailController.h"

@interface YDDiarySubController ()<UICollectionViewDelegate, UICollectionViewDataSource, YDHomeDiaryItemDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation YDDiarySubController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self subSubviews];
}

- (NSMutableArray<YDDiaryModel *> *)subSource{
    if (!_subSource) {
        _subSource = [[NSMutableArray alloc] init];
    }
    return _subSource;
}

- (void)subSubviews{
    self.collectionView.backgroundColor = XYThemeColor;
    self.navigationItem.title = [NSString stringWithFormat:@"%@ 【%ld篇 随记】", self.dateDay, [self.subSource count]];
    // 计算每个item大小
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    CGFloat itemSize = (XYSCREEN_WIDTH - 10*3)/2;
    self.flowLayout.itemSize = CGSizeMake(itemSize, itemSize*1.2);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YDHomeDiaryItem class] forCellWithReuseIdentifier:NSStringFromClass([YDHomeDiaryItem class])];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.bottom.right.equalTo(self.view);
    }];
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.subSource count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YDHomeDiaryItem *item = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDHomeDiaryItem class]) forIndexPath:indexPath];
    [self updateItem:item idxPath:indexPath];
    return item;
}

- (void)updateItem:(YDHomeDiaryItem *)item  idxPath:(NSIndexPath *)idxPath{
    item.delegate = self;
    item.idxPath = idxPath;
    item.imgView.hidden = YES;
    item.cellSubview.backgroundColor = XYWhiteColor;
    //
    YDDiaryModel *model = self.subSource[idxPath.row];
    // 日期
    item.titleLab.text = self.dateDay;
    item.contentLab.text = model.title;
    item.subTitleLab.text = [NSString stringWithFormat:@"1 篇随记"];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YDDiaryModel *model = self.subSource[indexPath.row];
    // 查看详情
    YDDetailController *detailVC = [[YDDetailController alloc] init];
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - YDHomeDiaryItemDelegate
- (void)clickEventWithIdxPath:(NSIndexPath *)idxPath{
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"删除提示" message:@"确认删除本篇随记?"];
    alertView.buttonCancelBgColor = XYThemeColor;
    weakify(self)
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        strongify(self)
        YDDiaryModel *model = self.subSource[idxPath.row];
        [[YDDbManager shareInstance] deleteDiaryWithDiaryId:model completion:^(BOOL isSuccess) {
            if (isSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.subSource removeObject:model];
                    [self.collectionView reloadData];
                    if (0 == [self.subSource count]) {
                        self.navigationItem.title = @"日行记";
                    }
                    if (self.callback) {
                        self.callback();
                    }
                });
            }
            else{
                [SVProgressHUD showSuccessWithStatus:@"操作失败"];
            }
        }];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
//        [alertView hideView];
    }]];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
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
@end
