//
//  MineOnlineOrStealthView.m
//  ArtStar
//
//  Created by abc on 6/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineOnlineOrStealthView.h"

@interface MineOnlineOrStealthView ()

@property (nonatomic,strong) UIButton *onLine;
@property (nonatomic,strong) UIButton *stealth;

@end

@implementation MineOnlineOrStealthView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.1];
        [self setView];
    }
    return self;
}

- (void)setView{
    _onLine = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self)/2)];
    [_onLine setTitle:@"在线" forState:UIControlStateNormal];
    [_onLine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _onLine.titleLabel.font = SYFont(11);
    [_onLine addTarget:self action:@selector(onlineAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_onLine];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, 0, ViewWidth(self) - 10, 1)];
    line.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:0.2];
    [self addSubview:line];
    
    _stealth = [[UIButton alloc]initWithFrame:CGRectMake(0, ViewHeight(self)/2, ViewWidth(self), ViewHeight(self)/2)];
    [_stealth setTitle:@"隐身" forState:UIControlStateNormal];
    [_stealth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _stealth.titleLabel.font = SYFont(11);
    [_stealth addTarget:self action:@selector(onlineAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_stealth];
}

- (void)onlineAction:(UIButton *)sender{
    if (self.touchUpBtu) {
        self.touchUpBtu(sender.currentTitle);
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
