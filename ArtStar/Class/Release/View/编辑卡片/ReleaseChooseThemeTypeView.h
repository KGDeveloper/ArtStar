//
//  ReleaseChooseThemeTypeView.h
//  ArtStar
//
//  Created by abc on 2018/6/28.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReleaseChooseThemeTypeView : UIView

@property (nonatomic,copy) void(^sendChooseResult)(NSString *result);

@end
