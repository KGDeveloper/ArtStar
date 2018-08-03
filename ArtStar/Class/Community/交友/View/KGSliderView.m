//
//  KGSliderView.m
//  ArtStar
//
//  Created by abc on 6/4/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "KGSliderView.h"
#import "KGSlider.h"

@interface KGSliderView ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) KGSlider *kgSlider;
@property (nonatomic,strong) UILabel *valueLab;

@end

@implementation KGSliderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setSliderView];
    }
    return self;
}

- (void)setSliderView{
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ViewWidth(self) - 30, 15)];
    _titleLab.font = SYFont(13);
    _titleLab.textColor = Color_333333;
    [self addSubview:_titleLab];
    
    _valueLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, ViewWidth(self), 15)];
    _valueLab.font = SYFont(13);
    _valueLab.textColor = Color_333333;
    _valueLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_valueLab];
    
    _kgSlider = [[KGSlider alloc]initWithFrame:CGRectMake(50, 35, ViewWidth(self) - 100, 15)];
    _kgSlider.minimumTrackTintColor = Color_333333;
    _kgSlider.maximumTrackTintColor = Color_fafafa;
    [_kgSlider addTarget:self action:@selector(changeValuew:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_kgSlider];
    
}

- (void)changeValuew:(UISlider *)sender{
    _valueLab.text = [NSString stringWithFormat:@"%.0f%@",sender.value,_unitStr];
    if (self.sendValueToFormView) {
        self.sendValueToFormView(_valueLab.text);
    }
}

- (void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    _kgSlider.minimumValue = minValue;
}

- (void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    _kgSlider.maximumValue = maxValue;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
