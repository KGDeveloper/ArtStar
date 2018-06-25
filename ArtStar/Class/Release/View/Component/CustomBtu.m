//
//  CustomBtu.m
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CustomBtu.h"

@interface CustomBtu ()

@property (nonatomic,copy) NSString *str;
@property (nonatomic,strong) UILabel *lab;

@end

@implementation CustomBtu

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image{
    self = [super initWithFrame:frame];
    if (self) {
        _str = title;
        [self setUITitle:title image:image];
    }
    return self;
}

- (void)setUITitle:(NSString *)title image:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,ViewWidth(self), ViewWidth(self))];
    imageView.image = image;
    [self addSubview:imageView];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(0,ViewWidth(self) + 15, ViewWidth(self), 20)];
    _lab.text = title;
    _lab.textColor = Color_333333;
    _lab.font = FZFont(14);
    _lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab];
}
- (void)setFont:(CGFloat)font{
    _font = font;
    _lab.font = FZFont(font);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.action) {
        self.action(_str);
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
