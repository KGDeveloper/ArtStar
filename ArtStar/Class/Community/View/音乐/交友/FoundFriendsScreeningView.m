//
//  FoundFriendsScreeningView.m
//  ArtStar
//
//  Created by abc on 6/4/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FoundFriendsScreeningView.h"
#import "KGSliderView.h"
#import "MusicChooseSexView.h"
#import "KGSlider.h"

@interface FoundFriendsScreeningView ()

@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *dayView;
@property (nonatomic,strong) UILabel *numLab;

@end

@implementation FoundFriendsScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIView *backView = [[UIView alloc]initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4;
        [self addSubview:backView];
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    UIView *lowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), NavTopHeight - 44 + 65)];
    lowView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lowView];
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(ViewWidth(self)/2 - 100, NavTopHeight - 44 + 20, 80, 20);
    [_leftBtu setTitle:@"我想看见谁" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(15);
    [_leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(ViewWidth(self)/2 + 20, NavTopHeight - 44 + 20, 80, 20);
    [_rightBtu setTitle:@"谁能看见我" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [_rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtu];
    
    UIButton *shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    shureBtu.frame = CGRectMake(ViewWidth(self) - 45, NavTopHeight - 44 + 20, 30, 20);
    [shureBtu setTitle:@"确定" forState:UIControlStateNormal];
    [shureBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    shureBtu.titleLabel.font = SYFont(15);
    [shureBtu addTarget:self action:@selector(shureAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shureBtu];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 100, NavTopHeight - 44 + 20 + 15 + 10, 80, 2)];
    _line.backgroundColor = Color_333333;
    [self addSubview:_line];
    
    self.leftView.hidden = NO;
}
- (void)shureAction{
    self.hidden = YES;
}

- (void)leftAction:(UIButton *)sender{
    _line.centerX = sender.centerX;
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [self bringSubviewToFront:self.leftView];
}

- (void)rightAction:(UIButton *)sender{
    _line.centerX = sender.centerX;
    [_leftBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(13);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [self bringSubviewToFront:self.rightView];
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 21, ViewWidth(self), 480)];
        _leftView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_leftView];
        
        KGSliderView *spaceSlider = [[KGSliderView alloc]initWithFrame:CGRectMake(0, 20, ViewWidth(_leftView), 80)];
        spaceSlider.titleStr = @"发现范围";
        spaceSlider.minValue = 0;
        spaceSlider.maxValue = 50;
        spaceSlider.unitStr = @"km";
        spaceSlider.sendValueToFormView = ^(NSString *str) {
            NSLog(@"%@",str);
        };
        [_leftView addSubview:spaceSlider];
        
        KGSliderView *ageSlider = [[KGSliderView alloc]initWithFrame:CGRectMake(0, 110, ViewWidth(_leftView), 80)];
        ageSlider.titleStr = @"发现年龄";
        ageSlider.minValue = 0;
        ageSlider.maxValue = 50;
        ageSlider.unitStr = @"岁";
        ageSlider.sendValueToFormView = ^(NSString *str) {
            NSLog(@"%@",str);
        };
        [_leftView addSubview:ageSlider];
        
        KGSliderView *compatibilitySlider = [[KGSliderView alloc]initWithFrame:CGRectMake(0, 200, ViewWidth(_leftView), 80)];
        compatibilitySlider.titleStr = @"发现匹配度";
        compatibilitySlider.minValue = 0;
        compatibilitySlider.maxValue = 100;
        compatibilitySlider.unitStr = @"%";
        compatibilitySlider.sendValueToFormView = ^(NSString *str) {
            NSLog(@"%@",str);
        };
        [_leftView addSubview:compatibilitySlider];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 285, 150, 15)];
        titleLab.text = @"性别筛选";
        titleLab.font = SYFont(13);
        titleLab.textColor = Color_333333;
        [_leftView addSubview:titleLab];
        
        MusicChooseSexView *sexView = [[MusicChooseSexView alloc]initWithFrame:CGRectMake(0, 290, ViewWidth(_leftView), 120)];
        sexView.backgroundColor = [UIColor clearColor];
        sexView.chooseSexStr = ^(NSString *sex) {
            NSLog(@"%@",sex);
        };
        [_leftView addSubview:sexView];
        
        _dayView = [[UIView alloc]initWithFrame:CGRectMake(0, 420, ViewWidth(_leftView), 60)];
        [_leftView addSubview:_dayView];
        
        UILabel *dayLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 150, 15)];
        dayLab.text = @"活跃时间";
        dayLab.font = SYFont(13);
        dayLab.textColor = Color_333333;
        [_dayView addSubview:dayLab];
        
        NSArray *titleArr = @[@"一天内",@"三天内",@"一周内"];
        for (int i = 0; i < 3; i++) {
            [_dayView addSubview:[self createButton:CGRectMake((ViewWidth(_leftView) - 180)/4 + ((ViewWidth(_leftView) - 180)/4 + 60)*i, 30, 60, 20) title:titleArr[i]]];
        }
    }
    return _leftView;
}

- (UIButton *)createButton:(CGRect)frame title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Color_333333 forState:UIControlStateNormal];
    button.titleLabel.font = SYFont(14);
    button.layer.cornerRadius = 10;
    button.layer.borderColor = Color_999999.CGColor;
    button.layer.borderWidth = 1;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)buttonAction:(UIButton *)sender{
    for (id obj in _dayView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *button = obj;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:Color_333333 forState:UIControlStateNormal];
        }
    }
    sender.backgroundColor = Color_333333;
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 21, ViewWidth(self), ViewHeight(self) - 160)];
        _rightView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_rightView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ViewWidth(_rightView), 15)];
        titleLab.text = @"选择匹配度高于多少能看到我";
        titleLab.font = SYFont(13);
        titleLab.textColor = Color_333333;
        titleLab.textAlignment = NSTextAlignmentCenter;
        [_rightView addSubview:titleLab];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(_rightView)/2 - 29, 55, 58, 58)];
        imageView.image = Image(@"match");
        [_rightView addSubview:imageView];
        
        _numLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 77, ViewWidth(_rightView), 15)];
        _numLab.text = @"0%";
        _numLab.font = SYFont(14);
        _numLab.textColor = Color_333333;
        _numLab.textAlignment = NSTextAlignmentCenter;
        [_rightView addSubview:_numLab];
        
        KGSlider *slider = [[KGSlider alloc]initWithFrame:CGRectMake(50, 133, ViewWidth(_rightView) - 100, 15)];
        slider.minimumValue = 0;
        slider.maximumValue = 100;
        slider.minimumTrackTintColor = Color_333333;
        slider.maximumTrackTintColor = Color_fafafa;
        [slider addTarget:self action:@selector(sliderChangeValue:) forControlEvents:UIControlEventValueChanged];
        [_rightView addSubview:slider];
    }
    return _rightView;
}

- (void)sliderChangeValue:(KGSlider *)sender{
    _numLab.text = [NSString stringWithFormat:@"%.0f%@",sender.value,@"%"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
