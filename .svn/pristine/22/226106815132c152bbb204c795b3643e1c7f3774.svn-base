//
//  HeadLinesTableViewCell.m
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesTableViewCell.h"

@interface HeadLinesTableViewCell ()

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UIButton *deleteBtu;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIButton *zansBtu;
@property (nonatomic,strong) UIButton *commentBtu;
@property (nonatomic,strong) UIButton *shareBtu;
@property (nonatomic,strong) UIButton *playBtu;
@property (nonatomic,strong) UIView *backPlay;
@property (nonatomic,strong) UIView *line;


@end

@implementation HeadLinesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _topImage = [UIImageView new];
    _deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _titleLab = [UILabel new];
    _nameLab = [UILabel new];
    _zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _backPlay = [UIView new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_topImage,_deleteBtu,_titleLab,_nameLab,_zansBtu,_commentBtu,_shareBtu,_playBtu,_backPlay,_line]];
    
    _topImage.image = Image(@"2");
    _topImage.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20).heightIs((ViewWidth(self) - 30)/690*400);
    
    _backPlay.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _backPlay.alpha = 0.2;
    _backPlay.sd_layout.leftEqualToView(_topImage).rightEqualToView(_topImage).topEqualToView(_topImage).bottomEqualToView(_topImage);
    
    [_playBtu setImage:Image(@"play") forState:UIControlStateNormal];
    _playBtu.layer.cornerRadius = 20;
    _playBtu.layer.borderWidth = 1;
    _playBtu.layer.borderColor = [UIColor whiteColor].CGColor;
    _playBtu.layer.masksToBounds = YES;
    [_playBtu addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    _playBtu.sd_layout.rightSpaceToView(_topImage, ViewWidth(_topImage)/2 - 20).topSpaceToView(_topImage, ViewHeight(_topImage)/2 - 20).widthIs(40).heightIs(40);
    
    [_deleteBtu setImage:Image(@"del") forState:UIControlStateNormal];
    [_deleteBtu addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtu.sd_layout.rightSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 5).widthIs(10).heightIs(10);
    
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(14);
    _titleLab.numberOfLines = 2;
    _titleLab.text = @"艺术界的常青树，96岁高寿艺术家戴泽传承徐悲鸿艺术衣钵";
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_topImage, 15).rightSpaceToView(self.contentView, 15).heightIs(37);
    
    _nameLab.textColor = Color_999999;
    _nameLab.font = SYFont(12);
    _nameLab.text = @"艺术中国";
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 15).widthIs(150).heightIs(15);
    
    [_shareBtu setImage:Image(@"分享") forState:UIControlStateNormal];
    [_shareBtu setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_shareBtu setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_shareBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _shareBtu.contentHorizontalAlignment = UIViewContentModeRight;
    _shareBtu.titleLabel.font = SYFont(12);
    [_shareBtu addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    _shareBtu.sd_layout.rightSpaceToView(self.contentView, 15).bottomEqualToView(_nameLab).heightIs(16).widthIs(50);
    
    [_commentBtu setImage:Image(@"评论") forState:UIControlStateNormal];
    [_commentBtu setTitle:@"120" forState:UIControlStateNormal];
    [_commentBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_commentBtu setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_commentBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _commentBtu.contentHorizontalAlignment = UIViewContentModeRight;
    _commentBtu.titleLabel.font = SYFont(12);
    [_commentBtu addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtu.sd_layout.rightSpaceToView(_shareBtu, 25).bottomEqualToView(_nameLab).heightIs(16).widthIs(50);
    
    [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    [_zansBtu setTitle:@"235" forState:UIControlStateNormal];
    [_zansBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_zansBtu setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_zansBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _zansBtu.titleLabel.font = SYFont(12);
    _zansBtu.contentHorizontalAlignment = UIViewContentModeRight;
    [_zansBtu addTarget:self action:@selector(zansAction:) forControlEvents:UIControlEventTouchUpInside];
    _zansBtu.sd_layout.rightSpaceToView(_commentBtu, 25).bottomEqualToView(_nameLab).heightIs(16).widthIs(50);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (void)deleteAction{
    if ([self.delegate respondsToSelector:@selector(deleteNewsWithIndex: buttonOriginY:)]) {
        [self.delegate deleteNewsWithIndex:self buttonOriginY:self.btuOriginY];
    }
}

- (void)playAction{
    
}

- (void)showPlay{
    _playBtu.hidden = NO;
    _backPlay.hidden = NO;
}
- (void)hidePlay{
    _playBtu.hidden = YES;
    _backPlay.hidden = YES;
}

- (void)shareAction{
    
}

- (void)commentAction:(UIButton *)sender{
    
}

- (void)zansAction:(UIButton *)sender{
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
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
