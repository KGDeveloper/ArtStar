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
#import "LiteratureAndArtVenuesVC.h"
#import "ConsumptionOfLiteratureAndArtVC.h"

@interface MapVC ()

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) MapTopScreeningView *screeningView;
@property (nonatomic,strong) MapAccurateAndFuzzyScreeningView *fuzzyScreeningView;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,strong) LiteratureAndArtVenuesVC *literatureAndArtVenuesVC;//:--文化场所--
@property (nonatomic,strong) ConsumptionOfLiteratureAndArtVC *consumptionOfLiteratureAndArtVC;//:--文艺消费--

@end

@implementation MapVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 100, 30) title:@"定位中" image:Image(@"loc")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"筛选" image:nil];
    [self cllLocation];
    [self loadHTMLFaile];
    [self setNavCenterView];
    // !!!: --判断是否是刚打开APP，如果是从其他页面跳转过来不显示活动入口，只在第一次进入才显示--
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IntoAcitivitry"]) {
        [self intoAcitivityView];
//        [[NSUserDefaults standardUserDefaults] setObject:@"已加载过" forKey:@"IntoAcitivitry"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
// MARK: --初始化文化消费页面--
- (ConsumptionOfLiteratureAndArtVC *)consumptionOfLiteratureAndArtVC{
    if (!_consumptionOfLiteratureAndArtVC) {
        _consumptionOfLiteratureAndArtVC = [[ConsumptionOfLiteratureAndArtVC alloc]init];
        [self addChildViewController:_consumptionOfLiteratureAndArtVC];
    }
    return _consumptionOfLiteratureAndArtVC;
}
// MARK: --初始化文化场所--
- (LiteratureAndArtVenuesVC *)literatureAndArtVenuesVC{
    if (!_literatureAndArtVenuesVC) {
        _literatureAndArtVenuesVC = [[LiteratureAndArtVenuesVC alloc]init];
        [self addChildViewController:_literatureAndArtVenuesVC];
    }
    return _literatureAndArtVenuesVC;
}
// MARK: --创建首页加载附近的人HTML文件--
- (void)loadHTMLFaile{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight - NavButtomHeight)];
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    webView.scrollView.scrollEnabled = NO;
    NSString *mainBoundPath = [[NSBundle mainBundle] bundlePath];
    NSString *basePath = [NSString stringWithFormat:@"%@/星球吸引",mainBoundPath];
    NSURL *baseUrl = [NSURL fileURLWithPath:basePath isDirectory:YES];
    NSString *htmlPath = [NSString stringWithFormat:@"%@/shandian.html",basePath];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:baseUrl];
    [self.view addSubview:webView];
}
// MARK: --创建活动入口--
- (void)intoAcitivityView{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *starTime = [format stringFromDate:[NSDate date]];
    NSString *endTime = @"2018-11-30 23:59:00";
    if ([self returnResultWithStarTime:[format dateFromString:starTime] endTime:[format dateFromString:endTime]] > 0) {
        ViewForActivity *view = [[ViewForActivity alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.showImage = Image(@"图层10");
        view.alertType = ActivityTypeMapShow;
        __weak typeof(self) weakSelf = self;
        view.mapShowPushActivityController = ^{
            [weakSelf pushNoTabBarViewController:[[AcitivityForViewController alloc]init] animated:YES];
        };
        [self.tabBarController.view addSubview:view];
    }
}
// MARK: --判断是否在活动时间范围内--
- (NSTimeInterval)returnResultWithStarTime:(NSDate*)starTime endTime:(NSDate*)endTime{
    return [endTime timeIntervalSinceDate:starTime];
}
// MARK: --创建顶部导航栏按钮--
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
//MARK:--创建公共按钮--
- (UIButton *)createButtonWithFram:(CGRect)frame title:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    UIButton *norBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    norBtu.frame = frame;
    [norBtu setTitle:title forState:UIControlStateNormal];
    norBtu.titleLabel.font = font;
    [norBtu setTitleColor:color forState:UIControlStateNormal];
    [norBtu addTarget:self action:@selector(norClick:) forControlEvents:UIControlEventTouchUpInside];
    return norBtu;
}
// MARK: --公共按钮点击事件--
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
        [self.consumptionOfLiteratureAndArtVC.view removeFromSuperview];
        [self.literatureAndArtVenuesVC.view removeFromSuperview];
    }else if ([sender.currentTitle isEqualToString:@"文化场所"]){
        _type = sender.currentTitle;
        [self.view addSubview:self.literatureAndArtVenuesVC.view];
    }else if ([sender.currentTitle isEqualToString:@"文艺消费"]){
        _type = sender.currentTitle;
        [self.view addSubview:self.consumptionOfLiteratureAndArtVC.view];
    }
}
// MARK: --导航栏左侧按钮--
- (void)leftNavBtuAction:(UIButton *)sender{
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 100, 30) title:@"定位中" image:Image(@"loc")];
    [self cllLocation];
}
// MARK: --导航栏右侧按钮--
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
// MARK: --获取当前位置以及城市名--
- (void)cllLocation{
    KGLocationCityManager *manager = [KGLocationCityManager shareManager];
    [manager obtainYourLocation];
    __weak typeof(self) mySelf = self;
    manager.ToObtainYourLocation = ^(NSString *city, double latitude, double longitude) {
        [mySelf setLeftBtuWithFrame:CGRectMake(0, 0, 100, 30) title:city image:Image(@"loc")];
    };
}
// MARK: --创建筛选页面--
- (MapTopScreeningView *)screeningView{
    if (!_screeningView) {
        _screeningView = [[MapTopScreeningView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_screeningView];
    }
    return _screeningView;
}
// MARK: --创建筛选附近的人筛选页面--
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
