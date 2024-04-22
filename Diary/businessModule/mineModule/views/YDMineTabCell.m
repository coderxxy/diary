//
//  YDMineTabCell.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDMineTabCell.h"

@implementation YDMineTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cellSubViews];
    }
    return self;
}

- (void)cellSubViews{
    [self.contentView addSubview:self.cellSubview];
    [self.cellSubview addSubview:self.imgView];
    [self.cellSubview addSubview:self.titleLab];
    [self.cellSubview addSubview:self.sepreteLine];
    //
    [self.cellSubview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellSubview.mas_left).offset(15);
        make.top.equalTo(self.cellSubview.mas_top).offset(10);
        make.bottom.equalTo(self.cellSubview.mas_bottom).offset(-10);
        make.width.height.mas_equalTo(40);
    }];
    [self.titleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgView);
        make.left.equalTo(self.imgView.mas_right).offset(5);
        make.right.equalTo(self.cellSubview.mas_right).offset(20);
    }];
    [self.sepreteLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView);
        make.right.equalTo(self.titleLab.mas_right);
        make.bottom.equalTo(self.cellSubview);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
