//
//  MyselfCenterMyLabelCell.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfCenterMyLabelCell.h"

@interface MyselfCenterMyLabelCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *backView;

@end

@implementation MyselfCenterMyLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}
- (void)setCell{
    _titleLab = [UILabel new];
    _backView = [UIView new];
    
    [self.contentView sd_addSubviews:@[_titleLab,_backView]];
    
    _titleLab.text = @"我的标签";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYBFont(13);
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 25).widthIs(150).heightIs(15);
    
    _backView.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 25).rightSpaceToView(self.contentView, 15).heightIs(1);
}

- (void)setLabArr:(NSArray *)labArr{
    _labArr = labArr;
    CGFloat wight = 0;
    CGFloat height = 0;
    
    [_backView removeAllSubviews];
    
    for (int i = 0; i < labArr.count; i++) {
        if (wight + 30 + [TransformChineseToPinying stringWidthFromString:labArr[i] font:SYFont(12) width:ViewWidth(_backView)] + 20 >= kScreenWidth - 30) {
            wight = 0;
            height = height + 30;
        }
        [_backView addSubview:[self createLabel:CGRectMake(wight, height, [TransformChineseToPinying stringWidthFromString:labArr[i] font:SYFont(12) width:ViewWidth(_backView)] + 20, 20) title:labArr[i]]];
        wight = wight + 30 + [TransformChineseToPinying stringWidthFromString:labArr[i] font:SYFont(12) width:ViewWidth(_backView)] + 20;
    }
    
    _backView.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 25).rightSpaceToView(self.contentView, 15).heightIs(height);
    [self setNeedsLayout];
}

- (CGFloat)heightWithArr:(NSArray *)arr{
    CGFloat wight = 0;
    CGFloat height = 30;
    
    for (int i = 0; i < arr.count; i++) {
        if (wight + 30 + [TransformChineseToPinying stringWidthFromString:arr[i] font:SYFont(12) width:ViewWidth(_backView)] + 20 >= kScreenWidth - 30) {
            wight = 0;
            height = height + 30;
        }else{
            wight = wight + 30 + [TransformChineseToPinying stringWidthFromString:arr[i] font:SYFont(12) width:ViewWidth(_backView)] + 20;
        }
    }
    return height + 65 + 20;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLab.text = titleStr;
    _titleLab.font = SYFont(13);
}

- (UILabel *)createLabel:(CGRect)frame title:(NSString *)title{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
    label.textColor = [UIColor whiteColor];
    label.font = SYFont(12);
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    return label;
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
