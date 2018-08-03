//
//  HotMoviesDetailHeaderView.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesDetailHeaderView.h"

@interface HotMoviesDetailHeaderView ()

@property (nonatomic,strong) UIImageView *lowImage;
@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *englishNameLab;
@property (nonatomic,strong) UIView *starView;
@property (nonatomic,strong) UILabel *soureLab;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *countryLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UIButton *buyBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *backView;

@end

@implementation HotMoviesDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    
    _lowImage = [UIImageView new];
    _topImage = [UIImageView new];
    _nameLab = [UILabel new];
    _englishNameLab = [UILabel new];
    _starView = [UIView new];
    _soureLab = [UILabel new];
    _titleLab = [UILabel new];
    _countryLab = [UILabel new];
    _timeLab = [UILabel new];
    _buyBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _line = [UIView new];
    _backView = [UIView new];
    
    [self sd_addSubviews:@[_lowImage,_backView,_topImage,_nameLab,_englishNameLab,_starView,_soureLab,_titleLab,_countryLab,_timeLab,_buyBtu,_line]];
    
    [_lowImage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527669687778&di=335781bc379bd382f19d0344a595b982&imgtype=0&src=http%3A%2F%2Fwww.sxcq.cn%2Fuploads%2Fallimg%2F151104%2F235_151104101412_1.png"]];
    _lowImage.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(ViewWidth(self)/375*165);
    
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.4;
    _backView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(ViewWidth(self)/375*165);
    
    [_topImage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527669981984&di=ef78ba391a6792eec1699409a37b239c&imgtype=0&src=http%3A%2F%2Fshopimg.kongfz.com.cn%2F20061120%2F523%2F1164020671_n.jpg"]];
    _topImage.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 15).widthIs(100).heightIs(135);
    
    _nameLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _nameLab.text = @"后来的我们";
    _nameLab.font = SYFont(14);
    _nameLab.sd_layout.leftSpaceToView(_topImage, 10).topSpaceToView(self, 25).rightSpaceToView(self, 15).heightIs(15);
    
    _englishNameLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _englishNameLab.text = @"Us and Them";
    _englishNameLab.font = SYFont(12);
    _englishNameLab.sd_layout.leftSpaceToView(_topImage, 10).topSpaceToView(_nameLab,5).rightSpaceToView(self, 15).heightIs(15);
    
    _starView.sd_layout.leftSpaceToView(_topImage, 10).topSpaceToView(_englishNameLab, 5).widthIs(85).heightIs(15);
    
    for (int i = 0; i < 5; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 1, 12, 12)];
        if (i == 4) {
            image.image = Image(@"yellowstay");
        }else{
            image.image = Image(@"star");
        }
        [_starView addSubview:image];
    }
    
    _soureLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _soureLab.text = @"8.1";
    _soureLab.font = SYFont(12);
    _soureLab.sd_layout.leftSpaceToView(_starView, 0).topSpaceToView(_englishNameLab, 5).rightSpaceToView(self, 15).heightIs(15);
    
    _titleLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _titleLab.text = @"动作，科幻，冒险";
    _titleLab.font = SYFont(12);
    _titleLab.sd_layout.leftSpaceToView(_topImage, 10).topSpaceToView(_starView, 5).rightSpaceToView(self, 15).heightIs(15);
    
    _countryLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _countryLab.text = @"美国/150分钟";
    _countryLab.font = SYFont(12);
    _countryLab.sd_layout.leftSpaceToView(_topImage, 10).topSpaceToView(_titleLab, 5).rightSpaceToView(self, 15).heightIs(15);
    
    _timeLab.textColor = [UIColor colorWithHexString:@"#ffffff"];
    _timeLab.text = @"2018-05-11 大陆上映";
    _timeLab.font = SYFont(12);
    _timeLab.sd_layout.leftSpaceToView(_topImage, 10).topSpaceToView(_countryLab, 5).rightSpaceToView(self, 15).heightIs(15);
    
    [_buyBtu setTitle:@"特惠购买" forState:UIControlStateNormal];
    [_buyBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _buyBtu.backgroundColor = Color_333333;
    _buyBtu.layer.cornerRadius = 5;
    _buyBtu.layer.masksToBounds = YES;
    [_buyBtu addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    _buyBtu.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_lowImage, 10).rightSpaceToView(self, 15).heightIs(30);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_buyBtu, 10).rightSpaceToView(self, 0).heightIs(10);
}

- (void)buyAction{
    
}









/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
