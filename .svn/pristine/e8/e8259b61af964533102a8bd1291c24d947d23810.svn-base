//
//  MapVC.m
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MapVC.h"
#import "MapTopScreeningView.h"
#import "MapAccurateAndFuzzyScreeningView.h"

@interface MapVC ()

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) MapTopScreeningView *screeningView;
@property (nonatomic,strong) MapAccurateAndFuzzyScreeningView *fuzzyScreeningView;
@property (nonatomic,copy) NSString *type;

@end

@implementation MapVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtuWithTitle:@"定位中" image:Image(@"loc")];
    [self cllLocation];
    [self setRightBtuWithTitle:@"筛选" image:nil];
    
    [self setNavCenterView];
    
}

- (void)setNavCenterView{
    
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 210, 40)];
    [self setNavTitleView:_titleView];
    
    NSArray *titleArr = @[@"附近的人",@"文化场所",@"文艺消费"];
    
    for (int i = 0; i < 3; i++) {
        if (i == 0) {
            [_titleView addSubview:[self createButtonWithFram:CGRectMake(70*i, 0, 70, 35) title:titleArr[i] color:Color_333333 font:SYFont(15)]];
        }else{
            [_titleView addSubview:[self createButtonWithFram:CGRectMake(70*i, 0, 70, 35) title:titleArr[i] color:Color_999999 font:SYFont(14)]];
        }
    }
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(20,38, 30, 2)];
    _line.backgroundColor = Color_333333;
    [_titleView addSubview:_line];
    
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
    for (id obj in _titleView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *nor = obj;
            [nor setTitleColor:Color_999999 forState:UIControlStateNormal];
            nor.titleLabel.font = SYFont(14);
        }
    }
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    
    if ([sender.currentTitle isEqualToString:@"附近的人"]) {
        _type = sender.currentTitle;
    }else if ([sender.currentTitle isEqualToString:@"文化场所"]){
        _type = sender.currentTitle;
    }else if ([sender.currentTitle isEqualToString:@"文艺消费"]){
        _type = sender.currentTitle;
    }
}

- (void)leftNavBtuAction:(UIButton *)sender{
    [self setLeftBtuWithTitle:@"定位中" image:Image(@"loc")];
    [self cllLocation];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    if ([_type isEqualToString:@"文艺消费"]) {
        self.screeningView.mapType = 1;
        self.screeningView.hidden = NO;
    }else if ([_type isEqualToString:@"文化场所"]){
        self.screeningView.mapType = 0;
        self.screeningView.hidden = NO;
    }else{
        self.fuzzyScreeningView.hidden = NO;
    }
}

- (void)cllLocation{
    KGLocationCityManager *manager = [KGLocationCityManager shareManager];
    [manager obtainYourLocation];
    __weak typeof(self) mySelf = self;
    manager.ToObtainYourLocation = ^(NSString *city, double latitude, double longitude) {
        [mySelf setLeftBtuWithTitle:city image:Image(@"loc")];
    };
}

- (MapTopScreeningView *)screeningView{
    if (!_screeningView) {
        _screeningView = [[MapTopScreeningView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_screeningView];
    }
    return _screeningView;
}

- (MapAccurateAndFuzzyScreeningView *)fuzzyScreeningView{
    if (!_fuzzyScreeningView) {
        _fuzzyScreeningView = [[MapAccurateAndFuzzyScreeningView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_fuzzyScreeningView];
    }
    return _fuzzyScreeningView;
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
