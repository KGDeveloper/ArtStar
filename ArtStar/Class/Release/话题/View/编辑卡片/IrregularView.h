//
//  IrregularView.h
//  ArtStar
//
//  Created by abc on 5/7/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendTitle)(NSString *title);

@interface IrregularView : UIView

@property (nonatomic,copy) SendTitle sendStr;

@end
