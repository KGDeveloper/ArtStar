//
//  ActivityTableViewCell.m
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ActivityTableViewCell.h"

@interface ActivityTableViewCell ()

@property (nonatomic,strong) UIImageView *bookImage;
@property (nonatomic,strong) UILabel *bookNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UIButton *ticketBtu;
@property (nonatomic,strong) UIView *line;

@end

@implementation ActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _bookImage = [UIImageView new];
    _bookNameLab = [UILabel new];
    _timeLab = [UILabel new];
    _locationLab = [UILabel new];
    _priceLab = [UILabel new];
    _ticketBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_bookImage,_bookNameLab,_timeLab,_locationLab,_priceLab,_ticketBtu,_line]];
    
    _bookImage.image = Image(@"图片加载失败");
    _bookImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 15).widthIs(100).heightIs(140);
    
    _bookNameLab.text = @"这是轩哥哥";
    _bookNameLab.textColor = Color_333333;
    _bookNameLab.font = SYFont(14);
    _bookNameLab.sd_layout.leftSpaceToView(_bookImage, 15).topSpaceToView(self.contentView, 25).rightSpaceToView(self.contentView, 15).heightIs(20);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
    _priceLab.textColor = [UIColor colorWithHexString:@"#ff6600"];
    _priceLab.text = @"💰68-238";
    _priceLab.font = SYFont(14);
    _priceLab.sd_layout.leftEqualToView(_bookNameLab).bottomSpaceToView(_line, 25).widthIs(100).heightIs(15);
    
    [_ticketBtu setTitle:@"立即预定" forState:UIControlStateNormal];
    [_ticketBtu setTitleColor:[UIColor colorWithHexString:@"#ff6600"] forState:UIControlStateNormal];
    _ticketBtu.titleLabel.font = SYFont(13);
    _ticketBtu.layer.cornerRadius = 5;
    _ticketBtu.layer.borderColor = [UIColor colorWithHexString:@"#ff6600"].CGColor;
    _ticketBtu.layer.borderWidth = 1;
    _ticketBtu.layer.masksToBounds = YES;
    [_ticketBtu addTarget:self action:@selector(ticketAction:) forControlEvents:UIControlEventTouchUpInside];
    _ticketBtu.sd_layout.rightSpaceToView(self.contentView, 15).bottomEqualToView(_bookImage).widthIs(70).heightIs(23);
    
    _locationLab.textColor = Color_999999;
    _locationLab.text = @"国家大剧院";
    _locationLab.font = SYFont(13);
    _locationLab.sd_layout.leftEqualToView(_bookNameLab).rightSpaceToView(self.contentView, 15).bottomSpaceToView(_priceLab,15).heightIs(15);
    
    _timeLab.textColor = Color_999999;
    _timeLab.text = @"2018-05-08 至 2018-05-15";
    _timeLab.font = SYFont(13);
    _timeLab.sd_layout.leftEqualToView(_bookNameLab).rightSpaceToView(self.contentView, 15).bottomSpaceToView(_locationLab,15).heightIs(15);
}

- (void)ticketAction:(UIButton *)sender{
    
}
//:--可以预定--
- (void)canBeScheduled{
    _ticketBtu.hidden = NO;
    _priceLab.hidden = NO;
    _priceLab.textColor = [UIColor colorWithHexString:@"#ff6600"];
}
//:--免费观看--
- (void)freeVisit{
    _ticketBtu.hidden = YES;
    _priceLab.hidden = NO;
    _priceLab.text = @"免费参观";
    _priceLab.textColor = Color_333333;
}
//:--没有价格，没有开始--
- (void)normal{
    _ticketBtu.hidden = YES;
    _priceLab.hidden = YES;
    _locationLab.sd_layout.leftEqualToView(_bookNameLab).rightSpaceToView(self.contentView, 15).bottomSpaceToView(_line,15).heightIs(15);
    _timeLab.sd_layout.leftEqualToView(_bookNameLab).rightSpaceToView(self.contentView, 15).bottomSpaceToView(_locationLab,15).heightIs(15);
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
