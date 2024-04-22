//
//  YDBaseTableViewCell.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDBaseTableViewCell : UITableViewCell

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

@end

NS_ASSUME_NONNULL_END
