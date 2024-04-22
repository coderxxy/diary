//
//  YDDiarySubController.h
//  Diary
//
//  Created by coderxxy on 2024/4/5.
//

#import "YDBaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^Callback)(void);

@interface YDDiarySubController : YDBaseController
/** subSource */
@property (nonatomic, strong) NSMutableArray <YDDiaryModel *>*subSource;
/**  */
@property (nonatomic, copy) NSString *dateDay;
/** block */
@property (nonatomic, copy)Callback callback;

@end

NS_ASSUME_NONNULL_END
