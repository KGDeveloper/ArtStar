//
//  KGLocationCityManager.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGLocationCityManager.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface KGLocationCityManager ()<AMapLocationManagerDelegate,AMapSearchDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) AMapSearchAPI *search;
@property (nonatomic,strong) CLLocationManager *cllLocationManager;

@end

@implementation KGLocationCityManager

+ (KGLocationCityManager *)shareManager{
    static KGLocationCityManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[KGLocationCityManager alloc]init];
        }
    });
    return manager;
}

- (void)obtainYourLocation{
    _cllLocationManager = [[CLLocationManager alloc]init];
    _cllLocationManager.delegate = self;
    [_cllLocationManager requestAlwaysAuthorization];
    [_cllLocationManager requestWhenInUseAuthorization];
    _cllLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _cllLocationManager.distanceFilter = 10.0;
    [_cllLocationManager startUpdatingLocation];
    
//    [AMapServices sharedServices].apiKey = GeocodeApiKey;
//    self.locationManager = [[AMapLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    [self.locationManager setDistanceFilter:10.0f];
//    self.locationManager.locatingWithReGeocode = YES;
//    self.locationManager.allowsBackgroundLocationUpdates = YES;
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [_cllLocationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    NSTimeInterval locationAge = [currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"YourLocationLatitude"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"YourLocationLongitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *cityName = placeMark.locality;
            if (!cityName) {
                [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"yourLocationCity"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            if (self.ToObtainYourLocation) {
                self.ToObtainYourLocation(cityName,currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
            }
        }
    }];
}
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
//    CLLocation *newLocation = location;
//    CLLocationCoordinate2D coordinate = newLocation.coordinate;
//    self.search = [[AMapSearchAPI alloc] init];
//    self.search.delegate = self;
//    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
//    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
//    regeo.requireExtension = YES;
//    [self.search AMapReGoecodeSearch:regeo];
//}
//- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
//
//}
///* 逆地理编码回调. */
//- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
//    if (response.regeocode != nil){
//        [[NSUserDefaults standardUserDefaults] setObject:response.regeocode.addressComponent.city forKey:@"yourLocationCity"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",request.location.latitude] forKey:@"YourLocationLatitude"];
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",request.location.longitude] forKey:@"YourLocationLongitude"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        if (self.ToObtainYourLocation) {
//            self.ToObtainYourLocation(response.regeocode.addressComponent.city,request.location.latitude,request.location.longitude);
//        }
//    }
//    [self.locationManager stopUpdatingLocation];
//}

@end
