//
//  MapSpaceToYourView.h
//  ArtStar
//
//  Created by abc on 2018/6/21.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapSpaceToYourView : UIView

@property (nonatomic,copy) void(^sendSpace)(NSString *space);

@end
