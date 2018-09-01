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

@interface AcitivityForViewController ()<MAMapViewDelegate>

@property (nonatomic,strong) ViewForActivity *activityView;

@end

@implementation AcitivityForViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavBackGroundClearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setButton];
    [self setMapView];
}
// MARK: --创建地图--
- (void)setMapView{
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"测试点";
    pointAnnotation.subtitle = @"这是展览";
    [mapView addAnnotation:pointAnnotation];
}
// MARK: --MAMapViewDelegate--
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
//        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
//        titleLab.text = @"这是艺术馆";
//        titleLab.font = SYFont(12);
//        titleLab.textColor = Color_333333;
//        titleLab.textAlignment = NSTextAlignmentCenter;
        NSString *string = @"这是艺术馆";
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
        [paragraphStyle setLineSpacing:2.0f];  //行间距
        [paragraphStyle setParagraphSpacing:2.f];//字符间距
        NSDictionary *attributes = @{NSFontAttributeName            : [UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName : [UIColor blueColor],
                                     NSBackgroundColorAttributeName : [UIColor clearColor],
                                     NSParagraphStyleAttributeName : paragraphStyle, };

        annotationView.image = [self imageFromString:string attributes:attributes size:CGSizeMake(40, 20)];
        annotationView.canShowCallout = NO;
        annotationView.centerOffset = CGPointMake(0, -20);
        return annotationView;
    }
    return nil;
}
- (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [string drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)imageForView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    else
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
