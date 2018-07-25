//
//  MapAccurateAndFuzzyScreeningView.m
//  ArtStar
//
//  Created by abc on 2018/6/22.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapAccurateAndFuzzyScreeningView.h"
#import "KGSliderView.h"
#import "MusicChooseSexView.h"
#import "MineWorksIndustryView.h"
#import "MapScreeningCompoentView.h"

@interface MapAccurateAndFuzzyScreeningView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) KGSliderView *scopeSlider;
@property (nonatomic,strong) KGSliderView *ageSlider;
@property (nonatomic,strong) KGSliderView *comSlider;
@property (nonatomic,strong) MineWorksIndustryView *workView;
@property (nonatomic,strong) UIScrollView *backView;
@property (nonatomic,strong) UIView *fuzzView;

@end

@implementation MapAccurateAndFuzzyScreeningView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setNavCenterView];
        [self setSliderView];
    }
    return self;
}

- (void)setNavCenterView{
    
    _backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,-35, kScreenWidth,ViewHeight(self) - 150)];
    _backView.contentSize = CGSizeMake(kScreenWidth, 845);
    _backView.showsVerticalScrollIndicator = NO;
    _backView.showsHorizontalScrollIndicator = NO;
    _backView.delegate = self;
    [self addSubview:_backView];
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavTopHeight)];
    _titleView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:_titleView];
    
    [_titleView addSubview:[self createButtonWithFram:CGRectMake(90, NavTopHeight - 40, 75, 35) title:@"模糊筛选" color:Color_333333 font:SYFont(15)]];
    
    [_titleView addSubview:[self createButtonWithFram:CGRectMake(kScreenWidth - 165,NavTopHeight - 40, 75, 35) title:@"精确筛选" color:Color_999999 font:SYFont(14)]];
    
    [_titleView addSubview:[self createButtonWithFram:CGRectMake(kScreenWidth - 50,NavTopHeight - 40, 35, 35) title:@"确定" color:Color_333333 font:SYFont(15)]];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0,NavTopHeight - 2, 30, 2)];
    _line.backgroundColor = Color_333333;
    _line.centerX = 127.5;
    [_titleView addSubview:_line];
    
}

- (void)setSliderView{
    
    _scopeSlider = [[KGSliderView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 20, kScreenWidth, 80)];
    _scopeSlider.titleStr = @"发现范围";
    _scopeSlider.unitStr = @"km";
    _scopeSlider.minValue = 0;
    _scopeSlider.maxValue = 50;
    _scopeSlider.sendValueToFormView = ^(NSString *str) {
        
    };
    [_backView addSubview:_scopeSlider];
    
    _ageSlider = [[KGSliderView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 100, kScreenWidth, 80)];
    _ageSlider.titleStr = @"发现年龄";
    _ageSlider.unitStr = @"岁";
    _ageSlider.minValue = 0;
    _ageSlider.maxValue = 100;
    _ageSlider.sendValueToFormView = ^(NSString *str) {
        
    };
    [_backView addSubview:_ageSlider];
    
    _comSlider = [[KGSliderView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 180, kScreenWidth, 80)];
    _comSlider.titleStr = @"发现匹配度";
    _comSlider.unitStr = @"%";
    _comSlider.minValue = 0;
    _comSlider.maxValue = 100;
    _comSlider.sendValueToFormView = ^(NSString *str) {
        
    };
    [_backView addSubview:_comSlider];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, NavTopHeight + 260, 150, 15)];
    titleLab.text = @"性别筛选";
    titleLab.font = SYFont(13);
    titleLab.textColor = Color_333333;
    [_backView addSubview:titleLab];
    
    MusicChooseSexView *sexView = [[MusicChooseSexView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 285, ViewWidth(self), 140)];
    sexView.chooseSexStr = ^(NSString *sex) {
        NSLog(@"%@",sex);
    };
    [_backView addSubview:sexView];
    
    [self setFuzzayView];
}

- (MineWorksIndustryView *)workView{
    if (!_workView) {
        _workView = [[MineWorksIndustryView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 425, kScreenWidth, 400)];
        _workView.status = @"不显示";
        [_backView addSubview:_workView];
    }
    return _workView;
}

- (void)setFuzzayView{
    _fuzzView = [[UIView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 425, kScreenWidth, 315)];
    [_backView addSubview:_fuzzView];
    
    MapScreeningCompoentView *worksView = [[MapScreeningCompoentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 105)];
    worksView.title = @"文艺工作者";
    worksView.choosebtuArr = @[@"影视",@"文学",@"设计",@"美术",@"音乐",@"表演"];
    worksView.chooseScreeningType = ^(NSString *str) {
        
    };
    [_fuzzView addSubview:worksView];
    
    MapScreeningCompoentView *loveView = [[MapScreeningCompoentView alloc]initWithFrame:CGRectMake(0, 105, kScreenWidth, 105)];
    loveView.title = @"文艺爱好者";
    loveView.choosebtuArr = @[@"影视",@"文学",@"设计",@"美术",@"音乐",@"表演"];
    loveView.chooseScreeningType = ^(NSString *str) {
        
    };
    [_fuzzView addSubview:loveView];
    
    MapScreeningCompoentView *sameView = [[MapScreeningCompoentView alloc]initWithFrame:CGRectMake(0,210, kScreenWidth, 105)];
    sameView.title = @"兴趣相同";
    sameView.choosebtuArr = @[@"书籍",@"美食",@"运动",@"休闲方式",@"足迹"];
    sameView.chooseScreeningType = ^(NSString *str) {
        
    };
    [_fuzzView addSubview:sameView];
}


//MARK:--------------------------------------创建公共按钮--------------------------------------------------
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
    if ([sender.currentTitle isEqualToString:@"确定"]) {
        self.hidden = YES;
    }else{
        for (id obj in _titleView.subviews) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *nor = obj;
                if ([nor.currentTitle isEqualToString:@"确定"]) {
                    
                }else{
                    [nor setTitleColor:Color_999999 forState:UIControlStateNormal];
                    nor.titleLabel.font = SYFont(14);
                }
            }
        }
        [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
        sender.titleLabel.font = SYFont(15);
        [UIView animateWithDuration:0.2 animations:^{
            self.line.centerX = sender.centerX;
        }];
    }
    
    if ([sender.currentTitle isEqualToString:@"模糊筛选"]) {
        self.fuzzView.hidden = NO;
        self.workView.hidden = YES;
    }else if ([sender.currentTitle isEqualToString:@"精确筛选"]){
        self.fuzzView.hidden = YES;
        self.workView.hidden = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
