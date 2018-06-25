//
//  MyselfIdentificationView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfIdentificationView.h"

@interface MyselfIdentificationView ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *openBtu;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *line;

@end

@implementation MyselfIdentificationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setView];
    }
    return self;
}

- (void)setView{
    
    _titleLab = [UILabel new];
    _openBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _backView = [UIView new];
    _line = [UIView new];
    
    [self sd_addSubviews:@[_titleLab,_openBtu,_backView,_line]];
    
    _titleLab.text = @"身份标识";
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(15);
    _titleLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 17.5).widthIs(70).heightIs(15);
    
    [_openBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_openBtu setTitle:@"展开" forState:UIControlStateNormal];
    _openBtu.titleLabel.font = SYFont(12);
    [_openBtu setImage:Image(@"dropdown") forState:UIControlStateNormal];
    _openBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _openBtu.titleEdgeInsets = UIEdgeInsetsMake(0, -_openBtu.imageView.size.width - 20, 0, _openBtu.imageView.size.width + 20);
    _openBtu.imageEdgeInsets = UIEdgeInsetsMake(0,_openBtu.titleLabel.size.width + 10, 0,-_openBtu.titleLabel.size.width - 10);
    [_openBtu addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
    _openBtu.sd_layout.rightSpaceToView(self, 15).topSpaceToView(self, 15).widthIs(70).heightIs(20);
    
    _backView.sd_layout.rightSpaceToView(self,85).centerYEqualToView(_titleLab).heightIs(15).widthIs(30);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0).heightIs(10);
    
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    _backView.sd_layout.rightSpaceToView(self,85).centerYEqualToView(_titleLab).heightIs(15).widthIs(30*imageArr.count);
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(_backView.bounds.size.width - 15 - 30*i, 0, 15, 15)];
        image.image = Image(imageArr[i]);
        [_backView addSubview:image];
    }
    [self setNeedsLayout];
}

- (void)openAction:(UIButton *)sender{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
