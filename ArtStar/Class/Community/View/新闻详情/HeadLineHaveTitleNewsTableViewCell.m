//
//  HeadLineHaveTitleNewsTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "HeadLineHaveTitleNewsTableViewCell.h"

@interface HeadLineHaveTitleNewsTableViewCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UIView *line;


@end

@implementation HeadLineHaveTitleNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _titleLab = [UILabel new];
    _detailLab = [UILabel new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_titleLab,_detailLab,_line]];
    
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(13);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 30).rightSpaceToView(self.contentView, 15).heightIs(13);
    
    _detailLab.textColor = Color_333333;
    _detailLab.font = SYFont(13);
    _detailLab.textAlignment = NSTextAlignmentLeft;
    _detailLab.numberOfLines = 0;
    _detailLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 20).rightSpaceToView(self.contentView, 15).heightIs(30);

    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(_detailLab, 0).heightIs(10);
    
    [self setupAutoHeightWithBottomView:_line bottomMargin:0];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}

- (void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    _detailLab.attributedText = [self attributedStringWithString:detailStr];
    _detailLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 20).rightSpaceToView(self.contentView, 15).heightIs(([self attributedStringWithString:detailStr].size.width/(kScreenWidth - 30))*30);
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(_detailLab, 0).heightIs(10);
}

- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string{
    NSMutableParagraphStyle *pargraph = [[NSMutableParagraphStyle alloc]init];
    pargraph.lineSpacing = 10;
    pargraph.firstLineHeadIndent = 30;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:SYFont(13),NSParagraphStyleAttributeName:pargraph}];
    return attributedStr;
}

- (CGFloat)tableViewCellRowHeight:(NSString *)string{
    return 53 + ([self attributedStringWithString:string].size.width/(kScreenWidth - 30))*30 + 10;;
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
