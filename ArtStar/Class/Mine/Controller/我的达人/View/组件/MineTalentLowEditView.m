//
//  MineTalentLowEditView.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineTalentLowEditView.h"

@interface MineTalentLowEditView ()

@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;

@end

@implementation MineTalentLowEditView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(0, 0, 100, ViewHeight(self));
    _leftBtu.titleLabel.font = SYFont(14);
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_leftBtu setImage:Image(@"编辑未选中状态") forState:UIControlStateNormal];
    _leftBtu.titleEdgeInsets = UIEdgeInsetsMake(0, _leftBtu.imageView.frame.size.width + 20, 0, 0);
    [_leftBtu addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(100, 0, ViewWidth(self) - 100, ViewHeight(self));
    _rightBtu.titleLabel.font = SYFont(14);
    [_rightBtu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_rightBtu addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtu];
}
- (void)leftAction:(UIButton *)sender{
    if ([sender.currentImage isEqual:Image(@"编辑未选中状态")]) {
        [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
        if (self.chooseAllCell) {
            self.chooseAllCell(@"全选");
        }
    }else{
        [sender setImage:Image(@"编辑未选中状态") forState:UIControlStateNormal];
        if (self.chooseAllCell) {
            self.chooseAllCell(@"取消全选");
        }
    }
}
- (void)rightAction:(UIButton *)sender{
    if (self.deleteChooseCell) {
        self.deleteChooseCell(_detailStr);
    }
}
- (void)setTitle:(NSString *)title{
    _title = title;
    [_leftBtu setTitle:title forState:UIControlStateNormal];
}
- (void)setDetailStr:(NSString *)detailStr{
    _detailStr = detailStr;
    [_rightBtu setTitle:detailStr forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
