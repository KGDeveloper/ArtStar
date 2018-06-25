//
//  MySelfWordHomeTableViewHeaderView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MySelfWordHomeTableViewHeaderView.h"

@interface MySelfWordHomeTableViewHeaderView ()

@property (nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong) UIImageView *logoImage;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIButton *locationBtu;
@property (nonatomic,strong) UIButton *addBtu;
@property (nonatomic,strong) UIButton *msgBtu;
@property (nonatomic,strong) UILabel *fansLab;
@property (nonatomic,strong) UIView *line;

@end

@implementation MySelfWordHomeTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setView];
    }
    return self;
}

- (void)setView{
    _headerImage = [UIImageView new];
    _logoImage = [UIImageView new];
    _nameLab = [UILabel new];
    _locationBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _msgBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _fansLab = [UILabel new];
    _line = [UIView new];
    
    [self sd_addSubviews:@[_headerImage,_logoImage,_nameLab,_locationBtu,_addBtu,_msgBtu,_fansLab,_line]];
    
    _headerImage.layer.cornerRadius = 40;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.sd_layout.topSpaceToView(self, 30).centerXEqualToView(self).widthIs(80).heightIs(80);
    
    _logoImage.image = Image(@"authentication");
    _logoImage.sd_layout.centerXIs(self.centerX + 20).bottomEqualToView(_headerImage).widthIs(15).heightIs(15);
    
    _nameLab.text = @"姚新月";
    _nameLab.textColor = Color_333333;
    _nameLab.font = SYFont(15);
    _nameLab.textAlignment = NSTextAlignmentCenter;
    _nameLab.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_headerImage, 10).rightSpaceToView(self, 0).heightIs(15);
    
    [_locationBtu setTitle:@"北京市" forState:UIControlStateNormal];
    [_locationBtu setImage:Image(@"locationn") forState:UIControlStateNormal];
    [_locationBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _locationBtu.titleLabel.font = SYFont(12);
    _locationBtu.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    _locationBtu.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(_nameLab, 10).heightIs(15);
    
    [_addBtu setImage:Image(@"add") forState:UIControlStateNormal];
    _addBtu.layer.cornerRadius = 5;
    _addBtu.layer.borderWidth = 1;
    _addBtu.layer.borderColor = Color_ededed.CGColor;
    [_addBtu addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    _addBtu.sd_layout.centerXIs(self.centerX - 30).topSpaceToView(_locationBtu, 15).widthIs(50).heightIs(30);
    
    [_msgBtu setImage:Image(@"message") forState:UIControlStateNormal];
    _msgBtu.layer.cornerRadius = 5;
    _msgBtu.layer.borderWidth = 1;
    _msgBtu.layer.borderColor = Color_ededed.CGColor;
    [_msgBtu addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
    _msgBtu.sd_layout.centerXIs(self.centerX + 30).topSpaceToView(_locationBtu, 15).widthIs(50).heightIs(30);
    
    _fansLab.textColor = Color_333333;
    _fansLab.text = @"35件作品/1002位圈内人关注";
    _fansLab.font = SYFont(15);
    _fansLab.textAlignment = NSTextAlignmentCenter;
    _fansLab.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_addBtu, 20).rightSpaceToView(self, 0).heightIs(15);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_fansLab, 30).rightSpaceToView(self, 0).heightIs(10);
    
}

- (void)setHeaderStr:(NSString *)headerStr{
    _headerStr = headerStr;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:headerStr]];
}

- (void)addAction{
    
}

- (void)msgAction{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
