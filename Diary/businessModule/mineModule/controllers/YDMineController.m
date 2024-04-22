//
//  YDMineController.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDMineController.h"
#import "YDMineTabCell.h"

#import "YDAboutDiaryController.h"

@interface YDMineController ()<UITableViewDelegate, UITableViewDataSource>

/** eventSource */
@property (nonatomic, strong) NSMutableArray *eventSource;

@end

@implementation YDMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self mineSubviews];
    [self mineConfig];
}

- (void)mineConfig{
//    NSArray *events = @[@{@"icon":@"setting", @"title":@"系统设置"}, @{@"icon":@"about", @"title":@"关于app"}];
    NSArray *events = @[@{@"icon":@"about", @"title":@"关于app"}];
    [self.eventSource addObjectsFromArray:events];
    [self.listTab reloadData];
}

- (void)mineSubviews{
    self.listTab.delegate = self;
    self.listTab.dataSource = self;
    [self.listTab registerClass:[YDMineTabCell class] forCellReuseIdentifier:NSStringFromClass([YDMineTabCell class])];
    [self.view addSubview:self.listTab];
    [self.listTab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.eventSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YDMineTabCell *cell = [self.listTab dequeueReusableCellWithIdentifier:NSStringFromClass([YDMineTabCell class]) forIndexPath:indexPath];
    NSDictionary *dic = self.eventSource[indexPath.row];
    [self updateCell:cell dic:dic idxPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self closeDrawerIdxPath:indexPath];
}

- (void)updateCell:(YDMineTabCell *)cell dic:(NSDictionary *)dic idxPath:(NSIndexPath *)idxPath{
    cell.imageView.image = XY_Img(dic[@"icon"]);
    cell.titleLab.text = dic[@"title"];
}

- (void)closeDrawerIdxPath:(NSIndexPath *)idxPath{
    MMDrawerController * mmdc = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [mmdc toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {}];
    [mmdc closeDrawerAnimated:YES completion:nil];
    //
    YDAboutDiaryController *appVC = [[YDAboutDiaryController alloc] init];
    [(YDBaseNavigationController *)mmdc.centerViewController pushViewController:appVC animated:YES];
}

- (NSMutableArray *)eventSource{
    if (!_eventSource) {
        _eventSource = [[NSMutableArray alloc] init];
    }
    return _eventSource;
}

@end
