//
//  MyselfCenterHeaderView.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfCenterHeaderView.h"

@interface MyselfCenterHeaderView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIButton *messageBtu;
@property (nonatomic,strong) UIButton *addBtu;
@property (nonatomic,strong) UIButton *wordBtu;

@end

@implementation MyselfCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ViewWidth(self)*3, ViewHeight(self));
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(ViewWidth(self) - 100, ViewHeight(self) - 15, 75, 5)];
    _pageControl.numberOfPages = 3;
    _pageControl.pageIndicatorTintColor = Color_999999;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    _messageBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _messageBtu.frame = CGRectMake(100, ViewHeight(self) - 150, 50, 50);
    [_messageBtu setImage:Image(@"打招呼") forState:UIControlStateNormal];
    [_messageBtu addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:_messageBtu atIndex:99];
    
    _addBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtu.frame = CGRectMake(ViewWidth(self) - 150, ViewHeight(self) - 150, 50, 50);
    [_addBtu setImage:Image(@"加好友") forState:UIControlStateNormal];
    [_addBtu addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:_addBtu atIndex:99];
    
    UIButton *returnBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtu.frame = CGRectMake(15, NavTopHeight - 24, 20, 20);
    [returnBtu setImage:Image(@"backwhite") forState:UIControlStateNormal];
    [returnBtu addTarget:self action:@selector(returnBtuAction) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:returnBtu atIndex:99];
    
    _wordBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _wordBtu.frame = CGRectMake(ViewWidth(self) - 75, NavTopHeight - 24, 60, 30);
    [_wordBtu setTitle:@"家园" forState:UIControlStateNormal];
    _wordBtu.titleLabel.font = SYFont(15);
    [_wordBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _wordBtu.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [_wordBtu addTarget:self action:@selector(wordBtuAction) forControlEvents:UIControlEventTouchUpInside];
    _wordBtu.layer.cornerRadius = 5;
    _wordBtu.layer.masksToBounds = YES;
    [self insertSubview:_wordBtu atIndex:99];
}
- (void)setRightName:(NSString *)rightName{
    _rightName = rightName;
    [_wordBtu setTitle:rightName forState:UIControlStateNormal];
}
- (void)wordBtuAction{
    if (self.pushViewController) {
        self.pushViewController(_rightName);
    }
}
- (void)returnBtuAction{
    if (self.pushViewController) {
        self.pushViewController(@"返回");
    }
}
- (void)messageAction{
    
}
- (void)addAction{
    
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    for (int i = 0; i < 3; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(self)*i, 0, ViewWidth(self), ViewHeight(self))];
        [image sd_setImageWithURL:[NSURL URLWithString:dataArr[i]]];
        [_scrollView addSubview:image];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = scrollView.contentOffset.x/ViewWidth(self);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
