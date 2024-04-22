//
//  YDBaseController.h
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDBaseController : UIViewController

/** UITableView */
@property (nonatomic, strong) UITableView *listTab;
/** UICollectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** UICollectionViewFlowLayout */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

NS_ASSUME_NONNULL_END
