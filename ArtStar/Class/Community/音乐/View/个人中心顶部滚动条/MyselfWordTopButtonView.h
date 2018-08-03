//
//  MyselfWordTopButtonView.h
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfWordTopButtonView : UIView

@property (nonatomic,copy) void(^showDiffentView)(NSString *title);
@property (nonatomic,assign) NSInteger btu;

- (instancetype)initWithFrame:(CGRect)frame btuArr:(NSArray *)arr;

@end
