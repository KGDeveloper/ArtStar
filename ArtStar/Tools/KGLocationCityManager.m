//
//  KGLocationCityManager.m
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGLocationCityManager.h"
#import <CoreLocation/CoreLocation.h>

@interface KGLocationCityManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

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
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10.0f;
    if (![CLLocationManager locationServicesEnabled]) {
        
    }
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestAlwaysAuthorization];
            }
            break;
            
        default:
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    if (self.ToObtainYourLocation) {
        self.ToObtainYourLocation(@"北京市",coordinate.latitude,coordinate.longitude);
        [[NSUserDefaults standardUserDefaults] setObject:@"北京市" forKey:@"yourLocationCity"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",coordinate.latitude] forKey:@"YourLocationLatitude"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",coordinate.longitude] forKey:@"YourLocationLongitude"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    CLGeocoder *geocder = [[CLGeocoder alloc]init];
    [geocder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSString *city = place.locality;
            if (!city) {
                city = place.administrativeArea;
            }
            if (self.ToObtainYourLocation) {
                self.ToObtainYourLocation(city,newLocation.coordinate.latitude,newLocation.coordinate.longitude);
            }
            [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"yourLocationCity"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:@"YourLocationLatitude"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:@"YourLocationLongitude"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}


@end
