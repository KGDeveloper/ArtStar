//
//  MusicPerformanceCell.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicPerformanceCell.h"

@interface MusicPerformanceCell ()

@property (nonatomic,strong) UIView *line;

@end


@implementation MusicPerformanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setCell];
    }
    return self;
}

- (void)setCell{
    
    _topImage = [UIImageView new];
    _hotBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _backView = [UIView new];
    _timeLab = [UILabel new];
    _titleLab = [UILabel new];
    _locationLab = [UILabel new];
    _priceLab = [UILabel new];
    _buyBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _line = [UIView new];
    
    [self.contentView sd_addSubviews:@[_topImage,_hotBtu,_backView,_timeLab,_titleLab,_locationLab,_priceLab,_buyBtu,_line]];
    
    [_topImage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527502577856&di=209c93d7d77638028780be4b6e74a6c6&imgtype=0&src=http%3A%2F%2Fs11.sinaimg.cn%2Fmw690%2F003sDG3Lzy7dA9cZsrE5a%26690"]];
    _topImage.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 15).heightIs((ViewWidth(self)-30)/690*400);
    
    [_hotBtu setTitle:@"专家推荐" forState:UIControlStateNormal];
    [_hotBtu setTitleColor:[UIColor colorWithHexString:@"#ff0000"] forState:UIControlStateNormal];
    _hotBtu.titleLabel.font = SYFont(10);
    _hotBtu.layer.cornerRadius = 3;
    _hotBtu.layer.borderColor = [UIColor colorWithHexString:@"#ff0000"].CGColor;
    _hotBtu.layer.borderWidth = 1;
    _hotBtu.layer.masksToBounds = YES;
    [_hotBtu addTarget:self action:@selector(hotAction) forControlEvents:UIControlEventTouchUpInside];
    _hotBtu.sd_layout.rightSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 25).widthIs(50).heightIs(15);
    
    _backView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _backView.alpha = 0.4;
    _backView.sd_layout.rightEqualToView(_topImage).bottomEqualToView(_topImage).leftEqualToView(_topImage).heightIs(25);
    
    _timeLab.text = @"两天后结束";
    _timeLab.textColor = [UIColor whiteColor];
    _timeLab.font = SYFont(12);
    _timeLab.textAlignment = NSTextAlignmentRight;
    _timeLab.sd_layout.rightEqualToView(_topImage).bottomEqualToView(_topImage).leftEqualToView(_topImage).heightIs(25);
    
    _titleLab.text = @"张云逸“回归自然”雕塑设计展";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(13);
    _titleLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_topImage, 15).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _locationLab.text = @"北京市东城区潍坊北路15号";
    _locationLab.textColor = Color_333333;
    _locationLab.font = SYFont(13);
    _locationLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_titleLab, 15).rightSpaceToView(self.contentView, 15).heightIs(15);
    
    _priceLab.text = @"$68-238";
    _priceLab.textColor = [UIColor colorWithHexString:@"#ff6600"];
    _priceLab.font = SYFont(13);
    _priceLab.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_locationLab, 15).widthIs(150).heightIs(15);
    
    [_buyBtu setTitle:@"立即购票" forState:UIControlStateNormal];
    [_buyBtu setTitleColor:[UIColor colorWithHexString:@"#ff6600"] forState:UIControlStateNormal];
    _buyBtu.titleLabel.font = SYFont(13);
    _buyBtu.layer.cornerRadius = 3;
    _buyBtu.layer.borderColor = [UIColor colorWithHexString:@"#ff6600"].CGColor;
    _buyBtu.layer.borderWidth = 1;
    _buyBtu.layer.masksToBounds = YES;
    [_buyBtu addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    _buyBtu.sd_layout.rightSpaceToView(self.contentView, 15).centerYEqualToView(_priceLab).widthIs(70).heightIs(23);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).heightIs(10);
    
}

- (void)willEndStatus{
    _buyBtu.hidden = NO;
    _priceLab.hidden = NO;
    [_buyBtu setTitle:@"立即购票" forState:UIControlStateNormal];
}
- (void)willStarStatus{
    _buyBtu.hidden = NO;
    _priceLab.hidden = NO;
    [_buyBtu setTitle:@"立即预定" forState:UIControlStateNormal];
}
- (void)normalStatus{
    _buyBtu.hidden = YES;
    _priceLab.hidden = YES;
}
- (void)hotAction{
    
}

- (void)buyAction{
    
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
