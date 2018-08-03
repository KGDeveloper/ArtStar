//
//  YourLocationVC.h
//  ArtStar
//
//  Created by abc on 5/14/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "BaseVC.h"

@interface YourLocationVC : BaseVC
//:--点击cell后回调，传位置--
@property (nonatomic,copy) void (^nowLocation)(NSString *location);

@end
