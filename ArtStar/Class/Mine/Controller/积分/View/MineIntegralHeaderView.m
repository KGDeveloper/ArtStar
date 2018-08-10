//
//  MineIntegralHeaderView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineIntegralHeaderView.h"

@interface MineIntegralHeaderView ()

@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIImageView *backView;
@property (nonatomic,strong) UILabel *integralLab;
@property (nonatomic,strong) UIButton *integralBtu;

@end


@implementation MineIntegralHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setHeaderView];
    }
    return self;
}

- (void)setHeaderView{
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _backView = [UIImageView new];
    _integralLab = [UILabel new];
    _integralBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self sd_addSubviews:@[_backView,_leftBtu,_rightBtu,_integralLab,_integralBtu]];
    
    _backView.image = Image(@"jifenbeijing");
    _backView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(ViewWidth(self)).heightIs(ViewHeight(self));
    
    [_leftBtu setTitle:@"积分" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftBtu setImage:Image(@"backwhite") forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYBFont(15);
    _leftBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _leftBtu.titleEdgeInsets = UIEdgeInsetsMake(7.5, _leftBtu.imageView.bounds.size.width + 20, 7.5, 0);
    _leftBtu.imageEdgeInsets = UIEdgeInsetsMake(7.5, 0, 7.5, 0);
    [_leftBtu addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    _leftBtu.sd_layout.leftSpaceToView(self, 15).topSpaceToView(self, NavTopHeight - 40).widthIs(150).heightIs(35);
    
    [_rightBtu setTitle:@"积分兑换" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    _rightBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_rightBtu addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    _rightBtu.sd_layout.rightSpaceToView(self, 15).topSpaceToView(self, NavTopHeight - 40).widthIs(150).heightIs(35);
    
    _integralLab.text = @"3195";
    _integralLab.textColor = [UIColor whiteColor];
    _integralLab.font = SYBFont(33);
    _integralLab.textAlignment = NSTextAlignmentCenter;
    _integralLab.sd_layout.leftSpaceToView(self, 0).rightSpaceToView(self, 0).topSpaceToView(self, NavTopHeight + 20).heightIs(35);
    
    [_integralBtu setTitle:@"积分明细" forState:UIControlStateNormal];
    [_integralBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_integralBtu setImage:Image(@"jifen") forState:UIControlStateNormal];
    _integralBtu.titleLabel.font = SYFont(15);
    _integralBtu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _integralBtu.titleEdgeInsets = UIEdgeInsetsMake(7.5, _leftBtu.imageView.bounds.size.width + 10, 7.5, 0);
    _integralBtu.imageEdgeInsets = UIEdgeInsetsMake(7.5, 0, 7.5, 0);
    [_integralBtu addTarget:self action:@selector(integralAction) forControlEvents:UIControlEventTouchUpInside];
    _integralBtu.layer.cornerRadius = 14;
    _integralBtu.layer.borderColor = [UIColor whiteColor].CGColor;
    _integralBtu.layer.borderWidth = 1;
    _integralBtu.layer.masksToBounds = YES;
    _integralBtu.sd_layout.leftSpaceToView(self, ViewWidth(self)/2 - 52).topSpaceToView(_integralLab,25).widthIs(105).heightIs(28);
    
}
- (void)setCount:(NSInteger)count{
    _count = count;
    _integralLab.text = [NSString stringWithFormat:@"%li",count];
}
- (void)leftAction{
    if (self.doTaskWithTitle) {
        self.doTaskWithTitle(@"返回");
    }
}
- (void)rightAction{
    if (self.doTaskWithTitle) {
        self.doTaskWithTitle(@"积分兑换");
    }
}

- (void)integralAction{
    if (self.doTaskWithTitle) {
        self.doTaskWithTitle(@"积分明细");
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
