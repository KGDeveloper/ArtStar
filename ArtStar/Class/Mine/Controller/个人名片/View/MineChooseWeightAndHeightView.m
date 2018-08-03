//
//  MineChooseWeightAndHeightView.m
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineChooseWeightAndHeightView.h"
#import "KGSlider.h"

@interface MineChooseWeightAndHeightView ()

@property (nonatomic,strong) KGSlider *slider;
@property (nonatomic,strong) UILabel *countLab;

@end

@implementation MineChooseWeightAndHeightView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self setView];
    }
    return self;
}

- (void)setView{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(5, ViewHeight(self) - 155, ViewWidth(self) - 10, 100)];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 5;
    topView.layer.masksToBounds = YES;
    [self addSubview:topView];
    
    _slider = [[KGSlider alloc]initWithFrame:CGRectMake((ViewWidth(topView) - 275)/2, 35, 275, 10)];
    _slider.minimumTrackTintColor = Color_333333;
    _slider.maximumTrackTintColor = Color_999999;
    _slider.value = 0;
    [_slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    [topView addSubview:_slider];
    
    _countLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewHeight(topView) - 35, 50, 15)];
    _countLab.textColor = Color_333333;
    _countLab.font = SYFont(14);
    _countLab.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_countLab];
    
    UIButton *finishBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtu.frame = CGRectMake(5, ViewHeight(self) - 45, ViewWidth(self) - 10, 45);
    [finishBtu setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    finishBtu.backgroundColor = [UIColor whiteColor];
    finishBtu.layer.cornerRadius = 5;
    finishBtu.layer.masksToBounds = YES;
    [finishBtu addTarget:self action:@selector(finishTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:finishBtu];
    
}

- (void)finishTouch{
    if (self.sendValueToController) {
        self.sendValueToController(_type, [NSString stringWithFormat:@"%.0f",_slider.value]);
    }
    self.hidden = YES;
}

- (void)valueChange:(KGSlider *)sender{
    _countLab.centerX = sender.value/sender.maximumValue*sender.bounds.size.width + (ViewWidth(self) - 285)/2;
    _countLab.text = [NSString stringWithFormat:@"%.0f%@",sender.value,_unitStr];
}

- (void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    _slider.minimumValue = minValue;
}
- (void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    _slider.maximumValue = maxValue;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
