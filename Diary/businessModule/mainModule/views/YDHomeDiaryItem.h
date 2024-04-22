//
//  YDHomeDiaryItem.h
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDBaseCollectionItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YDHomeDiaryItemDelegate <NSObject>

@optional
- (void)clickEventWithIdxPath:(NSIndexPath *)idxPath;

@end

@interface YDHomeDiaryItem : YDBaseCollectionItem
/** YDHomeDiaryItemDelegate */
@property (nonatomic, weak) id <YDHomeDiaryItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
