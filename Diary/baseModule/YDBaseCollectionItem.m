//
//  YDBaseCollectionItem.m
//  Diary
//
//  Created by coderXY on 2024/4/4.
//

#import "YDBaseCollectionItem.h"

@interface YDBaseCollectionItem ()

@end

@implementation YDBaseCollectionItem

- (UIView *)cellSubview{
    if (!_cellSubview) {
        _cellSubview = [[UIView alloc] initWithFrame:CGRectZero];
        _cellSubview.backgroundColor = XYHEXCOLOR(@"#ffffff", 0.05);
    }
    return _cellSubview;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textColor = XYPlaceolderColor;
        _titleLab.numberOfLines = 0;
        _titleLab.font = XYFont_PF_Medium(13);
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _subTitleLab.textColor = XYPlaceolderColor;//[XYWhiteColor colorWithAlphaComponent:0.5];
        _subTitleLab.font = XYFont_PF_Medium(13);
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _subTitleLab;
}

- (UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLab.textColor = XYThemeColor;
        _contentLab.font = XYFont_PF_Medium(15);
        _contentLab.numberOfLines = 0;
        _contentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLab;
}

- (UIView *)sepreteLine{
    if (!_sepreteLine) {
        _sepreteLine = [[UIView alloc] initWithFrame:CGRectZero];
        _sepreteLine.backgroundColor = XYHexStrColor(@"#FA1A64");
    }
    return _sepreteLine;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _imgView;
}

- (UIButton *)removeBtn{
    if (!_removeBtn) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeBtn.backgroundColor = XYClearColor;
        [_removeBtn setImage:XY_Img(@"remove") forState:UIControlStateNormal];
    }
    return _removeBtn;
}

@end
