//
//  MapScreeningCompoentView.m
//  ArtStar
//
//  Created by abc on 2018/6/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapScreeningCompoentView.h"

@interface MapScreeningCompoentView ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation MapScreeningCompoentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15,0, kScreenWidth - 30, 15)];
    _titleLab.textColor = Color_333333;
    _titleLab.font = SYFont(13);
    [self addSubview:_titleLab];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLab.text = title;
}

- (void)setChoosebtuArr:(NSArray *)choosebtuArr{
    _choosebtuArr = choosebtuArr;
    for (int i = 0; i < choosebtuArr.count; i++) {
        if (i > 3) {
            [self addSubview:[self createButtonWithFram:CGRectMake(15+95*(i-4), 65, 75, 20) title:choosebtuArr[i] color:Color_333333 font:SYFont(12)]];
        }else{
            [self addSubview:[self createButtonWithFram:CGRectMake(15+95*i, 30, 75, 20) title:choosebtuArr[i] color:Color_333333 font:SYFont(12)]];
        }
    }
    
}

//MARK:--------------------------------------创建公共按钮--------------------------------------------------
- (UIButton *)createButtonWithFram:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    [norBtu setTitle:title forState:UIControlStateNormal];
    norBtu.titleLabel.font = font;
    [norBtu setTitleColor:color forState:UIControlStateNormal];
    [norBtu addTarget:self action:@selector(norClick:) forControlEvents:UIControlEventTouchUpInside];
    norBtu.layer.cornerRadius = 10;
    norBtu.layer.borderColor = Color_333333.CGColor;
    norBtu.layer.borderWidth = 1;
    norBtu.layer.masksToBounds = YES;
    return norBtu;
}

- (void)norClick:(UIButton *)sender{
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *nor = obj;
            [nor setTitleColor:Color_333333 forState:UIControlStateNormal];
            nor.backgroundColor = [UIColor whiteColor];
        }
    }
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = Color_333333;
    if (self.chooseScreeningType) {
        self.chooseScreeningType(sender.currentTitle);
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
