//
//  YDDbManager.m
//  plusevent
//
//  Created by coderXY on 2024/4/4.
//

#import "YDDbManager.h"
#import <fmdb/FMDB.h>

/** extern key */
NSString *const YD_DB_Tab = @"YD_DB_TAB";
/** extern key */
NSString *const YD_DB = @"YDDB";
@interface YDDbManager ()
/** FMDatabase */
@property (nonatomic, strong) FMDatabase *db;
/** 线程安全 */
//@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
/** 表名 */
@property (nonatomic, copy) NSString *tabName;

@end

@implementation YDDbManager
static YDDbManager *dbManager = nil;
static dispatch_once_t onceToken = 0;
+ (instancetype)shareInstance{
    dispatch_once(&onceToken, ^{
        dbManager = [[YDDbManager alloc] init];
    });
    return dbManager;
}
// 1、创建表
// MARK: 创建数据库
- (void)createDB:(NSString *)dbName{
    NSString *localDB = [NSString stringWithFormat:@"%@.db", (dbName && dbName.length > 0)?dbName:YD_DB];
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:localDB];        // 路径
    self.db = [FMDatabase databaseWithPath:dbPath];         // 初始化数据库
//    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    XY_Log(@"[db-log]open db %@!", [self.db open]?@"successed😊":@"failed😭");
}

// MARK: 存储json数据
- (void)createJsonTab:(NSString *)tabName{
    //dayDate
    self.tabName = tabName?tabName:YD_DB_Tab;
    NSString *sql = @"create table if not exists %@ (dayDate text NOT NULL, jsonData text NOT NULL);";
    BOOL successed = [self.db executeUpdate:[NSString stringWithFormat:sql, self.tabName]];
    if (!successed) {
        [self.db close];
    }
    XY_Log(@"[db-log] create tab: %i", successed);
}

#pragma mark - model
// MARK: 创建表 存储具体数据
- (void)createTab:(NSString *)tabName{ // 初始化数据表
    self.tabName = tabName?tabName:YD_DB_Tab;
//    NSString *sql = @"create table if not exists %@ (id integer primary key autoincrement, diaryId integer NOT NULL, title text, time text NOT NULL, diaryContent text NOT NULL);";
    NSString *sql = @"create table if not exists %@ (diaryId text NOT NULL, title text, time text NOT NULL, diaryContent text NOT NULL, dayDate text NOT NULL);";
    BOOL successed = [self.db executeUpdate:[NSString stringWithFormat:sql, self.tabName]];
    if (!successed) {
        [self.db close];
    }
    XY_Log(@"[db-log] create tab: %i", successed);
}
- (void)insertProperty:(NSString *)name{
    NSString *alterSQL = @"ALTER TABLE %@ ADD COLUMN %@ text";
    BOOL success = [self.db executeUpdate:[NSString stringWithFormat:alterSQL, self.tabName, name]];
    XY_Log(@"[db-log] insertProperty: %i", success);
}
// 2、添加
- (void)addModel:(YDDiaryModel *)model{
//    NSString *addSql = @"insert into %@ (diaryId, title, time, diaryContent) values (?,?,?,?);";
    NSString *addSql = @"insert into %@ (diaryId, title, time, diaryContent, dayDate) values ('%@','%@','%@','%@', '%@');";
    BOOL successed = [self.db executeUpdate:[NSString stringWithFormat:addSql, self.tabName, model.diaryId, model.title, model.time, model.diaryContent, model.dayDate]];
    XY_Log(@"[db-log] insert model: %i", successed);
}
// 3、更新
- (void)updateModel:(YDDiaryModel *)model{
    NSString *updateSql = @"update %@ set title='%@', diaryContent='%@' where diaryId='%@'";
    [self.db executeUpdate:[NSString stringWithFormat:updateSql, self.tabName, model.title, model.diaryContent, model.diaryId]];
}
// 4、删除 当天只有一条时删除所有，有多条时 按照id逐条删除 或 dayDate 一次删除
- (void)deleteDiaryWithDiaryId:(YDDiaryModel *)model completion:(void(^)(BOOL isSuccess))completion{ //
    void(^callback)(BOOL state) = completion;
    NSString *removeSql = @"delete from %@ where diaryId='%@'";
    BOOL delete = [self.db executeUpdate:[NSString stringWithFormat:removeSql, self.tabName, model.diaryId]];
    !callback?:callback(delete);
    callback = nil;
    XY_Log(@"[db-log] delete model, diaryId: %i", delete);
}
- (void)deleteDiaryWithDayDate:(NSString *)dayDate completion:(void(^)(BOOL isSuccess))completion{
    void(^callback)(BOOL state) = completion;
    NSString *removeSql = @"delete from %@ where dayDate='%@'";
    BOOL delete = [self.db executeUpdate:[NSString stringWithFormat:removeSql, self.tabName, dayDate]];
    !callback?:callback(delete);
    callback = nil;
    XY_Log(@"[db-log] delete model, dayDate: %i", delete);
}
// 5、条件查询
// title
- (NSArray <YDDiaryModel *>*)queryWithTitle:(NSString *)title searchAll:(BOOL)searchAll{
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE title LIKE '%%%@%%' ORDER BY diaryId DESC", self.tabName, title]; // 标题模糊搜索
    if (!searchAll) {
        querySql = [NSString stringWithFormat:@"select * from %@ where title='%@'", self.tabName, title]; // 标题精确搜索
    }
    //
    //------ ASC 升序   DESC 降序
    FMResultSet *result = [self.db executeQuery:querySql];
    if (!result) return nil;
    NSMutableArray <YDDiaryModel *>*source = [NSMutableArray array];
    // 总数据源
    NSMutableArray *cacheArr = [NSMutableArray array];
    @autoreleasepool {
        while ([result next]) {
            NSString *title = [result stringForColumn:@"title"];
            NSString *content = [result stringForColumn:@"diaryContent"];
            NSString *time = [result stringForColumn:@"time"];
            NSString *diaryId = [result stringForColumn:@"diaryId"];
            NSString *dayDate = [result stringForColumn:@"dayDate"];
            //
            YDDiaryModel *model = [[YDDiaryModel alloc] init];
            model.dayDate = dayDate;
            model.diaryId = diaryId;
            model.title = title;
            model.time = time;
            model.diaryContent = content;
            [source addObject:model];
        }
        [result close];
        //
        NSString *dateKey = nil;
        NSMutableDictionary *dateDic = [NSMutableDictionary dictionary];;
        NSMutableArray *dateArr = [NSMutableArray array];
        //
        for (NSInteger i = 0; i < [source count]; i ++) {
            YDDiaryModel *model = source[i];
            if (!dateKey) {
                dateKey = model.dayDate;
            }
            if ([dateKey isEqualToString:model.dayDate] && i == [source count] - 1) {
                [dateArr addObject:model];
                dateDic[dateKey] = dateArr;
                // 添加最后一个数据
                [cacheArr addObject:dateDic];
            }
            else if (i == [source count] - 1 && ![dateKey isEqualToString:model.dayDate]){
                // 总数据源
                [cacheArr addObject:dateDic];
                // 重新创建数据源
                dateDic = [NSMutableDictionary dictionary];
                dateArr = [NSMutableArray array];
                [dateArr addObject:model];
                dateKey = model.dayDate;
                dateDic[dateKey] = dateArr;
                // 添加最后一个数据
                [cacheArr addObject:dateDic];
            }
            else if ([dateKey isEqualToString:model.dayDate]) {
                [dateArr addObject:model];
                dateDic[dateKey] = dateArr;
            }
            else{
                // 总数据源
                [cacheArr addObject:dateDic];
                // 重新创建数据源
                dateDic = [NSMutableDictionary dictionary];
                dateArr = [NSMutableArray array];
                [dateArr addObject:model];
                dateKey = model.dayDate;
                dateDic[dateKey] = dateArr;
            }
        }
    }
    return [cacheArr copy];
}
// content
- (NSArray <YDDiaryModel *>*)queryWithContent:(NSString *)content searchAll:(BOOL)searchAll{
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE diaryContent LIKE '%%%@%%' ORDER BY diaryId DESC", self.tabName, content]; // 标题模糊搜索
    if (!searchAll) {
        querySql = [NSString stringWithFormat:@"select * from %@ where diaryContent='%@'", self.tabName, content]; // 标题精确搜索
    }
    //------ ASC 升序   DESC 降序
    FMResultSet *result = [self.db executeQuery:querySql];
    if (!result) return nil;
    NSMutableArray <YDDiaryModel *>*source = [NSMutableArray array];
    // 总数据源
    NSMutableArray *cacheArr = [NSMutableArray array];
    @autoreleasepool {
        while ([result next]) {
            NSString *title = [result stringForColumn:@"title"];
            NSString *content = [result stringForColumn:@"diaryContent"];
            NSString *time = [result stringForColumn:@"time"];
            NSString *diaryId = [result stringForColumn:@"diaryId"];
            NSString *dayDate = [result stringForColumn:@"dayDate"];
            //
            YDDiaryModel *model = [[YDDiaryModel alloc] init];
            model.dayDate = dayDate;
            model.diaryId = diaryId;
            model.title = title;
            model.time = time;
            model.diaryContent = content;
            [source addObject:model];
        }
        [result close];
        //
        NSString *dateKey = nil;
        NSMutableDictionary *dateDic = [NSMutableDictionary dictionary];;
        NSMutableArray *dateArr = [NSMutableArray array];
        //
        for (NSInteger i = 0; i < [source count]; i ++) {
            YDDiaryModel *model = source[i];
            if (!dateKey) {
                dateKey = model.dayDate;
            }
            if ([dateKey isEqualToString:model.dayDate] && i == [source count] - 1) {
                [dateArr addObject:model];
                dateDic[dateKey] = dateArr;
                // 添加最后一个数据
                [cacheArr addObject:dateDic];
            }
            else if (i == [source count] - 1 && ![dateKey isEqualToString:model.dayDate]){
                // 总数据源
                [cacheArr addObject:dateDic];
                // 重新创建数据源
                dateDic = [NSMutableDictionary dictionary];
                dateArr = [NSMutableArray array];
                [dateArr addObject:model];
                dateKey = model.dayDate;
                dateDic[dateKey] = dateArr;
                // 添加最后一个数据
                [cacheArr addObject:dateDic];
            }
            else if ([dateKey isEqualToString:model.dayDate]) {
                [dateArr addObject:model];
                dateDic[dateKey] = dateArr;
            }
            else{
                // 总数据源
                [cacheArr addObject:dateDic];
                // 重新创建数据源
                dateDic = [NSMutableDictionary dictionary];
                dateArr = [NSMutableArray array];
                [dateArr addObject:model];
                dateKey = model.dayDate;
                dateDic[dateKey] = dateArr;
            }
        }
    }
    return source;
}
// 6、获取全部
- (NSArray *)queryAll{
    //------ ASC 升序   DESC 降序
    NSString *querySql = [NSString stringWithFormat:@"select * from %@ ORDER BY diaryId DESC", self.tabName];
    //------ ASC 升序   DESC 降序
    FMResultSet *result = [self.db executeQuery:querySql];
    if (!result) return nil;
    NSMutableArray <YDDiaryModel *>*source = [NSMutableArray array];
    // 总数据源
    NSMutableArray *cacheArr = [NSMutableArray array];
    @autoreleasepool {
        while ([result next]) {
            NSString *title = [result stringForColumn:@"title"];
            NSString *content = [result stringForColumn:@"diaryContent"];
            NSString *time = [result stringForColumn:@"time"];
            NSString *diaryId = [result stringForColumn:@"diaryId"];
            NSString *dayDate = [result stringForColumn:@"dayDate"];
            //
            YDDiaryModel *model = [[YDDiaryModel alloc] init];
            model.dayDate = dayDate;
            model.diaryId = diaryId;
            model.title = title;
            model.time = time;
            model.diaryContent = content;
            [source addObject:model];
        }
        [result close];
        //
        NSString *dateKey = nil;
        NSMutableDictionary *dateDic = [NSMutableDictionary dictionary];;
        NSMutableArray *dateArr = [NSMutableArray array];
        //
        for (NSInteger i = 0; i < [source count]; i ++) {
            YDDiaryModel *model = source[i];
            if (!dateKey) {
                dateKey = model.dayDate;
            }
            if ([dateKey isEqualToString:model.dayDate] && i == [source count] - 1) {
                [dateArr addObject:model];
                dateDic[dateKey] = dateArr;
                // 添加最后一个数据
                [cacheArr addObject:dateDic];
            }
            else if (i == [source count] - 1 && ![dateKey isEqualToString:model.dayDate]){
                // 总数据源
                [cacheArr addObject:dateDic];
                // 重新创建数据源
                dateDic = [NSMutableDictionary dictionary];
                dateArr = [NSMutableArray array];
                [dateArr addObject:model];
                dateKey = model.dayDate;
                dateDic[dateKey] = dateArr;
                // 添加最后一个数据
                [cacheArr addObject:dateDic];
            }
            else if ([dateKey isEqualToString:model.dayDate]) {
                [dateArr addObject:model];
                dateDic[dateKey] = dateArr;
            }
            else{
                // 总数据源
                [cacheArr addObject:dateDic];
                // 重新创建数据源
                dateDic = [NSMutableDictionary dictionary];
                dateArr = [NSMutableArray array];
                [dateArr addObject:model];
                dateKey = model.dayDate;
                dateDic[dateKey] = dateArr;
            }
        }
    }
    return [cacheArr copy];
}

@end

