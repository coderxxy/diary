//
//  YDDbManager.h
//  plusevent
//
//  Created by coderXY on 2024/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDDbManager : NSObject
/** 实例化单例 */
+ (instancetype)shareInstance;
/** 创建 db */
- (void)createDB:(NSString *)dbName;
/** 创建表 */
- (void)createTab:(NSString *)tabName;
/** 新增一个字符串类型属性 */
- (void)insertProperty:(NSString *)name;
/** 添加 */
- (void)addModel:(YDDiaryModel *)model;
/** 删除 多条时 按照id删除*/
- (void)deleteDiaryWithDiaryId:(YDDiaryModel *)model completion:(void(^)(BOOL isSuccess))completion;
/** 只有一条时 两个删除任选一 */
- (void)deleteDiaryWithDayDate:(NSString *)dayDate completion:(void(^)(BOOL isSuccess))completion;
/** 获取全部 */
- (NSArray *)queryAll;
/** 查询 searchAll yes，按照title某乎搜索,反之精确搜索 */
- (NSArray <YDDiaryModel *>*)queryWithTitle:(NSString *)title searchAll:(BOOL)searchAll;
/** 查询 searchAll yes，按照内容某乎搜索,反之精确搜索 */
- (NSArray <YDDiaryModel *>*)queryWithContent:(NSString *)content searchAll:(BOOL)searchAll;
@end

NS_ASSUME_NONNULL_END
