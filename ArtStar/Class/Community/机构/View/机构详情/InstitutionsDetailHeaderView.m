//
//  InstitutionsDetailHeaderView.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "InstitutionsDetailHeaderView.h"
#import "MusicDetaialBtu.h"

@interface InstitutionsDetailHeaderView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) MusicDetaialBtu *threeDTouchBtu;
@property (nonatomic,strong) MusicDetaialBtu *aRTouchBtu;
@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;

@end

@implementation InstitutionsDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setScrollViewAndPageCortol];
    }
    return self;
}

- (void)setScrollViewAndPageCortol{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 20, ViewWidth(self), 5)];
    _pageControl.currentPageIndicatorTintColor = Color_999999;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    _threeDTouchBtu = [[MusicDetaialBtu alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 20, ViewHeight(self)/2 - 28, 40, 56)];
    _threeDTouchBtu.btuTitle = @"3D展示";
    _threeDTouchBtu.btuImage = @"3d";
    _threeDTouchBtu.actionClick = ^{
        NSLog(@"这是3D展示");
    };
    [self addSubview:_threeDTouchBtu];
    
    _aRTouchBtu = [[MusicDetaialBtu alloc]initWithFrame:CGRectMake(15, ViewHeight(self) - 70, 40, 56)];
    _aRTouchBtu.btuTitle = @"AR展示";
    _aRTouchBtu.btuImage = @"AR";
    _aRTouchBtu.actionClick = ^{
        NSLog(@"这是AR展示");
    };
    [self addSubview:_aRTouchBtu];
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(15, 10, 200, 30);
    [_leftBtu setImage:Image(@"backwhite") forState:UIControlStateNormal];
    [_leftBtu setTitle:@"雅马哈琴行" forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(15);
    [_leftBtu setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    _leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_leftBtu addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(ViewWidth(self) - 45, 10, 30, 30);
    [_rightBtu setImage:Image(@"navbar share white") forState:UIControlStateNormal];
    _rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_rightBtu addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtu];
}

- (void)leftAction{
    [[self rootViewCintroller].navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [_leftBtu setTitle:title forState:UIControlStateNormal];
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    
    _pageControl.numberOfPages = imageArr.count;
    _scrollView.contentSize = CGSizeMake(ViewWidth(self) * imageArr.count, ViewHeight(self));
    
    for (int i = 0; i < imageArr.count; i++) {
        NSDictionary *dic = imageArr[i];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(self)*i, 0, ViewWidth(self), ViewHeight(self))];
        [image sd_setImageWithURL:[NSURL URLWithString:dic[@"imageURL"]]];
        [_scrollView addSubview:image];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/ViewWidth(self);
}

- (UIViewController *)rootViewCintroller{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
