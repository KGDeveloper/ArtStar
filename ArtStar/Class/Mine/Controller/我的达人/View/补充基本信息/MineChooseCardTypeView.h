//
//  MineChooseCardTypeView.h
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineChooseCardTypeView : UIView

@property (nonatomic,copy) void(^sendIDcardType)(NSString *type);

@end
