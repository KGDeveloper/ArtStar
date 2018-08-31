//
//  ViewForActivity.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/30.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ViewForActivity.h"

@interface ViewForActivity ()

@property (nonatomic,strong) UIView *centerView;

@end

@implementation ViewForActivity

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self setActivityView];
    }
    return self;
}
// MARK: --活动弹窗--
- (void)setActivityView{
    _centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 60, (kScreenWidth - 60)/358*505)];
    _centerView.center = self.center;
    [self addSubview:_centerView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:_centerView.bounds];
    imageView.image = Image(@"关于奖品");
    [_centerView addSubview:imageView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
