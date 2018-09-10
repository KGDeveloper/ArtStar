//
//  AcitivityForViewController.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/31.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "AcitivityForViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CustomAnnotationView.h"
#import "InstitutionsVC.h"

@interface AcitivityForViewController ()<MAMapViewDelegate>

@property (nonatomic,strong) ViewForActivity *activityView;
@property (nonatomic,copy) NSArray *searchArr;
@property (nonatomic,strong) MAMapView *mapView;

@end

@implementation AcitivityForViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBackGroundClearColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapSelect:) name:@"MapSelect" object:nil];
    
    [self requestList];
    [self setButton];
}
// MARK: --创建地图--
- (void)setMapView{
    [AMapServices sharedServices].enableHTTPS = YES;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.mapView.delegate = self;
    self.mapView.showsIndoorMap = YES;
    self.mapView.touchPOIEnabled = YES;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    [self.view insertSubview:self.mapView atIndex:1];
    
    __weak typeof(self) weakSelf = self;
    [_searchArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] floatValue], [dic[@"longitude"] floatValue]);
        pointAnnotation.title = [NSString stringWithFormat:@"%@-%@",dic[@"username"],dic[@"id"]];
        if (![dic[@"blurb"] isKindOfClass:[NSNull class]]){
            pointAnnotation.subtitle = dic[@"blurb"];
        }else{
            pointAnnotation.subtitle = @"";
        }
        [weakSelf.mapView addAnnotation:pointAnnotation];
    }];
}
// MARK: --MAMapViewDelegate--
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.image = Image(@"定位场所");
        annotationView.canShowCallout = NO;
        annotationView.centerOffset = CGPointMake(0, -20);
        return annotationView;
    }
    return nil;
}
// MARK: --点击事件--
- (void)mapSelect:(NSNotification *)info{
    if (info.object != nil) {
        InstitutionsVC *vc = [[InstitutionsVC alloc]init];
        vc.postID = info.object;
        vc.url = selectPlaceById;
        [self pushNoTabBarViewController:vc animated:YES];
    }
}
// MARK: --创建右侧点击按钮--
- (void)setButton{
    UIButton *rulesBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    rulesBtu.frame = CGRectMake(kScreenWidth - 75, NavTopHeight + 50, 60, 25);
    [rulesBtu setTitle:@"活动规则" forState:UIControlStateNormal];
    [rulesBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    rulesBtu.titleLabel.font = SYFont(12);
    rulesBtu.backgroundColor = Color_fafafa;
    rulesBtu.layer.cornerRadius = 5;
    rulesBtu.layer.masksToBounds = YES;
    [rulesBtu addTarget:self action:@selector(rulesAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:rulesBtu atIndex:99];
    
    UIButton *clockBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    clockBtu.frame = CGRectMake(kScreenWidth - 75, NavTopHeight + 85, 60, 25);
    [clockBtu setTitle:@"打卡记录" forState:UIControlStateNormal];
    [clockBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    clockBtu.titleLabel.font = SYFont(12);
    clockBtu.backgroundColor = Color_fafafa;
    clockBtu.layer.cornerRadius = 5;
    clockBtu.layer.masksToBounds = YES;
    [clockBtu addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:clockBtu atIndex:99];
    
    UIButton *prizeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    prizeBtu.frame = CGRectMake(kScreenWidth - 75, NavTopHeight + 120, 60, 25);
    [prizeBtu setTitle:@"关于奖品" forState:UIControlStateNormal];
    [prizeBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    prizeBtu.titleLabel.font = SYFont(12);
    prizeBtu.backgroundColor = Color_fafafa;
    prizeBtu.layer.cornerRadius = 5;
    prizeBtu.layer.masksToBounds = YES;
    [prizeBtu addTarget:self action:@selector(prizeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:prizeBtu atIndex:99];
}
// MARK: --活动规则点击事件--
- (void)rulesAction{
    self.activityView.hidden = NO;
    self.activityView.showImage = Image(@"活动规则");
    self.activityView.alertType = ActivityTypeRules;
}
// MARK: --打卡记录点击事件--
- (void)clickAction{
    self.activityView.hidden = NO;
    self.activityView.showImage = Image(@"打卡记录");
    self.activityView.alertType = ActivityTypeClick;
}
// MARK: --关于奖品点击事件--
- (void)prizeAction{
    self.activityView.hidden = NO;
    self.activityView.showImage = Image(@"关于奖品");
    self.activityView.alertType = ActivityTypePrize;
}
// MARK: --活动页面--
- (ViewForActivity *)activityView{
    if (!_activityView) {
        _activityView = [[ViewForActivity alloc]initWithFrame:self.view.bounds];
        [self.tabBarController.view addSubview:_activityView];
    }
    return _activityView;
}

- (void)requestList{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:seleteMerchantsListByAid parameters:@{@"id":@"11",@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if([result[@"code"] integerValue] == 200){
            weakSelf.searchArr = result[@"data"];
            [weakSelf setMapView];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
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
