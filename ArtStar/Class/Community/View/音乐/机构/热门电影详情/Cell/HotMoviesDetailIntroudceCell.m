//
//  HotMoviesDetailIntroudceCell.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesDetailIntroudceCell.h"

@interface HotMoviesDetailIntroudceCell ()

@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UIView *line;

@end

@implementation HotMoviesDetailIntroudceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    
    _nameLab = [UILabel new];
    _detailLab = [UILabel new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_nameLab,_detailLab,_line]];
    
    _nameLab.textColor = Color_333333;
    _nameLab.text = @"介绍";
    _nameLab.font = SYFont(14);
    _nameLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _detailLab.textColor = Color_333333;
    _detailLab.font = SYFont(13);
    _detailLab.numberOfLines = 0;
    _detailLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_nameLab, 15).rightSpaceToView(self.contentView, 15).heightIs(10);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (void)setIntroudceStr:(NSString *)introudceStr{
    _introudceStr = introudceStr;
    CGFloat height = [TransformChineseToPinying string:introudceStr font:SYFont(13) space:10].size.height;
    CGFloat width = [TransformChineseToPinying string:introudceStr font:SYFont(13) space:10].size.width/(kScreenWidth - 60);
    _detailLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_nameLab, 15).rightSpaceToView(self.contentView, 15).heightIs((height+10)*width);
    _detailLab.attributedText = [TransformChineseToPinying string:introudceStr font:SYFont(13) space:10];
    
    [self setNeedsLayout];
}

- (CGFloat)cellHeightWithModel:(NSString *)text{
    CGFloat height = [TransformChineseToPinying string:text font:SYFont(13) space:10].size.height;
    CGFloat width = [TransformChineseToPinying string:text font:SYFont(13) space:10].size.width/(kScreenWidth - 60);
    return height*width + 10*width + 70;
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
