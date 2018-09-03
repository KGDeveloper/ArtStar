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

@interface KGLocationCityManager ()<AMapLocationManagerDelegate,AMapSearchDelegate>

@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) AMapSearchAPI *search;

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
    [AMapServices sharedServices].apiKey = GeocodeApiKey;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setDistanceFilter:10.0f];
    self.locationManager.locatingWithReGeocode = YES;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    [self.locationManager setLocatingWithReGeocode:YES];
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    CLLocation *newLocation = location;
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];
}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    if (response.regeocode != nil){
        if (self.ToObtainYourLocation) {
            self.ToObtainYourLocation(response.regeocode.addressComponent.city,request.location.latitude,request.location.longitude);
            [[NSUserDefaults standardUserDefaults] setObject:response.regeocode.addressComponent.city forKey:@"yourLocationCity"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",request.location.latitude] forKey:@"YourLocationLatitude"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",request.location.longitude] forKey:@"YourLocationLongitude"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

@end
