//
//  YDWriteController.h
//  Diary
//
//  Created by coderxxy on 2024/4/4.
//

#import "YDBaseController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RefreshCallback)(void);

@interface YDWriteController : YDBaseController
/** block */
@property (nonatomic, copy) RefreshCallback callback;
@end

NS_ASSUME_NONNULL_END
