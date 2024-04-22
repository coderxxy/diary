//
//  YDHomeDiaryItem.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDHomeDiaryItem.h"

@interface YDHomeDiaryItem ()

@end

@implementation YDHomeDiaryItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self itemSubviews];
    }
    return self;
}

- (void)itemSubviews{
    
    self.cellSubview.backgroundColor = XYWhiteColor; //
    [self.removeBtn addTarget:self action:@selector(clickWithSender:) forControlEvents:UIControlEventTouchUpInside];
    //
    [self.contentView addSubview:self.cellSubview];
    [self.cellSubview addSubview:self.titleLab];            // 日期
    [self.cellSubview addSubview:self.contentLab];          // 标题
    [self.cellSubview addSubview:self.subTitleLab];         // 心情
    [self.cellSubview addSubview:self.imgView];
    [self.cellSubview addSubview:self.removeBtn];
    
    [self.cellSubview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellSubview.mas_top).offset(10);
        make.left.equalTo(self.cellSubview.mas_left).offset(10);
        make.right.equalTo(self.cellSubview.mas_right).offset(-10);
    }];
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLab);
        make.centerX.centerY.equalTo(self.cellSubview);
    }];
    UIImage *img = XY_Img(@"remove");
    double scale = img.size.width/img.size.height;
    [self.removeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20*scale);
        make.right.equalTo(self.cellSubview.mas_right).offset(-10);
        make.bottom.equalTo(self.cellSubview.mas_bottom).offset(-10);
    }];
    [self.subTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cellSubview.mas_bottom).offset(-10);
//        make.left.right.equalTo(self.titleLab);
        make.left.equalTo(self.titleLab);
        make.right.equalTo(self.removeBtn.mas_left).offset(-10);
    }];
    //
    self.imgView.hidden = YES;
    self.imgView.image = XY_Img(@"add_white");
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.cellSubview);
        make.width.height.mas_equalTo(40);
    }];
    self.cellSubview.layer.cornerRadius = 8.0;
    self.cellSubview.clipsToBounds = YES;
}

- (void)clickWithSender:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickEventWithIdxPath:)]) {
        [self.delegate clickEventWithIdxPath:self.idxPath];
    }
}

@end
