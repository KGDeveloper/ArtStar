//
//  MineCollectionHeaderScrollView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionHeaderScrollView.h"

@interface MineCollectionHeaderScrollView ()

@property (nonatomic,strong) UIScrollView *backView;
@property (nonatomic,strong) UIView *line;

@end

@implementation MineCollectionHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setScrollView];
    }
    return self;
}

- (void)setScrollView{
    _backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _backView.showsVerticalScrollIndicator = NO;
    _backView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_backView];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(15, ViewHeight(self) - 2, 30, 2)];
    _line.backgroundColor = Color_333333;
    [_backView addSubview:_line];
}

- (void)setBtuArr:(NSArray *)btuArr{
    _btuArr = btuArr;
    _backView.contentSize = CGSizeMake(btuArr.count*70, ViewHeight(self));
    for (int i = 0; i < btuArr.count; i++) {
        if (i == 0) {
            [_backView addSubview:[self createButtonWithFram:CGRectMake(70*i, 0, 50,ViewHeight(self)) title:btuArr[i] color:Color_333333 font:SYFont(14)]];
        }else{
            [_backView addSubview:[self createButtonWithFram:CGRectMake(70*i, 0, 50, ViewHeight(self)) title:btuArr[i] color:Color_999999 font:SYFont(13)]];
        }
    }
}

- (UIButton *)createButtonWithFram:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    [norBtu setTitle:title forState:UIControlStateNormal];
    norBtu.titleLabel.font = font;
    [norBtu setTitleColor:color forState:UIControlStateNormal];
    [norBtu addTarget:self action:@selector(norClick:) forControlEvents:UIControlEventTouchUpInside];
    return norBtu;
}

- (void)norClick:(UIButton *)sender{
    for (id obj in _backView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            norBtu.titleLabel.font = SYFont(13);
            [norBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
        }
    }
    sender.titleLabel.font = SYFont(14);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
       self.line.centerX = sender.centerX;
    }];
    if (self.touchBtuShowDiffentView) {
        self.touchBtuShowDiffentView(sender.currentTitle);
    }
}

//MARK:-----------------------------------------判断两个颜色是否相同-----------------------------------------------
- (BOOL)firstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor)) {
        return YES;
    }else{
        return NO;
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
