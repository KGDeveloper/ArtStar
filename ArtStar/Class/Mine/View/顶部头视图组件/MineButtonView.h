//
//  MineButtonView.h
//  ArtStar
//
//  Created by abc on 6/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineButtonView : UIView

@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) void(^selectButton)(NSString *title);

@end
