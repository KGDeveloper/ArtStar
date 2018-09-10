//
//  AcitvitryClockSuccessAddScoreView.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/9/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "AcitvitryClockSuccessAddScoreView.h"

@interface AcitvitryClockSuccessAddScoreView ()

@property (nonatomic,strong) UIImageView *scroeImage;

@end

@implementation AcitvitryClockSuccessAddScoreView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self setScroeView];
    }
    return self;
}

- (void)setScroeView{
    _scroeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,109, 65)];
    _scroeImage.center = self.center;
    [self addSubview:_scroeImage];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.hidden = YES;
}

- (void)setScroe:(UIImage *)scroe{
    _scroe = scroe;
    _scroeImage.image = scroe;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
