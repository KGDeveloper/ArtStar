//
//  HotMoviesDetailCommentCell.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesDetailCommentCell.h"

@interface HotMoviesDetailCommentCell ()

@property (nonatomic,strong) UIView *line;

@end

@implementation HotMoviesDetailCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    
    _headerImage = [UIImageView new];
    _nameLab = [UILabel new];
    _starView = [UIView new];
    _commentLab = [UILabel new];
    _timeLab = [UILabel new];
    _zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_headerImage,_nameLab,_starView,_commentLab,_timeLab,_zansBtu,_line]];
    
    _headerImage.image = Image(@"1");
    _headerImage.layer.cornerRadius = 10;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).widthIs(20).heightIs(20);
    
    _nameLab.textColor = Color_999999;
    _nameLab.text = @"滚筒洗衣机";
    _nameLab.font = SYFont(13);
    _nameLab.sd_layout.leftSpaceToView(_headerImage, 10).centerYEqualToView(_headerImage).widthIs(150).heightIs(15);
    
    _starView.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(_headerImage).widthIs(85).heightIs(15);
    
    for (int i = 0; i < 4; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 1, 12, 12)];
        image.image = Image(@"star");
        [_starView addSubview:image];
    }
    
    _commentLab.textColor = Color_333333;
    _commentLab.text = @"这是一个可爱小姑娘，确实是很可爱";
    _commentLab.font = SYFont(13);
    _commentLab.sd_layout.leftEqualToView(_nameLab).topSpaceToView(_nameLab, 15).rightSpaceToView(self.contentView, 15).heightIs(40);
    
    _timeLab.textColor = Color_999999;
    _timeLab.text = @"2018.04.26 10：23";
    _timeLab.font = SYFont(12);
    _timeLab.sd_layout.leftEqualToView(_nameLab).topSpaceToView(_commentLab, 25).widthIs(150).heightIs(15);
    
    [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    [_zansBtu setTitle:@"67" forState:UIControlStateNormal];
    [_zansBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _zansBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _zansBtu.titleLabel.font = SYFont(12);
    [_zansBtu addTarget:self action:@selector(zansClick:) forControlEvents:UIControlEventTouchUpInside];
    _zansBtu.sd_layout.rightSpaceToView(self.contentView, 15).bottomEqualToView(_timeLab).widthIs(100).heightIs(20);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftEqualToView(_nameLab).rightSpaceToView(self.contentView, 15).bottomSpaceToView(self.contentView, 0).heightIs(1);
    
}

- (void)zansClick:(UIButton *)sender{
    
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
