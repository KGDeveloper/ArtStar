//
//  MyselfWordTopButtonView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfWordTopButtonView.h"

@interface MyselfWordTopButtonView ()

@property (nonatomic,strong) UIView *lineView;

@end

@implementation MyselfWordTopButtonView

- (instancetype)initWithFrame:(CGRect)frame btuArr:(NSArray *)arr{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTopView:arr];
    }
    return self;
}

- (void)setTopView:(NSArray *)arr{
    for (int i = 0; i < arr.count; i++) {
        if (i == 0) {
            [self addSubview:[self createBtu:CGRectMake(ViewWidth(self)/arr.count*i, 0, ViewWidth(self)/arr.count, 50) title:arr[i] font:SYFont(15) color:Color_333333]];
        }else{
            [self addSubview:[self createBtu:CGRectMake(ViewWidth(self)/arr.count*i, 0, ViewWidth(self)/arr.count, 50) title:arr[i] font:SYFont(14) color:Color_999999]];
        }
    }
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49, ViewWidth(self), 1)];
    lowLine.backgroundColor = Color_ededed;
    [self addSubview:lowLine];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/arr.count/2 - 15,48, 30, 2)];
    _lineView.backgroundColor = Color_333333;
    [self addSubview:_lineView];
    
}

- (UIButton *)createBtu:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UIButton *btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = frame;
    [btu setTitle:title forState:UIControlStateNormal];
    [btu setTitleColor:color forState:UIControlStateNormal];
    btu.titleLabel.font = font;
    [btu addTarget:self action:@selector(btuAction:) forControlEvents:UIControlEventTouchUpInside];
    return btu;
}

- (void)btuAction:(UIButton *)sender{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            [norBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
            norBtu.titleLabel.font = SYFont(14);
        }
    }
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [UIView animateWithDuration:0.1 animations:^{
        self.lineView.centerX = sender.centerX;
    }];
    if (self.showDiffentView) {
        self.showDiffentView(sender.currentTitle);
    }
}

- (void)setBtu:(NSInteger)btu{
    _btu = btu;
    _lineView.centerX = kScreenWidth/10*btu;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
