//
//  CancelFocusView.h
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CancelFocusModel;
@interface CancelFocusView : UIView

@property (nonatomic,copy) void(^focusOn)(void);
@property (nonatomic,copy) CancelFocusModel *model;

@end

@interface CancelFocusModel : NSObject

@property (nonatomic,copy) NSString *nikName;
@property (nonatomic,copy) NSString *status;


@end
