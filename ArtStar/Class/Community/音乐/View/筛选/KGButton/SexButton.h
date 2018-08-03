//
//  SexButton.h
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexButton : UIView

@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,strong) UIColor *currColor;
@property (nonatomic,copy) void(^chooseSexAction)(NSString *sex);

@end
