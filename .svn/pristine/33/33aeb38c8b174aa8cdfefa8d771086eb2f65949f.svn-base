//
//  MineBookButtonView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBookButtonView.h"

@interface MineBookButtonView ()

@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *countLab;

@end

@implementation MineBookButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setButton];
    }
    return self;
}

- (void)setButton{
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0,ViewHeight(self)/2, ViewWidth(self), ViewHeight(self)/2)];
    _nameLab.textColor = Color_999999;
    _nameLab.font = SYFont(13);
    _nameLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLab];
    
    _countLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, ViewWidth(self), ViewHeight(self)/2)];
    _countLab.textColor = Color_999999;
    _countLab.font = SYFont(13);
    _countLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLab];
}

- (void)setName:(NSString *)name{
    _name = name;
    _nameLab.text = name;
}

- (void)setCount:(NSString *)count{
    _count = count;
    _countLab.text = count;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchUpInside) {
        self.touchUpInside();
    }
}

- (void)setBtuColor:(UIColor *)btuColor{
    _btuColor = btuColor;
    _nameLab.textColor = btuColor;
    _countLab.textColor = btuColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
