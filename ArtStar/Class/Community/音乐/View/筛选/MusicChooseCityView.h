//
//  MusicChooseCityView.h
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicChooseCityView : UIView

@property (nonatomic,copy) void(^sendProvinceNameAndCityName)(NSString *provinceName,NSString *cityName);

@end
