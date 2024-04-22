//
//  YDMainPresenter.h
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDBasePresenter.h"
@class YDMainController;

NS_ASSUME_NONNULL_BEGIN

@interface YDMainPresenter : YDBasePresenter

/** source */
@property (nonatomic, strong) NSMutableArray *diarySource;
/** YDMainController */
@property (nonatomic, weak) YDMainController *mainVC;
/** 获取所有 */
- (void)queryData;
@end

NS_ASSUME_NONNULL_END
