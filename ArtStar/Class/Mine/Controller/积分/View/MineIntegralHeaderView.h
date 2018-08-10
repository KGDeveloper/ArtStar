//
//  MineIntegralHeaderView.h
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineIntegralHeaderView : UIView

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) void(^doTaskWithTitle)(NSString *title);

@end
