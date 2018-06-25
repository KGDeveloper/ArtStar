//
//  ShrinkageView.m
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ShrinkageView.h"

@interface ShrinkageView ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) YYLabel *detaialLab;
@property (nonatomic,strong) UIButton *seeWordBtu;

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UILabel *sourceLab;
@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UILabel *nikNameLab;
@property (nonatomic,strong) UIButton *foucsBtu;
@property (nonatomic,strong) UILabel *commentLab;
@property (nonatomic,strong) UIView *lowLine;


@end


@implementation ShrinkageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _titleLab = [UILabel new];
    _detaialLab = [YYLabel new];
    _seeWordBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _backView = [UIView new];
    _sourceLab = [UILabel new];
    _topLine = [UIView new];
    _headerImage = [UIImageView new];
    _nikNameLab = [UILabel new];
    _foucsBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentLab = [UILabel new];
    _lowLine = [UIView new];
    
    [self sd_addSubviews:@[_titleLab,_detaialLab,_seeWordBtu,_backView]];
    
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYBFont(17);
    _titleLab.text = @"张爱玲经典语录";
    _titleLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 20).rightSpaceToView(self, 15).heightIs(20);
    
    _detaialLab.textColor = Color_333333;
    _detaialLab.font = SYFont(15);
    _detaialLab.numberOfLines = 0;
    _detaialLab.attributedText = [self returnNSMutableAttributedStringWithString:@"可编辑的文本+图片有的app需要编辑文章功能用这个就个可以大体实现了，图片和文本都已经获取到了到时后对应传到服务器，之前没用YYTextview也实现过这种功能，效果比较差，用这个实现，相当完美，必须给yytext中作者点个赞"];
    _detaialLab.sd_layout.leftEqualToView(_titleLab).rightSpaceToView(self, 45).topSpaceToView(_titleLab, 20).heightIs(20);
    
    [_seeWordBtu setImage:Image(@"report dropdown") forState:UIControlStateNormal];
    [_seeWordBtu addTarget:self action:@selector(upTextLabel:) forControlEvents:UIControlEventTouchUpInside];
    _seeWordBtu.sd_layout.rightSpaceToView(self, 15).centerYEqualToView(_detaialLab).heightIs(15).widthIs(30);
    
    _backView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_detaialLab, 0).rightSpaceToView(self, 0).heightIs(209);
    
    [_backView sd_addSubviews:@[_sourceLab,_topLine,_headerImage,_nikNameLab,_foucsBtu,_commentLab,_lowLine]];
    
    _sourceLab.textColor = Color_333333;
    _sourceLab.text = @"来源";
    _sourceLab.font = SYFont(13);
    _sourceLab.sd_layout.leftSpaceToView(_backView, 15).rightSpaceToView(_backView, 15).topSpaceToView(_backView, 50).heightIs(15);
    
    _topLine.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _topLine.sd_layout.leftEqualToView(_sourceLab).topSpaceToView(_sourceLab, 10).widthIs(25).heightIs(2);
    
    _headerImage.image = Image(@"3");
    _headerImage.layer.cornerRadius = 17.5;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.sd_layout.leftSpaceToView(_backView, 15).topSpaceToView(_topLine, 20).widthIs(35).heightEqualToWidth();
    
    _nikNameLab.textColor = Color_333333;
    _nikNameLab.text = @"轩哥哥来啦";
    _nikNameLab.font = SYFont(13);
    _nikNameLab.sd_layout.leftSpaceToView(_headerImage, 10).centerYEqualToView(_headerImage).widthIs(150).heightIs(15);
    
    [_foucsBtu setTitle:@"关注" forState:UIControlStateNormal];
    [_foucsBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _foucsBtu.titleLabel.font = SYFont(13);
    _foucsBtu.layer.cornerRadius = 5;
    _foucsBtu.layer.borderColor = Color_333333.CGColor;
    _foucsBtu.layer.borderWidth = 1;
    _foucsBtu.layer.masksToBounds = YES;
    [_foucsBtu addTarget:self action:@selector(foucsAction:) forControlEvents:UIControlEventTouchUpInside];
    _foucsBtu.sd_layout.rightSpaceToView(_backView, 15).topEqualToView(_headerImage).widthIs(50).heightIs(23);
    
    _commentLab.textColor = Color_333333;
    _commentLab.text = @"评论列表(0)";
    _commentLab.font = SYFont(13);
    _commentLab.sd_layout.leftSpaceToView(_backView, 15).topSpaceToView(_headerImage, 50).rightSpaceToView(_backView, 15).heightIs(15);
    
    _lowLine.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _lowLine.sd_layout.leftEqualToView(_commentLab).topSpaceToView(_commentLab, 10).widthIs(55).heightIs(2);
    
}

- (void)foucsAction:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"关注"]) {
        [sender setTitle:@"已关注" forState:UIControlStateNormal];
        sender.layer.borderColor = Color_999999.CGColor;
        [sender setTitleColor:Color_999999 forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"关注" forState:UIControlStateNormal];
        sender.layer.borderColor = Color_333333.CGColor;
        [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    }
}

- (NSMutableAttributedString *)returnNSMutableAttributedStringWithString:(NSString *)text{
    NSMutableAttributedString *attributtedString = [[NSMutableAttributedString alloc]initWithString:text];
    attributtedString.font = SYFont(15);
    UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtu setImage:Image(@"report dropdown") forState:UIControlStateNormal];
    [cancelBtu addTarget:self action:@selector(downTextLabel) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelBtu sizeToFit];
    
    NSMutableAttributedString *btuString = [NSMutableAttributedString  attachmentStringWithContent:cancelBtu contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(20, 5) alignToFont:SYFont(15) alignment:YYTextVerticalAlignmentCenter];
    [attributtedString appendAttributedString:btuString];
    return attributtedString;
}

- (void)downTextLabel{
    _detaialLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_titleLab, 20).rightSpaceToView(self, 45).heightIs(20);
    _seeWordBtu.hidden = NO;
    if (self.changeViewHeight) {
        self.changeViewHeight(289);
    }
}

- (void)upTextLabel:(UIButton *)sender{
    CGFloat height = [[self returnNSMutableAttributedStringWithString:@"可编辑的文本+图片有的app需要编辑文章功能用这个就个可以大体实现了，图片和文本都已经获取到了到时后对应传到服务器，之前没用YYTextview也实现过这种功能，效果比较差，用这个实现，相当完美，必须给yytext中作者点个赞"] boundingRectWithSize:CGSizeMake(ViewWidth(self) - 30, kScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    _detaialLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_titleLab, 20).rightSpaceToView(self, 15).heightIs(height/15*20);
    _seeWordBtu.hidden = YES;
    if (self.changeViewHeight) {
        self.changeViewHeight(height/15*20 + 269);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
