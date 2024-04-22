//
//  YDDiaryModel.h
//  Diary
//
//  Created by coderxxy on 2024/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YDDiaryModel : NSObject

/** diaryId 保存时间时间戳 */
@property (nonatomic, copy) NSString *diaryId;
/** title 标题 */
@property (nonatomic, copy) NSString *title;
/** time 时间 进入页面的时间 */
@property (nonatomic, copy) NSString *time;
/** 同一天 */
@property (nonatomic, copy) NSString *dayDate;
/** diaryContent 内容 */
@property (nonatomic, copy) NSString *diaryContent;

@end

NS_ASSUME_NONNULL_END
/**
 @{data:[]}
 date : [@{@"id":@"timestmap",@"title":@"xxx", @"time":@"xxxx-xx-xx hh-mm-ss", @"diaryContent":@"xxxxxxxxxxx"}, @{}]],
 date : [@{@"id":@"timestmap",@"title":@"xxx", @"time":@"xxxx-xx-xx hh-mm-ss", @"diaryContent":@"xxxxxxxxxxx"}, @{}]],
 date : [@{@"id":@"timestmap",@"title":@"xxx", @"time":@"xxxx-xx-xx hh-mm-ss", @"diaryContent":@"xxxxxxxxxxx"}, @{}]],
 date : [@{@"id":@"timestmap",@"title":@"xxx", @"time":@"xxxx-xx-xx hh-mm-ss", @"diaryContent":@"xxxxxxxxxxx"}, @{}]]
 
 */
