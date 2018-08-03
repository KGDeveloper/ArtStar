//
//  MusicDetaialBtu.h
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicDetaialBtu : UIView

@property (nonatomic,copy) NSString *btuImage;
@property (nonatomic,copy) NSString *btuTitle;
@property (nonatomic,copy) void (^actionClick)(void);

@end
