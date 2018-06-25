//
//  MusicScreeningView.h
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicScreeningView : UIView

@property (nonatomic,copy) void(^sendProvinceNameAndCityName)(NSString *provinceName,NSString *cityName);
@property (nonatomic,copy) void(^sendSexStr)(NSString *sex);
@property (nonatomic,copy) void(^sendTypeStr)(NSString *type);

@end
