//
//  MapAllCityScreeningView.h
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapAllCityScreeningView : UIView

@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) void(^sendCityDis)(NSString *cityName);

@end
