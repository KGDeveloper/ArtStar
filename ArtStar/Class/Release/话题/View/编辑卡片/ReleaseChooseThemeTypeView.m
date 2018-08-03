//
//  ReleaseChooseThemeTypeView.m
//  ArtStar
//
//  Created by abc on 2018/6/28.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseChooseThemeTypeView.h"

@interface ReleaseChooseThemeTypeView ()

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,copy) NSString *resultStr;

@end

@implementation ReleaseChooseThemeTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    NSArray *titleArr = @[@"美术",@"设计",@"摄影",@"电影",@"书籍",@"文学",@"音乐",@"戏剧",@"美食"];
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 205+NavTopHeight)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, NavTopHeight - 35, kScreenWidth, 15)];
    titleLab.text = @"话题选择";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = Color_333333;
    titleLab.font = SYFont(15);
    [_topView addSubview:titleLab];
    
    UIButton *shureBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    shureBtu.frame = CGRectMake(kScreenWidth - 100, NavTopHeight - 35, 75, 30);
    [shureBtu setTitle:@"确定" forState:UIControlStateNormal];
    shureBtu.titleLabel.font = SYFont(13);
    [shureBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    shureBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [shureBtu addTarget:self action:@selector(shureAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:shureBtu];
    
    CGFloat mangic = (kScreenWidth - 300)/4;
    
    for (int i = 0; i < 9; i++) {
        CGFloat height = (i/3)*55;
        int j = i;
        if (i >= 3 & i < 6) {
            j = i - 3;
        }else if (i >= 6){
            j = i - 6;
        }
        [_topView addSubview:[self createBtuFrame:CGRectMake(mangic + (100 + mangic)*j, height + NavTopHeight, 100, 35) title:titleArr[i]]];
        
    }
    
}

- (UIButton *)createBtuFrame:(CGRect)frame title:(NSString *)title{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    [norBtu setTitle:title forState:UIControlStateNormal];
    norBtu.titleLabel.font = SYFont(13);
    [norBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    norBtu.backgroundColor = [UIColor colorWithHexString:@"#e6e1e1"];
    [norBtu addTarget:self action:@selector(norAction:) forControlEvents:UIControlEventTouchUpInside];
    norBtu.layer.cornerRadius = 5;
    norBtu.layer.masksToBounds = YES;
    return norBtu;
}

- (void)norAction:(UIButton *)sender{
    for (id obj in _topView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            if ([norBtu.currentTitle isEqualToString:@"确定"]) {
                
            }else{
                [norBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
                norBtu.backgroundColor = [UIColor colorWithHexString:@"#e6e1e1"];
            }
        }
    }
    [sender setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor colorWithHexString:@"#4d4b4b"];
    _resultStr = sender.currentTitle;
}

- (void)shureAction:(UIButton *)sender{
    self.hidden = YES;
    if (self.resultStr) {
        if (self.sendChooseResult) {
            self.sendChooseResult(self.resultStr);
        }
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
