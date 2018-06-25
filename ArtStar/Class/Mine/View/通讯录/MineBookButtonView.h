//
//  MineBookButtonView.h
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineBookButtonView : UIView

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,strong) UIColor *btuColor;
@property (nonatomic,copy) void(^touchUpInside)(void);

@end
