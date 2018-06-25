//
//  MusicDetaialBtu.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicDetaialBtu.h"

@interface MusicDetaialBtu ()

@property (nonatomic,strong) UIImageView *btuImageView;
@property (nonatomic,strong) UILabel *btuTitleLab;

@end

@implementation MusicDetaialBtu

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createBtu];
    }
    return self;
}

- (void)createBtu{
    _btuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewWidth(self))];
    [self addSubview:_btuImageView];
    
    _btuTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewWidth(self) + 5, ViewWidth(self), ViewHeight(self) - ViewWidth(self) - 5)];
    _btuTitleLab.textColor = [UIColor whiteColor];
    _btuTitleLab.font = SYFont(9);
    _btuTitleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_btuTitleLab];
}

- (void)setBtuImage:(NSString *)btuImage{
    _btuImage = btuImage;
    _btuImageView.image = Image(btuImage);
}

- (void)setBtuTitle:(NSString *)btuTitle{
    _btuTitle = btuTitle;
    _btuTitleLab.text = btuTitle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.actionClick) {
        self.actionClick();
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
