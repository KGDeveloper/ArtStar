//
//  MineFeedBackChooseTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineFeedBackChooseTableViewCell.h"

@implementation MineFeedBackChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)oneClick:(UIButton *)sender {
    [self changeButtonTitle];
    [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(sendChooseResonToController:)]) {
        [self.delegate sendChooseResonToController:sender.currentTitle];
    }
}
- (IBAction)twoClick:(UIButton *)sender {
    [self changeButtonTitle];
    [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(sendChooseResonToController:)]) {
        [self.delegate sendChooseResonToController:sender.currentTitle];
    }
}
- (IBAction)threeClick:(UIButton *)sender {
    [self changeButtonTitle];
    [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(sendChooseResonToController:)]) {
        [self.delegate sendChooseResonToController:sender.currentTitle];
    }
}
- (IBAction)fourClick:(UIButton *)sender {
    [self changeButtonTitle];
    [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(sendChooseResonToController:)]) {
        [self.delegate sendChooseResonToController:sender.currentTitle];
    }
}
- (IBAction)fiveClick:(UIButton *)sender {
    [self changeButtonTitle];
    [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(sendChooseResonToController:)]) {
        [self.delegate sendChooseResonToController:sender.currentTitle];
    }
}
- (IBAction)otherClick:(UIButton *)sender {
    [self changeButtonTitle];
    [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(sendChooseResonToController:)]) {
        [self.delegate sendChooseResonToController:sender.currentTitle];
    }
}

- (void)changeButtonTitle{
    for (id obj in self.contentView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *nor = obj;
            [nor setImage:Image(@"编辑未选中状态") forState:UIControlStateNormal];
        }
    }
}

@end
