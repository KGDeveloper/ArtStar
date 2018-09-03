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
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation LiteratureAndArtVenuesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray array];
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapSelect:) name:@"MapSelect" object:nil];

}
// MARK: --点击事件--
- (void)mapSelect:(NSNotification *)info{
    InstitutionsVC *vc = [[InstitutionsVC alloc]init];
    vc.postID = info.object;
    [self pushNoTabBarViewController:vc animated:YES];
}
// MARK: --请求文化场所首页--
- (void)requestData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:findAllMerchant parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"longitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLongitude"],@"latitude":[[NSUserDefaults standardUserDefaults] objectForKey:@"YourLocationLatitude"]} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            weakSelf.dataArr = [NSMutableArray arrayWithArray:tmp];
            if (weakSelf.dataArr > 0) {
                [weakSelf setMapView];
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --创建地图--
- (void)setMapView{
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    mapView.delegate = self;
    mapView.showsIndoorMap = YES;
    mapView.touchPOIEnabled = YES;
    mapView.rotateEnabled = NO;
    mapView.rotateCameraEnabled = NO;
    [self.view addSubview:mapView];
    
    [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = obj;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([dic[@"latitude"] floatValue], [dic[@"longitude"] floatValue]);
        pointAnnotation.title = [NSString stringWithFormat:@"%@-%@",dic[@"username"],dic[@"id"]];
        pointAnnotation.subtitle = dic[@"blurb"];
        [mapView addAnnotation:pointAnnotation];
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
