//
//  CommunitySmartView.h
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunitySmartView : UIView

@property (nonatomic,copy) void(^action)(NSString *title);

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr iconArr:(NSArray *)iconArr;

@end
