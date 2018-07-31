//
//  FriendsDetailCommentCell.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDetailCommentCell.h"

@interface FriendsDetailCommentCell ()

@property (nonatomic,strong) UIImageView *commnetImage;
@property (nonatomic,strong) UIView *line;

@end

@implementation FriendsDetailCommentCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 15;
    frame.size.width -= 30;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_fafafa;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _commnetImage = [UIImageView new];
    _headerImage = [UIImageView new];
    _nikName = [UILabel new];
    _timeLab = [UILabel new];
    _commentLab = [YYLabel new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_commnetImage,_headerImage,_nikName,_timeLab,_commentLab,_line]];
    
    _commnetImage.image = Image(@"评论");
    _commnetImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 22.5).widthIs(10).heightIs(10);
    
    _headerImage.image = Image(@"1");
    _headerImage.layer.cornerRadius = 15;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.sd_layout.leftSpaceToView(self.contentView, 40).topSpaceToView(self.contentView, 12.5).widthIs(30).heightIs(30);
    
    _nikName.textColor = Color_999999;
    _nikName.font = SYFont(13);
    _nikName.text = @"小丑";
    _nikName.textAlignment = NSTextAlignmentLeft;
    _nikName.sd_layout.leftSpaceToView(_headerImage, 10).topSpaceToView(self.contentView, 10).widthIs(150).heightIs(15);
    
    _timeLab.textColor = Color_999999;
    _timeLab.font = SYFont(10);
    _timeLab.text = @"2月11日 16：39";
    _timeLab.textAlignment = NSTextAlignmentRight;
    _timeLab.sd_layout.rightSpaceToView(self.contentView, 30).topSpaceToView(self.contentView, 10).widthIs(150).heightIs(15);
    
    _commentLab.textColor = Color_999999;
    _commentLab.font = SYFont(10);
    _commentLab.textAlignment = NSTextAlignmentLeft;
    _commentLab.numberOfLines = 0;
    _commentLab.sd_layout.leftEqualToView(_nikName).bottomSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 30).heightIs(15);
    
    
    _line.backgroundColor = Color_ededed;
    _line.sd_layout.leftSpaceToView(self.contentView, 40).bottomSpaceToView(self.contentView,1).rightSpaceToView(self.contentView, 30).heightIs(1);
    
}

- (void)setIsShowCommentBtu:(BOOL)isShowCommentBtu{
    _isShowCommentBtu = isShowCommentBtu;
    if (isShowCommentBtu == YES) {
        _commnetImage.hidden = YES;
    }else{
        _commnetImage.hidden = NO;
    }
}

- (void)valuenikName:(NSString *)nikName comment:(NSString *)commnet{
    [self changeLabelTextstarStr:@"回复" nikName:nikName comment:commnet];
}

- (void)changeLabelTextstarStr:(NSString *)starStr nikName:(NSString *)nikName comment:(NSString *)comment{
    NSString *str = [[starStr stringByAppendingString:nikName] stringByAppendingString:comment];
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc]initWithString:str];

    [resultStr setFont:SYFont(12) range:NSMakeRange(0, starStr.length)];
    
    [resultStr setFont:SYFont(13) range:NSMakeRange(starStr.length,nikName.length)];
    
    [resultStr setFont:SYFont(13) range:NSMakeRange(nikName.length + starStr.length,comment.length)];
    
    [resultStr setColor:Color_999999 range:NSMakeRange(0, starStr.length)];
    
    [resultStr setColor:Color_333333 range:NSMakeRange(starStr.length,nikName.length)];
    
    [resultStr setColor:Color_999999 range:NSMakeRange(nikName.length + starStr.length,comment.length)];

    _commentLab.attributedText = resultStr;
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
