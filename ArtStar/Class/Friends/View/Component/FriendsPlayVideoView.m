//
//  FriendsPlayVideoView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsPlayVideoView.h"

@interface FriendsPlayVideoView ()

@property (nonatomic,strong) UIImageView *topImage;

@end

@implementation FriendsPlayVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _topImage = [[UIImageView alloc]initWithFrame:self.bounds];
    _topImage.image = Image(@"图片加载失败");
    [self addSubview:_topImage];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 20, ViewHeight(self)/2 - 20, 40, 40)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    backView.alpha = 0.4;
    backView.layer.cornerRadius = 20;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    UIButton *playBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    playBtu.frame = backView.frame;
    [playBtu setImage:Image(@"播放按钮") forState:UIControlStateNormal];
    playBtu.layer.cornerRadius = 20;
    playBtu.layer.borderWidth = 1;
    playBtu.layer.borderColor = [UIColor colorWithHexString:@"#ffffff"].CGColor;
    playBtu.layer.masksToBounds = YES;
    [playBtu addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playBtu];
}

- (void)playVideo{
    if ([self.delegate respondsToSelector:@selector(playModelVideo)]) {
        [self.delegate playModelVideo];
    }
}

- (void)setVideoIamge:(UIImage *)videoIamge{
    _videoIamge = videoIamge;
    _topImage.image = videoIamge;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
