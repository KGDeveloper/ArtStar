//
//  SexButton.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "SexButton.h"

@interface SexButton ()

@property (nonatomic,strong) UIImageView *topImage;
@property (nonatomic,strong) UILabel *lowTitle;

@end

@implementation SexButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBtu];
    }
    return self;
}

- (void)setBtu{
    _topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewWidth(self))];
    [self addSubview:_topImage];
    
    _lowTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewWidth(self) + 10, ViewWidth(self), ViewHeight(self) - ViewWidth(self) - 10)];
    _lowTitle.textColor = Color_999999;
    _lowTitle.textAlignment = NSTextAlignmentCenter;
    _lowTitle.font = SYFont(14);
    [self addSubview:_lowTitle];
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = imageStr;
    _topImage.image = Image(imageStr);
}
- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _lowTitle.text = titleStr;
}
- (void)setCurrColor:(UIColor *)currColor{
    _currColor = currColor;
    _lowTitle.textColor = currColor;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.chooseSexAction) {
        self.chooseSexAction(self.titleStr);
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
