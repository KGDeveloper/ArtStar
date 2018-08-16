//
//  FriendsThemeLeftImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsThemeLeftImageCell.h"

@interface FriendsThemeLeftImageCell ()

@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) YYTextView *textView;
@property (nonatomic,strong) UILabel *nikNameLab;
@property (nonatomic,strong) UILabel *themeLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *countLab;
@property (nonatomic,strong) UIButton *commentBtu;
@property (nonatomic,strong) UIButton *zansBtu;
@property (nonatomic,strong) UIButton *shareBtu;
@property (nonatomic,strong) UIButton *headerBtu;
@property (nonatomic,strong) UIButton *topBtu;
@property (nonatomic,strong) UIButton *deleteBtu;
@property (nonatomic,strong) UIView *labBack;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsThemeLeftImageCell

- (void)fillCellWithModel:(NSDictionary *)model{
    NSData *strData = [model[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
    NSString *str = dataArr[0];
    for (int i = 1; i < dataArr.count; i++) {
        str = [NSString stringWithFormat:@"%@\n%@",str,dataArr[i]];
    }
    if (str != nil) {
        if ([model[@"composing"] integerValue] == 3) {
            [self changeYYTextView:_textView text:str alignment:YYTextVerticalAlignmentTop];
        }else if ([model[@"composing"] integerValue] == 4){
            [self changeYYTextView:_textView text:str alignment:YYTextVerticalAlignmentCenter];
        }
    }
    if ([model[@"type"] integerValue] == 2) {
        _themeLab.hidden = YES;
    }else if ([model[@"type"] integerValue] == 1){
        _themeLab.hidden = NO;
        _themeLab.text = [NSString stringWithFormat:@"# %@ #",model[@"title"]];
    }else{
        _themeLab.hidden = YES;
    }
    NSArray *imageArr = model[@"images"];
    NSDictionary *imageDic = [imageArr firstObject];
    [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    
    NSDictionary *dic = model[@"user"];
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    _locationLab.text = model[@"location"];
    _timeLab.text = model[@"createTimeStr"];
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"rccommentNum"] integerValue]] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"likeCount"] integerValue]] forState:UIControlStateNormal];
}

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
    _themeLab = [UILabel new];
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
    
    [self.contentView sd_addSubviews:@[_headerImage,_nikNameLab,_textView,_topImage,_themeLab,_commentBtu,_zansBtu,_timeLab,_locationLab,_countLab,_shareBtu,_headerBtu,_topBtu,_deleteBtu,_labBack,_line]];
    
    _headerImage.layer.cornerRadius = 14;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.image = Image(@"图片加载失败");
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
    
    _topImage.image = Image(@"图片加载失败");
    _topImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_headerImage, 15).widthIs(kScreenWidth - 165).heightIs((kScreenWidth - 165)/450*690);
    
    _labBack.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _labBack.alpha = 0.4;
    _labBack.sd_layout.rightEqualToView(_topImage).bottomEqualToView(_topImage).widthIs(27).heightIs(14);
    
    _countLab.textColor = [UIColor whiteColor];
    _countLab.font = FZFont(11);
    _countLab.text = @"1/9";
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.sd_layout.rightEqualToView(_topImage).bottomEqualToView(_topImage).widthIs(27).heightIs(14);

    _textView.textColor = Color_333333;

    [self changeYYTextView:_textView text:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:YYTextVerticalAlignmentCenter];
    _textView.sd_layout.topEqualToView(_topImage).rightSpaceToView(self.contentView, 15).widthIs(115).heightIs((kScreenWidth - 165)/450*690);

    _themeLab.textColor = Color_333333;
    _themeLab.font = FZFont(13);
    _themeLab.text = @"# 哈哈这是标题 #";
    _themeLab.textAlignment = NSTextAlignmentRight;
    _themeLab.sd_layout.leftSpaceToView(self.contentView, 15).rightSpaceToView(self.contentView, 15).topSpaceToView(_textView, 15).heightIs(20);
    
    [_shareBtu setImage:Image(@"分享") forState:UIControlStateNormal];
    [_shareBtu addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    _shareBtu.sd_layout.rightSpaceToView(self.contentView, 15).topSpaceToView(_themeLab, 15).widthIs(16).heightIs(16);
    
    [_commentBtu setTitle:@"123万" forState:UIControlStateNormal];
    [_commentBtu setTitleColor:[UIColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
    _commentBtu.titleLabel.font = FZFont(12);
    [_commentBtu setImage:Image(@"评论") forState:UIControlStateNormal];
    [_commentBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _commentBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_commentBtu addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
    _commentBtu.sd_layout.rightSpaceToView(_shareBtu, 25).centerYEqualToView(_shareBtu).widthIs(50).heightIs(30);
    
    [_zansBtu setTitle:@"123万" forState:UIControlStateNormal];
    [_zansBtu setTitleColor:[UIColor colorWithHexString:@"#b3b3b3"] forState:UIControlStateNormal];
    _zansBtu.titleLabel.font = FZFont(12);
    [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    [_zansBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    _zansBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_zansBtu addTarget:self action:@selector(zansClick:) forControlEvents:UIControlEventTouchUpInside];
    _zansBtu.sd_layout.rightSpaceToView(_commentBtu, 25).centerYEqualToView(_shareBtu).widthIs(50).heightIs(30);
    
    _timeLab.textColor = Color_b3b3b3;
    _timeLab.font = FZFont(12);
    _timeLab.text = @"12：23";
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.sd_layout.leftSpaceToView(self.contentView, 15).centerYEqualToView(_shareBtu).widthIs(70).heightIs(20);
    
    _locationLab.textColor = Color_b3b3b3;
    _locationLab.font = FZFont(12);
    _locationLab.text = @"北京";
    _locationLab.textAlignment = NSTextAlignmentLeft;
    _locationLab.sd_layout.leftSpaceToView(_timeLab, 10).centerYEqualToView(_shareBtu).widthIs(150).heightIs(20);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (YYTextView *)changeYYTextView:(YYTextView *)textView text:(NSString *)text alignment:(YYTextVerticalAlignment)alignment{
    textView.font = FZFont(13);
    textView.verticalForm = YES;
    textView.textVerticalAlignment = alignment;
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc]init];
    paragrapStyle.lineSpacing = 7;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(13),NSParagraphStyleAttributeName:paragrapStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
}

- (void)headerClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.rfuid.integerValue];
    }
}

- (void)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.rfuid.integerValue];
    }
}
- (void)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.rfuid.integerValue];
    }
}
- (void)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.rfuid.integerValue];
    }
}
- (void)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:self.rfuid.integerValue];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
