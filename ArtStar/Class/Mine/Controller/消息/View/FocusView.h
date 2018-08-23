//
//  FocusView.h
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FocusViewModel;
@interface FocusView : UIView

@property (nonatomic,copy) void(^cancelFocus)(void);
@property (nonatomic,copy) FocusViewModel *model;
@property (nonatomic,copy) NSDictionary *userInfo;//:--设置权限问题--
@property (nonatomic,copy) NSString *userId;

@end

@interface FocusViewModel : NSObject

@property (nonatomic,copy) NSString *nikName;
@property (nonatomic,copy) NSString *status;


@end


