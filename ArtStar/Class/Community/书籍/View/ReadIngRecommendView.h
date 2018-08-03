//
//  ReadIngRecommendView.h
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadIngRecommendView : UIView

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSArray *bookArr;

@property (nonatomic,copy) void(^pushReadBooskHotVC)(void);

@end
