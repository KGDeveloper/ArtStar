//
//  MusicInstitutionsView.h
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MusicInstitutionsViewDelegate <NSObject>

- (void)loadHotMovies;

@end

@interface MusicInstitutionsView : UIView

@property (nonatomic,copy) NSString *urlName;
@property (nonatomic,copy) NSString *chooseStyle;
@property (nonatomic,copy) void (^pushViewController)(void);
@property (nonatomic,weak) id<MusicInstitutionsViewDelegate>delegate;

@end
