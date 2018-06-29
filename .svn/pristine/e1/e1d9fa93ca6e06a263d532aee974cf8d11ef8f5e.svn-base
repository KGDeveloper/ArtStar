//
//  HeadLineImageNewsTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "HeadLineImageNewsTableViewCell.h"

@interface HeadLineImageNewsTableViewCell ()


@property (nonatomic,strong) UIView *line;

@end

@implementation HeadLineImageNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _myImage = [UIImageView new];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_myImage,_line]];
    
    _myImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 30).rightSpaceToView(self.contentView, 15).heightIs(self.contentView.size.height);
    
    _line.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(10);
    
    [self setupAutoHeightWithBottomView:_line bottomMargin:0];
    
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
