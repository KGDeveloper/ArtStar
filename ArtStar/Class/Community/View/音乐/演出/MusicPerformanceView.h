//
//  MusicPerformanceView.h
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicPerformanceView : UIView

@property (nonatomic,copy) void (^pushToDetaialVC)(NSString *ID);
@property (nonatomic,copy) void (^classTypeAction)(NSString *classStr);
@property (nonatomic,copy) NSArray *dataArr;
@property (nonatomic,copy) void (^refreshHeader)(void);
@property (nonatomic,copy) void (^reloadFoot)(NSInteger page);

@end
