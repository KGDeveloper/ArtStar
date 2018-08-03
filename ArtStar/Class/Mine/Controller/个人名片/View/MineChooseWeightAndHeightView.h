//
//  MineChooseWeightAndHeightView.h
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ChooseType){ChooseHeight = 0,ChooseWeight};

@interface MineChooseWeightAndHeightView : UIView

@property (nonatomic,assign) ChooseType type;
@property (nonatomic,assign) CGFloat minValue;
@property (nonatomic,assign) CGFloat maxValue;
@property (nonatomic,copy) NSString *unitStr;
@property (nonatomic,copy) void(^sendValueToController)(ChooseType type,NSString *value);

@end
