//
//  MapAndNaviagtionView.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MapAndNaviagtionView.h"

@interface MapAndNaviagtionView ()

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *placeLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UIButton *mapBtu;
@property (nonatomic,strong) UIView *line;


@end


@implementation MapAndNaviagtionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _topImage = [UIImageView new];
    _titleLab = [UILabel new];
    _timeLab = [UILabel new];
    _placeLab = [UILabel new];
    _locationLab = [UILabel new];
    _priceLab = [UILabel new];
    _mapBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _line = [UIView new];
    
    [self sd_addSubviews:@[_topImage,_titleLab,_timeLab,_placeLab,_locationLab,_priceLab,_mapBtu,_line]];
    
    _topImage.image = Image(@"4");
    _topImage.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(ViewWidth(self)/750*500);
    
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(14);
    _titleLab.text = @"王嘉尔全国演唱会";
    _titleLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_topImage, 15).widthIs(ViewWidth(self) - 180).heightIs(15);
    
    _timeLab.textColor = Color_333333;
    _timeLab.font = SYFont(14);
    _timeLab.text = @"演出时间：2018.05-2018.0612";
    _timeLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_titleLab, 15).widthIs(ViewWidth(self) - 180).heightIs(15);
    
    _placeLab.textColor = Color_333333;
    _placeLab.font = SYFont(14);
    _placeLab.text = @"演出场馆：国家大剧院音乐厅";
    _placeLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_timeLab, 15).widthIs(ViewWidth(self) - 180).heightIs(15);
    
    _locationLab.textColor = Color_333333;
    _locationLab.font = SYFont(14);
    _locationLab.text = @"黄浦区人民大道201号";
    _locationLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_placeLab, 15).widthIs(ViewWidth(self) - 180).heightIs(15);
    
    _priceLab.textColor = [UIColor colorWithHexString:@"#ff6600"];
    _priceLab.font = SYFont(14);
    _priceLab.text = @"￥50-880";
    _priceLab.textAlignment = NSTextAlignmentRight;
    _priceLab.sd_layout.rightSpaceToView(self, 15).topSpaceToView(_topImage, 15).widthIs(150).heightIs(15);
    
    [_mapBtu setImage:Image(@"location") forState:UIControlStateNormal];
    [_mapBtu addTarget:self action:@selector(mapClick) forControlEvents:UIControlEventTouchUpInside];
    _mapBtu.sd_layout.rightSpaceToView(self, 15).centerYEqualToView(_locationLab).widthIs(10).heightIs(15);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(10);
    
}

- (void)mapClick{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
