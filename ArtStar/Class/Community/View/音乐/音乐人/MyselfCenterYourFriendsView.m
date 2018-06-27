//
//  MyselfCenterYourFriendsView.m
//  ArtStar
//
//  Created by abc on 2018/6/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MyselfCenterYourFriendsView.h"

@implementation MyselfCenterYourFriendsView

+ (MyselfCenterYourFriendsView *)initView{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"MyselfCenterYourFriendsView" owner:self options:nil];
    return nibView[0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
