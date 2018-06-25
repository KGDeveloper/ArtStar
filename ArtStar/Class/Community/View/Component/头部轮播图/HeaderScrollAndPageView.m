//
//  HeaderScrollAndPageView.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeaderScrollAndPageView.h"


@interface HeaderScrollAndPageView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollerView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation HeaderScrollAndPageView

- (instancetype)initWithFrame:(CGRect)frame style:(HeaderStyle)style{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI:style];
    }
    return self;
}

- (void)setUI:(HeaderStyle)style{
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewWidth(self)/750*500)];
    _scrollerView.delegate = self;
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.pagingEnabled = YES;
    [self addSubview:_scrollerView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(ViewWidth(self)/3*2, ViewHeight(_scrollerView) + 15, ViewWidth(self)/3, 5)];
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = Color_cccccc;
    _pageControl.currentPageIndicatorTintColor = Color_333333;
    [self addSubview:_pageControl];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, ViewHeight(_scrollerView) + 12.5, ViewWidth(self)/3*2, 15)];
    _titleLab.textColor = Color_333333;
    _titleLab.text = @"张擎达画展于山水美术馆盛大开幕";
    _titleLab.font = SYFont(14);
    _titleLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLab];
    
    if (style == HeaderStyleOther) {
        [self setOtherHeader];
    }
}

- (void)setOtherHeader{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 60, ViewWidth(self),10)];
    backView.backgroundColor = Color_fafafa;
    [self addSubview:backView];
    
    UIView *btuView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 50, ViewWidth(self), 50)];
    btuView.backgroundColor = Color_ededed;
    [self addSubview:btuView];
    
    NSArray *titleArr = @[@"近期热门",@"即将开始",@"即将结束"];
    for (int i = 0; i < 3; i++) {
        [self setButtonWithFrame:CGRectMake(((ViewWidth(self) - 2)/3 + 1)*i, ViewHeight(self) - 50, (ViewWidth(self) - 2)/3, 49) title:titleArr[i] color:Color_999999 tag:105 + i];
    }
}

- (void)setButtonWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color tag:(NSInteger)tag{
    UIButton *titleBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtu.frame = frame;
    titleBtu.backgroundColor = [UIColor whiteColor];
    [titleBtu setTitle:title forState:UIControlStateNormal];
    if (tag == 105) {
        [titleBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    }else{
        [titleBtu setTitleColor:color forState:UIControlStateNormal];
    }
    titleBtu.titleLabel.font = SYFont(15);
    titleBtu.tag = tag;
    [titleBtu addTarget:self action:@selector(titleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:titleBtu];
}

- (void)titleAction:(UIButton *)sender{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *tmp = obj;
            [tmp setTitleColor:Color_999999 forState:UIControlStateNormal];
        }
    }
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    _scrollerView.contentSize = CGSizeMake(ViewWidth(self)*imageArr.count, ViewHeight(_scrollerView));
    _pageControl.numberOfPages = imageArr.count;
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(self)*i, 0, ViewWidth(self), ViewHeight(_scrollerView))];
        imageView.image = Image(imageArr[i]);
        [_scrollerView addSubview:imageView];
    }
}
//MARK:--------------------------------headerView根据scrollview控制pagecontorl---------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/ViewWidth(_scrollerView);
    _pageControl.currentPage = page;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
