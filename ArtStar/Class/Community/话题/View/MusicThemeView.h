//
//  MusicThemeView.h
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicThemeView : UIView

@property (nonatomic,copy) void(^pushViewController)(void);
@property (nonatomic,copy) NSString *titleName;

@end
