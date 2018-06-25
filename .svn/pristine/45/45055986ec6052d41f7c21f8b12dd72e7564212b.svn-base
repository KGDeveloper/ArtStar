//
//  CommunitySmartView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "CommunitySmartView.h"

@interface CommunitySmartView ()

@property (nonatomic,strong) CAShapeLayer *masklayer;
@property (nonatomic,strong) UIBezierPath *layerPath;

@end

@implementation CommunitySmartView

- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr iconArr:(NSArray *)iconArr{
    if (self = [super initWithFrame:frame]) {
        
        [self createLayer];
        [self setUItitleArr:titleArr iconArr:iconArr];
        
    }
    return self;
}

- (void)setUItitleArr:(NSArray *)titleArr iconArr:(NSArray *)iconArr{
    
    for (int i = 0; i < 3; i++) {
        [self addSubview:[self createButtonWithFrame:CGRectMake(0,(ViewHeight(self) - 13)/3*i + 13, ViewWidth(self), (ViewHeight(self) - 13)/3) title:titleArr[i] image:iconArr[i]]];
        
        if (i > 0) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(40, (ViewHeight(self) - 13)/3*i + 13, ViewWidth(self) - 40, 1)];
            line.backgroundColor = Color_ededed;
            [self addSubview:line];
        }
    }
}

- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image{
    UIButton *titleBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtu.frame = frame;
    [titleBtu setTitle:title forState:UIControlStateNormal];
    [titleBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [titleBtu setImage:Image(image) forState:UIControlStateNormal];
    titleBtu.titleLabel.font = SYFont(14);
    [titleBtu setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [titleBtu setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [titleBtu addTarget:self action:@selector(titleBtuClick:) forControlEvents:UIControlEventTouchUpInside];
    return titleBtu;
}

- (void)titleBtuClick:(UIButton *)sender{
    if (self.action) {
        self.action(sender.currentTitle);
    }
    self.hidden = YES;
}

- (void)createLayer{
    _masklayer = [CAShapeLayer layer];
    _layerPath = [UIBezierPath bezierPath];
    
    _masklayer.frame = self.bounds;
    _masklayer.lineWidth = 1;
    
    [_layerPath moveToPoint:CGPointMake(0, 18)];
    [_layerPath addQuadCurveToPoint:CGPointMake(5, 13) controlPoint:CGPointMake(0, 13)];
    [_layerPath addLineToPoint:CGPointMake(ViewWidth(self) - 35, 13)];
    [_layerPath addLineToPoint:CGPointMake(ViewWidth(self) - 25, 0)];
    [_layerPath addLineToPoint:CGPointMake(ViewWidth(self) - 15,13)];
    [_layerPath addLineToPoint:CGPointMake(ViewWidth(self) - 5,13)];
    [_layerPath addQuadCurveToPoint:CGPointMake(ViewWidth(self), 18) controlPoint:CGPointMake(ViewWidth(self), 13)];
    [_layerPath addLineToPoint:CGPointMake(ViewWidth(self),ViewHeight(self) - 5)];
    [_layerPath addQuadCurveToPoint:CGPointMake(ViewWidth(self) - 5, ViewHeight(self)) controlPoint:CGPointMake(ViewWidth(self), ViewHeight(self))];
    [_layerPath addLineToPoint:CGPointMake(5,ViewHeight(self))];
    [_layerPath addQuadCurveToPoint:CGPointMake(0, ViewHeight(self) - 5) controlPoint:CGPointMake(0, ViewHeight(self))];
    [_layerPath addLineToPoint:CGPointMake(0,18)];
    
    _masklayer.fillColor = [UIColor whiteColor].CGColor;
    _masklayer.strokeColor = Color_999999.CGColor;
    _masklayer.masksToBounds = YES;
    
    _masklayer.path = _layerPath.CGPath;
    [self.layer addSublayer:_masklayer];
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
