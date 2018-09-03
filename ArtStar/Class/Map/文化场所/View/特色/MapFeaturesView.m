//
//  MapFeaturesView.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapFeaturesView.h"

@interface MapFeaturesView ()

@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;

@end

@implementation MapFeaturesView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(15, ViewHeight(self)/2 - 10, 80, 20);
    [_leftBtu setTitle:@"接受预定" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(12);
    _leftBtu.layer.cornerRadius = 10;
    _leftBtu.layer.borderWidth = 1;
    _leftBtu.layer.borderColor = Color_333333.CGColor;
    _leftBtu.layer.masksToBounds = YES;
    [_leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(125, ViewHeight(self)/2 - 10, 80, 20);
    [_rightBtu setTitle:@"新剧" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(12);
    _rightBtu.layer.cornerRadius = 10;
    _rightBtu.layer.borderWidth = 1;
    _rightBtu.layer.borderColor = Color_333333.CGColor;
    _rightBtu.layer.masksToBounds = YES;
    [_rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtu];
}

- (void)leftAction:(UIButton *)sender{
    sender.backgroundColor = Color_333333;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _rightBtu.backgroundColor = [UIColor whiteColor];
    [_rightBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    
    if (self.sendChoose) {
        self.sendChoose(sender.currentTitle);
    }
}
- (void)rightAction:(UIButton *)sender{
    sender.backgroundColor = Color_333333;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _leftBtu.backgroundColor = [UIColor whiteColor];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    
    if (self.sendChoose) {
        self.sendChoose(sender.currentTitle);
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
