//
//  FriendsCommentView.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsCommentView.h"

@interface FriendsCommentView ()

@property (nonatomic,strong) UIButton *releaseBtu;

@end

@implementation FriendsCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_ededed;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.commnetView = [[FriendsCustomTextField alloc]initWithFrame:CGRectMake(15, 7.5, ViewWidth(self) - 70, 30)];
    self.commnetView.backgroundColor = [UIColor colorWithHexString:@"#fcfcfc"];
    self.commnetView.font = SYFont(12);
    self.commnetView.layer.cornerRadius = 5;
    self.commnetView.layer.masksToBounds = YES;
    [self addSubview:self.commnetView];
    
    _releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseBtu.frame = CGRectMake(ViewWidth(self) - 55, 0, 40, 45);
    [_releaseBtu setTitle:@"发布" forState:UIControlStateNormal];
    [_releaseBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _releaseBtu.contentHorizontalAlignment = NSTextAlignmentRight;
    _releaseBtu.titleLabel.font = SYFont(12);
    [_releaseBtu addTarget:self action:@selector(releaseClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_releaseBtu];
}

- (void)releaseClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(releaseComment:)]) {
        [self.delegate releaseComment:self.commnetView.text];
    }
    self.hidden = YES;
}

- (void)setPlholder:(NSString *)plholder{
    _plholder = plholder;
    self.commnetView.placeholder = plholder;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
