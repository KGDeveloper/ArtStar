//
//  FriendsLeftImageRightLabelCell.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.


//
//  FriendsThemeLeftImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsLeftImageRightLabelCell.h"

@interface FriendsLeftImageRightLabelCell ()


@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) YYTextView *textView;
@property (nonatomic,strong) UIButton *shareBtu;
@property (nonatomic,strong) UIButton *headerBtu;
@property (nonatomic,strong) UIButton *topBtu;
@property (nonatomic,strong) UIButton *deleteBtu;
@property (nonatomic,strong) UIView *labBack;
@property (nonatomic,strong) UIView *line;

@end


@implementation FriendsLeftImageRightLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _headerImage = [UIImageView new];
    _nikNameLab = [UILabel new];
    _textView = [YYTextView new];
    _topImage = [UIImageView new];
    _commentBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _zansBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _timeLab = [UILabel new];
    _locationLab = [UILabel new];
    _countLab = [UILabel new];
    _shareBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _labBack = [UIView new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_headerImage,_nikNameLab,_textView,_topImage,_commentBtu,_zansBtu,_timeLab,_locationLab,_countLab,_shareBtu,_headerBtu,_topBtu,_deleteBtu,_labBack,_line]];
    
    _headerImage.layer.cornerRadius = 14;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.image = Image(@"1");
    _headerImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).widthIs(28).heightIs(28);
    
    [_headerBtu addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    _headerBtu.sd_layout.leftEqualToView(_headerImage).topEqualToView(_headerImage).widthIs(28).heightIs(28);
    
    _nikNameLab.textColor = Color_333333;
    _nikNameLab.font = SYFont(15);
    _nikNameLab.text = @"轩哥哥回来了";
    _nikNameLab.sd_layout.leftSpaceToView(_headerImage, 10).centerYEqualToView(_headerImage).heightIs(20).widthIs(150);
    
    [_deleteBtu setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _deleteBtu.titleLabel.font = SYFont(11);
    [_deleteBtu setTitleColor:[UIColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
    [_deleteBtu addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtu.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(_headerImage).widthIs(50).heightIs(30);
    
    _topImage.image = Image(@"2");
    _topImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_headerImage, 15).widthIs(kScreenWidth - 165).heightIs((kScreenWidth - 165)/450*690);
    
    [_topBtu addTarget:self action:@selector(allIamgeClick:) forControlEvents:UIControlEventTouchUpInside];
    _topBtu.sd_layout.leftEqualToView(_topImage).topEqualToView(_topImage).widthIs(kScreenWidth - 165).heightIs((kScreenWidth - 165)/450*690);
    
    _labBack.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _labBack.alpha = 0.4;
    _labBack.sd_layout.rightEqualToView(_topImage).bottomEqualToView(_topImage).widthIs(27).heightIs(14);
    
    _countLab.textColor = [UIColor whiteColor];
    _countLab.font = FZFont(11);
    _countLab.text = @"1/9";
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.sd_layout.rightEqualToView(_topImage).bottomEqualToView(_topImage).widthIs(27).heightIs(14);
    
    _textView.textColor = Color_333333;
    _textView.userInteractionEnabled = YES;
    _textView.sd_layout.topEqualToView(_topImage).rightSpaceToView(self.contentView, 15).widthIs(115).heightIs((kScreenWidth - 165)/450*690);
    
    [_shareBtu setImage:Image(@"分享") forState:UIControlStateNormal];
    [_shareBtu addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    _shareBtu.sd_layout.rightSpaceToView(self.contentView, 15).topSpaceToView(_textView, 20).widthIs(16).heightIs(16);
    
    [_commentBtu setTitle:@"123万" forState:UIControlStateNormal];
    [_commentBtu setTitleColor:[UIColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
    _commentBtu.titleLabel.font = FZFont(12);
    [_commentBtu setImage:Image(@"评论") forState:UIControlStateNormal];
    [_commentBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _commentBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_commentBtu addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtu.sd_layout.rightSpaceToView(_shareBtu, 25).centerYEqualToView(_shareBtu).widthIs(70).heightIs(30);
    
    [_zansBtu setTitle:@"123万" forState:UIControlStateNormal];
    [_zansBtu setTitleColor:[UIColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
    _zansBtu.titleLabel.font = FZFont(12);
    [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    [_zansBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_zansBtu addTarget:self action:@selector(zansClick:) forControlEvents:UIControlEventTouchUpInside];
    _zansBtu.sd_layout.rightSpaceToView(_commentBtu, 25).centerYEqualToView(_shareBtu).widthIs(70).heightIs(30);
    
    _timeLab.textColor = Color_b3b3b3;
    _timeLab.font = FZFont(12);
    _timeLab.text = @"12：23";
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.sd_layout.leftSpaceToView(self.contentView, 15).centerYEqualToView(_shareBtu).widthIs(70).heightIs(20);
    
    _locationLab.textColor = Color_b3b3b3;
    _locationLab.font = FZFont(12);
    _locationLab.text = @"北京";
    _locationLab.textAlignment = NSTextAlignmentLeft;
    _locationLab.sd_layout.leftSpaceToView(_timeLab, 10).centerYEqualToView(_shareBtu).widthIs(70).heightIs(20);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (YYTextView *)changeYYTextView:(YYTextView *)textView text:(NSString *)text alignment:(YYTextVerticalAlignment)alignment{
    textView.font = FZFont(13);
    textView.verticalForm = YES;
    textView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc]init];
    paragrapStyle.lineSpacing = 7;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(13),NSParagraphStyleAttributeName:paragrapStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
}

- (void)headerClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.cellIndex];
    }
}

- (void)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.cellIndex];
    }
}
- (void)allIamgeClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(lookAllCellImage:)]) {
        [self.delegate lookAllCellImage:self.cellIndex];
    }
}
- (void)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.cellIndex];
    }
}
- (void)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.cellIndex];
    }
}
- (void)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:self.cellIndex];
    }
}
- (void)setTopImageUrl:(NSString *)topImageUrl{
    _topImageUrl = topImageUrl;
    [_topImage sd_setImageWithURL:[NSURL URLWithString:topImageUrl]];
}
- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    NSData *strData = [contentStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
    NSString *str = strArr[0];
    for (int i = 1; i < strArr.count; i++) {
        str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
    }
    [self changeYYTextView:_textView text:str alignment:_textAlignment];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

