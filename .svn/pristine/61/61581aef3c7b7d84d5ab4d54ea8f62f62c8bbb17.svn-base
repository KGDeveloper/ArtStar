//
//  FriendsSuspensionView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsSuspensionView.h"

@implementation FriendsSuspensionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIButton *leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtu.frame = CGRectMake(0, 0, (ViewWidth(self) - 1)/2, ViewHeight(self));
    [leftBtu setTitle:@"复制" forState:UIControlStateNormal];
    leftBtu.titleLabel.font = SYFont(13);
    [leftBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtu addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtu];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake((ViewWidth(self) - 1)/2, 0, 1, ViewHeight(self))];
    line.backgroundColor = Color_999999;
    [self addSubview:line];
    
    UIButton *rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtu.frame = CGRectMake((ViewWidth(self) - 1)/2 + 1, 0, (ViewWidth(self) - 1)/2, ViewHeight(self));
    [rightBtu setTitle:@"删除" forState:UIControlStateNormal];
    rightBtu.titleLabel.font = SYFont(13);
    [rightBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtu addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtu];
}

- (void)leftClick{
    if ([self.delegate respondsToSelector:@selector(leftAction:)]) {
        [self.delegate leftAction:self.tag];
    }
    self.hidden = YES;
}

- (void)rightClick{
    if ([self.delegate respondsToSelector:@selector(rightAction:)]) {
        [self.delegate rightAction:self.tag];
    }
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
