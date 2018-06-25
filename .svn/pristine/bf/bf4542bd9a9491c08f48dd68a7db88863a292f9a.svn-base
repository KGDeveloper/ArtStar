//
//  FriendsDeleteAllMessageView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDeleteAllMessageView.h"

@implementation FriendsDeleteAllMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIView *back = [[UIView alloc]initWithFrame:self.bounds];
    back.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    back.alpha = 0.2;
    [self addSubview:back];
    
    UIButton *deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtu.frame = CGRectMake(0, ViewHeight(self) - 44 - 10 - 50, ViewWidth(self), 50);
    [deleteBtu setTitle:@"清空所有消息" forState:UIControlStateNormal];
    [deleteBtu setTitleColor:[UIColor colorWithHexString:@"#e60000"] forState:UIControlStateNormal];
    deleteBtu.titleLabel.font = SYFont(14);
    [deleteBtu addTarget:self action:@selector(deleteBtuClick) forControlEvents:UIControlEventTouchUpInside];
    deleteBtu.backgroundColor = [UIColor whiteColor];
    deleteBtu.layer.cornerRadius = 5;
    deleteBtu.layer.masksToBounds = YES;
    [self addSubview:deleteBtu];
    
    UIButton *cancelBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtu.frame = CGRectMake(0, ViewHeight(self) - 44, ViewWidth(self), 44);
    [cancelBtu setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    cancelBtu.titleLabel.font = SYFont(13);
    [cancelBtu addTarget:self action:@selector(cancelBtuClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtu.backgroundColor = [UIColor whiteColor];
    cancelBtu.layer.cornerRadius = 5;
    cancelBtu.layer.masksToBounds = YES;
    [self addSubview:cancelBtu];
    
}

- (void)deleteBtuClick{
    if ([self.delegate respondsToSelector:@selector(deleteAllMessage)]) {
        [self.delegate deleteAllMessage];
    }
    self.hidden = YES;
}

- (void)cancelBtuClick{
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
