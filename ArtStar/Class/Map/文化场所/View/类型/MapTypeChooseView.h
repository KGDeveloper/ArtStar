//
//  MapTypeChooseView.h
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MapType){MapTypeInstitutions = 0,MapTypeConsumption};

@interface MapTypeChooseView : UIView

@property (nonatomic,assign) MapType mytype;
@property (nonatomic,copy) void(^sendChooseTypeID)(NSString *typeID);

- (instancetype)initWithFrame:(CGRect)frame type:(MapType)type;

@end
