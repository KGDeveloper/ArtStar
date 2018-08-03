//
//  HotMoviesView.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesView.h"

@interface HotMoviesView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *loadOtherBtu;
@property (nonatomic,strong) UIScrollView *moviesScroll;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation HotMoviesView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setView];
    }
    return self;
}

- (void)setView{
    _titleLab = [UILabel new];
    _loadOtherBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _moviesScroll = [UIScrollView new];
    _imageView = [UIImageView new];
    
    [self sd_addSubviews:@[_titleLab,_loadOtherBtu,_moviesScroll,_imageView]];
    
    _titleLab.textColor = Color_333333;
    _titleLab.text = @"热门影片";
    _titleLab.font = SYFont(14);
    _titleLab.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, 15).widthIs(100).heightIs(15);
    
    [_loadOtherBtu setTitle:@"查看更多" forState:UIControlStateNormal];
    [_loadOtherBtu setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    _loadOtherBtu.titleLabel.font = SYFont(12);
    [_loadOtherBtu setTitleEdgeInsets:UIEdgeInsetsMake(0, -_loadOtherBtu.bounds.size.width, 0, _loadOtherBtu.imageView.size.width)];
    [_loadOtherBtu addTarget:self action:@selector(loadAction) forControlEvents:UIControlEventTouchUpInside];
    _loadOtherBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _loadOtherBtu.sd_layout.rightSpaceToView(self, 27).centerYEqualToView(_titleLab).widthIs(150).heightIs(15);
    
    _imageView.image = Image(@"open");
    _imageView.sd_layout.rightSpaceToView(self, 15).centerYEqualToView(_loadOtherBtu).widthIs(8).heightIs(15);
    
    _moviesScroll.delegate = self;
    _moviesScroll.showsHorizontalScrollIndicator = NO;
    _moviesScroll.sd_layout.leftSpaceToView(self,15).rightSpaceToView(self, 15).topSpaceToView(_titleLab, 15).heightIs(120);
    
}

- (void)setMoviesArr:(NSArray *)moviesArr{
    _moviesArr = moviesArr;
    _moviesScroll.contentSize = CGSizeMake(85*moviesArr.count, 120);
    for (int i = 0; i < moviesArr.count; i++) {
        NSDictionary *dict = moviesArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(85*i, 0, 70, 80)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"image"]]];
        [_moviesScroll addSubview:imageView];
        
        UILabel *nameLabe = [[UILabel alloc]initWithFrame:CGRectMake(85*i, 90, 70, 15)];
        nameLabe.text = dict[@"name"];
        nameLabe.textColor = Color_333333;
        nameLabe.font = SYFont(12);
        nameLabe.textAlignment = NSTextAlignmentCenter;
        [_moviesScroll addSubview:nameLabe];
    }
}

- (void)loadAction{
    if (self.pushViewController) {
        self.pushViewController();
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
