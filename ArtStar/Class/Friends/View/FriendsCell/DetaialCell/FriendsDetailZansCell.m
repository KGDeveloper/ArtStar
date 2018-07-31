//
//  FriendsDetailZansCell.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDetailZansCell.h"
#import "FriendsTalentsCommentModel.h"

@interface FriendsDetailZansCell ()

@property (nonatomic,strong) UIScrollView *headerImageScroll;
@property (nonatomic,strong) UIImageView *zansImage;
@property (nonatomic,strong) UIView *line;

@end

@implementation FriendsDetailZansCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 15;
    frame.size.width -= 30;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = Color_fafafa;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _headerImageScroll = [UIScrollView new];
    _zansImage = [UIImageView new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_headerImageScroll,_zansImage,_line]];
    
    _zansImage.image = Image(@"点赞");
    _zansImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20).widthIs(10).heightIs(10);
    
    _headerImageScroll.pagingEnabled = NO;
    _headerImageScroll.showsVerticalScrollIndicator = NO;
    _headerImageScroll.showsHorizontalScrollIndicator = NO;
    _headerImageScroll.sd_layout.leftSpaceToView(_zansImage, 15).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 30).heightIs(30);
    
    _line.backgroundColor = Color_ededed;
    _line.sd_layout.leftSpaceToView(self.contentView, 40).topSpaceToView(_headerImageScroll,9).rightSpaceToView(self.contentView, 30).heightIs(1);
    
}

- (void)setZansArr:(NSArray *)zansArr{
    _zansArr = zansArr;
    
    _headerImageScroll.contentSize = CGSizeMake(30*zansArr.count + (zansArr.count - 1)*15, 30);
    for (int i = 0; i < zansArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30*i + 15*i, 0, 30, 30)];
        NSDictionary *dic = zansArr[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        imageView.layer.cornerRadius = 15;
        imageView.layer.masksToBounds = YES;
        [_headerImageScroll addSubview:imageView];
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
