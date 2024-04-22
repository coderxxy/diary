//
//  YDBaseCollectionItem.h
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDBaseCollectionItem : UICollectionViewCell

/** cellSuview */
@property (nonatomic, strong) UIView *cellSubview;
/** titleLab */
@property (nonatomic, strong) UILabel *titleLab;
/** subTitleLab */
@property (nonatomic, strong) UILabel *subTitleLab;
/** contentLab */
@property (nonatomic, strong) UILabel *contentLab;
/** imgView */
@property (nonatomic, strong) UIImageView *imgView;
/** sepreteLine */
@property (nonatomic, strong) UIView *sepreteLine;
/** removeBtn */
@property (nonatomic, strong) UIButton *removeBtn;
/** idxPath */
@property (nonatomic, strong) NSIndexPath *idxPath;
@end

NS_ASSUME_NONNULL_END
