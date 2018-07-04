//
//  ReadBooksWriteYourIdeaVC.m
//  ArtStar
//
//  Created by abc on 2018/7/4.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReadBooksWriteYourIdeaVC.h"

@interface ReadBooksWriteYourIdeaVC ()

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *starView;
@property (nonatomic,strong) UILabel *leveLab;
@property (nonatomic,strong) YYTextView *ideaView;

@end

@implementation ReadBooksWriteYourIdeaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(15, 0, 150, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"确定" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setStarViewUI];
    [self setViewUI];
}

- (void)setViewUI{
    
    _ideaView = [[YYTextView alloc]initWithFrame:CGRectMake(15, NavTopHeight + 160, kScreenWidth - 30, 175)];
    _ideaView.placeholderText = @"说说你读过之后的感受吧...";
    _ideaView.placeholderFont = SYFont(13);
    _ideaView.placeholderTextColor = Color_cccccc;
    _ideaView.textColor = Color_333333;
    _ideaView.font = SYFont(13);
    _ideaView.layer.borderWidth = 1;
    _ideaView.layer.borderColor = Color_ededed.CGColor;
    _ideaView.layer.cornerRadius = 5;
    _ideaView.layer.masksToBounds = YES;
    [self.view addSubview:_ideaView];
    
    NSArray *titleArr = @[@"想读",@"在读",@"读过",@"书评"];
    for (int i = 0; i < 4; i++) {
        UIColor *color = Color_999999;
        UIFont *font = SYFont(14);
        if ([titleArr[i] isEqualToString:_status]) {
            color = Color_333333;
            font = SYFont(15);
        }
        [self.view addSubview:[self createButtonWithFrame:CGRectMake(kScreenWidth/2 - 125 + 70*i, NavTopHeight, 40, 30) title:titleArr[i] font:font color:color]];
    }
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 29, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [self.view addSubview:lowLine];
    
    CGFloat width = width = kScreenWidth/2 - 125;;
    if ([_status isEqualToString:@"想读"]) {
        width = kScreenWidth/2 - 125;
        _starView.alpha = 0;
        _ideaView.frame = CGRectMake(15, NavTopHeight + 60, kScreenWidth - 30, 175);
    }else if ([_status isEqualToString:@"在读"]){
        width = kScreenWidth/2 - 55;
    }else if ([_status isEqualToString:@"读过"]){
        width = kScreenWidth/2 + 15;
    }else if ([_status isEqualToString:@"书评"]){
        width = kScreenWidth/2 + 85;
    }
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(width, NavTopHeight + 28, 40, 2)];
    _line.backgroundColor = [UIColor colorWithHexString:@"#4d4d4d"];
    [self.view addSubview:_line];
    
}

- (void)setStarViewUI{
    
    _starView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 30, kScreenWidth, 110)];
    [self.view addSubview:_starView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 15)];
    titleLab.text = @"点击星星评分";
    titleLab.textColor = Color_333333;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = SYFont(14);
    [_starView addSubview:titleLab];
    
    for (int i = 0; i < 5; i++) {
        [_starView addSubview:[self createStarButtonWithFrame:CGRectMake(kScreenWidth/2 - 67.5 + 30*i, 65, 15, 15) tag:200+i]];
    }
    
    _leveLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, kScreenWidth, 12)];
    _leveLab.text = @"";
    _leveLab.textColor = Color_999999;
    _leveLab.textAlignment = NSTextAlignmentCenter;
    _leveLab.font = SYFont(12);
    [_starView addSubview:_leveLab];
    
}

- (UIButton *)createStarButtonWithFrame:(CGRect)frame tag:(NSInteger)tag{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    norBtu.tag = tag;
    [norBtu setImage:Image(@"stargray") forState:UIControlStateNormal];
    [norBtu addTarget:self action:@selector(starbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return norBtu;
}
- (void)starbuttonAction:(UIButton *)sender{
    for (id obj in _starView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            if (norBtu.tag <= sender.tag) {
                [norBtu setImage:Image(@"star") forState:UIControlStateNormal];
            }else{
                [norBtu setImage:Image(@"stargray") forState:UIControlStateNormal];
            }
        }
    }
    if (sender.tag == 200) {
        _leveLab.text = @"写的很差";
    }else if (sender.tag == 201){
        _leveLab.text = @"写的一般";
    }else if (sender.tag == 202){
        _leveLab.text = @"写的还不错";
    }else if (sender.tag == 203){
        _leveLab.text = @"推荐";
    }else{
        _leveLab.text = @"极力推荐";
    }
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font color:(UIColor *)color{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    [norBtu setTitle:title forState:UIControlStateNormal];
    [norBtu setTitleColor:color forState:UIControlStateNormal];
    norBtu.titleLabel.font = font;
    [norBtu addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return norBtu;
}

- (void)buttonAction:(UIButton *)sender{
    for (id obj in self.view.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *norBtu = obj;
            norBtu.titleLabel.font = SYFont(14);
            [norBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
        }
    }
    sender.titleLabel.font = SYFont(15);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    if ([sender.currentTitle isEqualToString:@"想读"]) {
        _starView.alpha = 0;
        _ideaView.frame = CGRectMake(15, NavTopHeight + 60, kScreenWidth - 30, 175);
    }else{
        _starView.alpha = 1;
        _ideaView.frame = CGRectMake(15, NavTopHeight + 160, kScreenWidth - 30, 175);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
