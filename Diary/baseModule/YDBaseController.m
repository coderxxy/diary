//
//  YDBaseController.m
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "YDBaseController.h"

@interface YDBaseController ()

@end

@implementation YDBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XYWhiteColor;//[UIColor colorWithHexString:@"#000000"];
}

- (UITableView *)listTab{
    if (!_listTab) {
        _listTab = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTab.backgroundColor = XYWhiteColor;
    }
    return _listTab;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 定义每个cell纵向的间距
        _flowLayout.minimumLineSpacing = 10.0;
        // 定义每个cell的横向间距
        _flowLayout.minimumInteritemSpacing = 10.0;
        // collectionview 左右两边间距
        _flowLayout.itemSize = CGSizeMake(0.0, 0.0);
        // 计算每个item大小
        CGFloat itemSize = (XYSCREEN_WIDTH - 10*3)/2; // h/w = 1.2
        _flowLayout.itemSize = CGSizeMake(itemSize, itemSize);
        // 每个item的edginset
        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = XYWhiteColor;
    }
    return _collectionView;
}

@end
