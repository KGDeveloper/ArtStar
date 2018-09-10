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
#import <AMapSearchKit/AMapSearchKit.h>

@interface LiteratureAndArtVenuesVC ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,strong) ViewForActivity *activityView;
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) AMapSearchAPI *search;

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
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
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
// MARK: ----
- (void)sendchooseType:(NSString *)type chooseStr:(NSString *)chooseStr{
    if ([type isEqualToString:@"地区"]) {
        [AMapServices sharedServices].apiKey = GeocodeApiKey;
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
        AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc]init];
        geo.address = chooseStr;
        [_search AMapGeocodeSearch:geo];
    }else if([type isEqualToString:@"类型"]) {
        [self requestTypeForMerchants:chooseStr];
    }else if ([type isEqualToString:@"距离"]){
        if ([chooseStr isEqualToString:@"离我最近"]) {
            [self requestData];
        }else if ([chooseStr isEqualToString:@"价格最低"]){
            [self requestWithPrice];
        }else{
            [self requestWithScore];
        }
    }else{
        if ([chooseStr isEqualToString:@"接受预定"]) {
            [self requestWithReservation];
        }else{
            [self requestWithNewProduct];
        }
    }
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    if (error) {
        [MBProgressHUD bwm_showTitle:@"查询失败" toView:self.view hideAfter:1];
    }
}
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.geocodes.count == 0) {
        return;
    }
    AMapGeocode *geocode = [response.geocodes firstObject];
    AMapGeoPoint *geopoint = geocode.location;
    [self requestLiterature:[NSString stringWithFormat:@"%f",geopoint.latitude] longitude:[NSString stringWithFormat:@"%f",geopoint.longitude]];
}
// MARK: --根据指定类型搜索附近商家--
- (void)requestTypeForMerchants:(NSString *)merchansType{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findPreciseMerchant parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"merchansType":merchansType,@"longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --根据指定位置搜索附近商家--
- (void)requestLiterature:(NSString *)latitude longitude:(NSString *)longitude{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findPlaceMerchants parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"longitude":longitude,@"latitude":latitude} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --根据商家的人均消费来升序展示商家--
- (void)requestWithPrice{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findMerchantAverageConsumption parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --根据商家的评分来降序展示商家--
- (void)requestWithScore{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findmerchantsScore parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --展示能够接受预定的商家--
- (void)requestWithReservation{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findReservemerchants parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --查询有新品上市的商家--
- (void)requestWithNewProduct{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findmerchantsNewProduct parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.searchArr = result[@"data"];
        }else{
            [MBProgressHUD bwm_showTitle:@"暂无数据" toView:weakSelf.view hideAfter:1];
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
