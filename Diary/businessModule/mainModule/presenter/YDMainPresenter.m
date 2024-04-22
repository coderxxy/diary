//
//  YDMainPresenter.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDMainPresenter.h"
#import "YDHomeDiaryItem.h"
#import "YDMainController.h"
#import "YDWriteController.h"
#import "YDDetailController.h"
#import "YDDiarySubController.h"

@interface YDMainPresenter ()<UICollectionViewDelegate, UICollectionViewDataSource, JKSearchBarDelegate, YDHomeDiaryItemDelegate>

/** searchSource */
@property (nonatomic, strong) NSMutableArray *searchSource;

@property (nonatomic, assign) BOOL isSearching;

@end

@implementation YDMainPresenter

- (instancetype)initWithController:(UIViewController *)controller{
    self = [super initWithController:controller];
    if (self) {
        self.mainVC = (YDMainController *)controller;
    }
    return self;
}

- (NSMutableArray *)diarySource{
    if (!_diarySource) {
        _diarySource = [[NSMutableArray alloc] init];
    }
    return _diarySource;
}

- (NSMutableArray *)searchSource{
    if (!_searchSource) {
        _searchSource = [[NSMutableArray alloc] init];
    }
    return _searchSource;
}

- (void)queryData{
    NSArray *datas = [[YDDbManager shareInstance] queryAll];
    if (!datas || 0 == [datas count]) return;
    [self.diarySource removeAllObjects];
    [self.diarySource addObjectsFromArray:datas];
    [self.mainVC.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.isSearching) return [self.searchSource count];
    //
    return (0 == [self.diarySource count])? 1 : [self.diarySource count] + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YDHomeDiaryItem *item = [self.mainVC.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDHomeDiaryItem class]) forIndexPath:indexPath];
    item.idxPath = indexPath;
    item.delegate = self;
    item.removeBtn.hidden = (self.isSearching || (!self.isSearching && 0 == indexPath.row));
    if (self.isSearching) {
        [self updateSearchItem:item idxPath:indexPath];
    }
    else{
        [self updateItem:item idxPath:indexPath];
    }
    return item;
}

- (void)updateItem:(YDHomeDiaryItem *)item idxPath:(NSIndexPath *)idxPath{
    item.imgView.hidden = (0 == idxPath.row)?NO:YES;
    item.titleLab.hidden = (0 == idxPath.row)?YES:NO;
    item.contentLab.hidden = (0 == idxPath.row)?YES:NO;
    item.subTitleLab.hidden = (0 == idxPath.row)?YES:NO;
    [item.subTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item.cellSubview.mas_bottom).offset(-10);
        make.left.equalTo(item.titleLab);
        make.right.equalTo(item.removeBtn.mas_left).offset(-10);
    }];
    [item.subTitleLab layoutIfNeeded];
    //
    item.cellSubview.backgroundColor = (0 == idxPath.row)?XYHexStrColor(@"#979797"):XYWhiteColor;
    if (0 == idxPath.row) return;
    //
    NSDictionary *dic = self.diarySource[idxPath.row-1];
    //
    NSArray *dayDates = [dic allKeys];
    NSString *dayDate = [dayDates firstObject];
    NSArray *diaryModels = dic[dayDate];
    item.removeBtn.hidden = [diaryModels count] > 1;
    // 日期
    item.titleLab.text = dayDate;
    item.subTitleLab.text = [NSString stringWithFormat:@"%ld 篇随记", [diaryModels count]];
    if (1 == [diaryModels count]) {
        YDDiaryModel *model = [diaryModels firstObject];
        item.contentLab.text = model.title;
    }
    else{
        NSMutableString *titles = [NSMutableString string];
        for (NSInteger i = 0; i < [diaryModels count]; i ++) {
            YDDiaryModel *model = diaryModels[i];
            [titles appendFormat:@"%@\n", model.title];
            if (2 == i && [diaryModels count] > 2) {
                [titles appendFormat:@"......"];
                break;
            }
        }
        item.contentLab.text = titles;
    }
}

- (void)updateSearchItem:(YDHomeDiaryItem *)item idxPath:(NSIndexPath *)idxPath{
    item.imgView.hidden = YES;
    item.titleLab.hidden = NO;
    item.contentLab.hidden = NO;
    item.subTitleLab.hidden = NO;
    item.cellSubview.backgroundColor = XYWhiteColor;
    [item.subTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(item.cellSubview.mas_bottom).offset(-10);
        make.left.right.equalTo(item.titleLab);
    }];
    [item.subTitleLab layoutIfNeeded];
    NSDictionary *dic = self.searchSource[idxPath.row];
    //
    NSArray *dayDates = [dic allKeys];
    NSString *dayDate = [dayDates firstObject];
    NSArray *diaryModels = dic[dayDate];
    // 日期
    item.titleLab.text = dayDate;
    item.subTitleLab.text = [NSString stringWithFormat:@"%ld 篇随记", [diaryModels count]];
    if (1 == [diaryModels count]) {
        YDDiaryModel *model = [diaryModels firstObject];
        item.contentLab.text = model.title;
    }
    else{
        NSMutableString *titles = [NSMutableString string];
        for (NSInteger i = 0; i < [diaryModels count]; i ++) {
            YDDiaryModel *model = diaryModels[i];
            [titles appendFormat:@"%@\n", model.title];
            if (2 == i && [diaryModels count] > 2) {
                [titles appendFormat:@"......"];
                break;
            }
        }
        item.contentLab.text = titles;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearching) {
        [self didSelectIdxPath:indexPath searching:YES];
        return;
    }
    if (0 == indexPath.row) { // 添加新日记
        YDWriteController *writeVC = [[YDWriteController alloc] init];
        weakify(self)
        writeVC.callback = ^{
            [weakself queryData];
        };
        [self.mainVC.navigationController pushViewController:writeVC animated:YES];
        return;
    }
    [self didSelectIdxPath:indexPath searching:NO];
}

- (void)didSelectIdxPath:(NSIndexPath *)idxPath searching:(BOOL)searching{
    //
    NSInteger idx = searching?idxPath.row:idxPath.row-1;
    NSDictionary *dic = searching?self.searchSource[idx]:self.diarySource[idx];
    //
    NSArray *dayDates = [dic allKeys];
    NSString *dayDate = [dayDates firstObject];
    NSArray *diaryModels = dic[dayDate];
    //
    if (1 == [diaryModels count]) {
        YDDiaryModel *model = [diaryModels firstObject];
        // 查看详情
        YDDetailController *detailVC = [[YDDetailController alloc] init];
        detailVC.model = model;
        [self.mainVC.navigationController pushViewController:detailVC animated:YES];
    }
    else{
        YDDiarySubController *subVC = [[YDDiarySubController alloc] init];
        [subVC.subSource addObjectsFromArray:diaryModels];
        subVC.dateDay = dayDate;
        weakify(self)
        subVC.callback = ^{
            [weakself queryData];
        };
        [self.mainVC.navigationController pushViewController:subVC animated:YES];
    }
}

#pragma mark - YDHomeDiaryItemDelegate
- (void)clickEventWithIdxPath:(NSIndexPath *)idxPath{
    //
    NSInteger idx = self.isSearching?idxPath.row:idxPath.row-1;
    NSDictionary *dic = self.isSearching?self.searchSource[idx]:self.diarySource[idx];
    //
    NSArray *dayDates = [dic allKeys];
    NSString *dayDate = [dayDates firstObject];
    NSArray *diaryModels = dic[dayDate];
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"删除提示" message:@"确认删除本篇随记?"];
    alertView.buttonCancelBgColor = XYThemeColor;
    weakify(self)
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        strongify(self)
        //
        if (1 == [diaryModels count]) {
            YDDiaryModel *model = [diaryModels firstObject];
            [SVProgressHUD showInfoWithStatus:@"删除中..."];
            [[YDDbManager shareInstance] deleteDiaryWithDiaryId:model completion:^(BOOL isSuccess) {
                if (isSuccess) {
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        if (self.isSearching) {
                            [self.searchSource removeObject:dic];
                            [self queryData];
                        }
                        else{
                            [self.diarySource removeObject:dic];
                        }
                        [self.mainVC.collectionView reloadData];
                    });
                }
                else{
                    [SVProgressHUD showSuccessWithStatus:@"操作失败"];
                }
            }];
        }
        else{
            
        }
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
//        [alertView hideView];
    }]];
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert];
        [self.mainVC presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - JKSearchBarDelegate
// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(JKSearchBar *)searchBar{
    self.isSearching = YES;
    [self.searchSource removeAllObjects];
    NSString *searchText = searchBar.text;
    //
    NSArray *models = [[YDDbManager shareInstance] queryWithTitle:searchText searchAll:YES];
    if ([models count] > 0) {
        [self.searchSource addObjectsFromArray:models];
    }
    [self.mainVC.collectionView reloadData];
    XY_Log(@"[yd-log] searchBarSearchButtonClicked:%@", searchText);
}
// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(JKSearchBar *)searchBar{
    self.isSearching = NO;
    [self.searchSource removeAllObjects];
    [self.mainVC.collectionView reloadData];
    XY_Log(@"[yd-log] searchBarCancelButtonClicked:%@", searchBar.text);
}

@end
