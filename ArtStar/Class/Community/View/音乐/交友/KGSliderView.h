//
//  KGSliderView.h
//  ArtStar
//
//  Created by abc on 6/4/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGSliderView : UIView

@property (nonatomic,assign) CGFloat minValue;
@property (nonatomic,assign) CGFloat maxValue;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *unitStr;
@property (nonatomic,copy) void(^sendValueToFormView)(NSString *str);

@end
