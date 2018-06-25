//
//  GuidePageView.m
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "GuidePageView.h"

@implementation GuidePageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setGuidePageView];
    }
    return self;
}

- (void)setGuidePageView{
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    scroView.contentSize = CGSizeMake(ViewWidth(self)*3, ViewHeight(self));
    scroView.pagingEnabled = YES;
    scroView.bounces = NO;
    scroView.showsVerticalScrollIndicator = NO;
    scroView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scroView];
    
    NSArray *imageArr = @[@"引导页1",@"引导页2",@"引导页3"];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(self)*i, 0, ViewWidth(self), ViewHeight(self))];
        imageview.image = Image(imageArr[i]);
        [scroView addSubview:imageview];
        if (i == 2) {
            UIButton *tap = [UIButton buttonWithType:UIButtonTypeCustom];
            tap.frame = imageview.frame;
            [tap addTarget:self action:@selector(touchTapGestrue) forControlEvents:UIControlEventTouchUpInside];
            [scroView addSubview:tap];
        }
    }
}

- (void)touchTapGestrue{
    
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
