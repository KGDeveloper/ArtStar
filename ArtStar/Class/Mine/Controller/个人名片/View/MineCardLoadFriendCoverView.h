//
//  MineCardLoadFriendCoverView.h
//  ArtStar
//
//  Created by abc on 6/12/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineLoadCoverVC.h"

@interface MineCardLoadFriendCoverView : UIView

@property (nonatomic,copy) void(^popRootViewController)(void);
@property (nonatomic,copy) NSString *coverImage;

@end
