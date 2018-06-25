//
//  ReadIngRecommendView.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ReadIngRecommendView.h"

@interface ReadIngRecommendView ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *allLoadBtu;
@property (nonatomic,strong) UIScrollView *booksView;
@property (nonatomic,strong) UIView *line;

@end


@implementation ReadIngRecommendView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setRecommendView];
    }
    return self;
}

- (void)setRecommendView{
    
    _titleLab = [UILabel new];
    _allLoadBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _booksView = [UIScrollView new];
    _line = [UIView new];
    
    [self sd_addSubviews:@[_titleLab,_allLoadBtu,_booksView,_line]];
    
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(14);
    _titleLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 20).widthIs(150).heightIs(15);
    
    [_allLoadBtu setTitle:@"查看全部" forState:UIControlStateNormal];
    [_allLoadBtu setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [_allLoadBtu setImage:Image(@"open") forState:UIControlStateNormal];
    _allLoadBtu.titleLabel.font = SYFont(12);
    _allLoadBtu.titleEdgeInsets = UIEdgeInsetsMake(0, -_allLoadBtu.imageView.size.width - 10, 0,_allLoadBtu.imageView.size.width + 10);
    _allLoadBtu.imageEdgeInsets = UIEdgeInsetsMake(0, _allLoadBtu.titleLabel.size.width + 40, 0, -_allLoadBtu.titleLabel.size.width - 40);
    [_allLoadBtu addTarget:self action:@selector(allLoadAction) forControlEvents:UIControlEventTouchUpInside];
    _allLoadBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _allLoadBtu.sd_layout.rightSpaceToView(self, 15).centerYEqualToView(_titleLab).widthIs(70).heightIs(20);
    
    _booksView.showsHorizontalScrollIndicator = NO;
    _booksView.sd_layout.leftSpaceToView(self, 15).topSpaceToView(_titleLab, 15).rightSpaceToView(self, 15).heightIs(165);
    
    _line.backgroundColor = Color_fafafa;
    _line.sd_layout.leftSpaceToView(self, 0).topSpaceToView(_booksView, 20).rightSpaceToView(self, 0).heightIs(10);
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}

- (void)setBookArr:(NSArray *)bookArr{
    _bookArr = bookArr;
    _booksView.contentSize = CGSizeMake(((ViewWidth(self) - 330)/2 + 100)*bookArr.count, 165);
    for (int i = 0; i < bookArr.count; i++) {
        NSDictionary *dic = bookArr[i];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(((ViewWidth(self) - 330)/2 + 100)*i, 0, 100, 140)];
        [image sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
        [_booksView addSubview:image];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(((ViewWidth(self) - 330)/2 + 100)*i, 150, 100, 15)];
        nameLab.textColor = [UIColor colorWithHexString:@"#666666"];
        nameLab.font = SYFont(13);
        nameLab.text = dic[@"name"];
        nameLab.textAlignment = NSTextAlignmentCenter;
        [_booksView addSubview:nameLab];
    }
}

- (void)allLoadAction{
    if (self.pushReadBooskHotVC) {
        self.pushReadBooskHotVC();
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
