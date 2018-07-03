//
//  FriendsTalentDetailHeaderView.m
//  ArtStar
//
//  Created by abc on 2018/7/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "FriendsTalentDetailHeaderView.h"

@implementation FriendsTalentDetailHeaderView

+ (instancetype)initWithView{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FriendsTalentDetailHeaderView" owner:self options:nil];
    FriendsTalentDetailHeaderView *view = [arr firstObject];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
