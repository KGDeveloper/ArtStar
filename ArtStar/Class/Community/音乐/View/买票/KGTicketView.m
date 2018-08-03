//
//  KGTicketView.m
//  ArtStar
//
//  Created by abc on 2018/6/26.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "KGTicketView.h"

@interface KGTicketView ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation KGTicketView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _titleLab = [[UILabel alloc]initWithFrame:self.bounds];
    _titleLab.text = @"立即购买";
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.font = SYFont(15);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLab];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
