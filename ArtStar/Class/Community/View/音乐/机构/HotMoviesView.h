//
//  HotMoviesView.h
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotMoviesView : UIView

@property (nonatomic,copy) NSArray *moviesArr;
@property (nonatomic,copy) void (^pushViewController)(void);

@end
