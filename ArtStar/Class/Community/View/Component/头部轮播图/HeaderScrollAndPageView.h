//
//  HeaderScrollAndPageView.h
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HeaderStyle){
    HeaderStyleHeadLines,
    HeaderStyleOther,
};

@interface HeaderScrollAndPageView : UIView

@property (nonatomic,copy) NSArray *imageArr;
@property (nonatomic,copy) void(^classTypeAction)(NSString *type);

- (instancetype)initWithFrame:(CGRect)frame style:(HeaderStyle)style;

@end
