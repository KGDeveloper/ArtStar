//
//  FriendsDetailScrollView.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDetailScrollView.h"

@interface FriendsDetailScrollView ()<UIScrollViewDelegate>{
    NSInteger number;
}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *countView;
@property (nonatomic,strong) UILabel *countLab;

@end

@implementation FriendsDetailScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        number = 1;
        [self setUI];
        
    }
    return self;
}

- (void)setUI{
    
    _scrollView = [UIScrollView new];
    _countView = [UIView new];
    _countLab = [UILabel new];
    
    [self sd_addSubviews:@[_scrollView,_countView,_countLab]];
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    
    _countView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _countView.alpha = 0.4;
    _countView.sd_layout.rightEqualToView(_scrollView).bottomEqualToView(_scrollView).widthIs(27).heightIs(14);
    
    _countLab.textAlignment = NSTextAlignmentCenter;
    _countLab.textColor = [UIColor whiteColor];
    _countLab.font = FZFont(11);
    _countLab.text = @"1/9";
    _countLab.sd_layout.rightEqualToView(_scrollView).bottomEqualToView(_scrollView).widthIs(27).heightIs(14);
    
}

- (void)setPhotosArr:(NSArray *)photosArr{
    _photosArr = photosArr;
    _countLab.text = [NSString stringWithFormat:@"1/%ld",(long)photosArr.count];
    number = photosArr.count;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * photosArr.count, _scrollView.frame.size.height);
    for (int i = 0; i < photosArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        imageView.image = Image(photosArr[i]);
        [_scrollView addSubview:imageView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _countLab.text = [NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x/self.frame.size.width + 1,(long)number];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
