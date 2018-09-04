//
//  LiteratureAndArtVenuesVC.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/9/1.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "LiteratureAndArtVenuesVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CustomAnnotationView.h"
#import "InstitutionsVC.h"

@interface LiteratureAndArtVenuesVC ()<MAMapViewDelegate>

@property (nonatomic,strong) ViewForActivity *activityView;
@property (nonatomic,strong) MAMapView *mapView;

@end

@implementation LiteratureAndArtVenuesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapSelect:) name:@"MapSelect" object:nil];

}
// MARK: --点击事件--
- (void)mapSelect:(NSNotification *)info{
    InstitutionsVC *vc = [[InstitutionsVC alloc]init];
    vc.postID = info.object;
    vc.url = findOneMerchant;
    [self pushNoTabBarViewController:vc animated:YES];
}
// MARK: --请求文化场所首页--
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findAllMerchant parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
            [weakSelf setMapView];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --创建地图--
- (void)setMapView{
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.mapView.delegate = self;
    self.mapView.showsIndoorMap = YES;
    self.mapView.touchPOIEnabled = YES;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    [self.view addSubview:self.mapView];
    
    [_searchArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] floatValue], [dic[@"longitude"] floatValue]);
        pointAnnotation.title = [NSString stringWithFormat:@"%@-%@",dic[@"username"],dic[@"id"]];
        pointAnnotation.subtitle = dic[@"blurb"];
        [self.mapView addAnnotation:pointAnnotation];
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

- (void)setSearchArr:(NSArray *)searchArr{
    _searchArr = searchArr;
    [self.mapView removeFromSuperview];
    [self setMapView];
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
