//
//  FriendsMessageView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsMessageView.h"

@interface FriendsMessageView ()

@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UILabel *messageLab;

@end

@implementation FriendsMessageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Color_fafafa;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 70, 10, 140, 40)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    backView.layer.cornerRadius = 10;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    UIButton *clickBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtu.frame = backView.frame;
    [clickBtu addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickBtu];
    
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 30, 30)];
    _headImage.image = Image(@"图片加载失败");
    _headImage.layer.cornerRadius = 15;
    _headImage.layer.masksToBounds = YES;
    [backView addSubview:_headImage];
    
    _messageLab = [[UILabel alloc]initWithFrame:CGRectMake(55, 12.5, ViewWidth(backView) - 65, 15)];
    _messageLab.textColor = Color_333333;
    _messageLab.font = SYFont(13);
    _messageLab.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:_messageLab];
}

- (void)setMessStr:(NSString *)messStr{
    _messStr = messStr;
    _messageLab.text = messStr;
}

- (void)clickAction{
    if ([self.delegate respondsToSelector:@selector(loadMessage)]) {
        [self.delegate loadMessage];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
