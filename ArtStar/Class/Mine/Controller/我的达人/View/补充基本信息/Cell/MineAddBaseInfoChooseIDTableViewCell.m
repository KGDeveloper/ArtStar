//
//  MineAddBaseInfoChooseIDTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineAddBaseInfoChooseIDTableViewCell.h"

@implementation MineAddBaseInfoChooseIDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cardTF.delegate = self;
    // Initialization code
}
- (IBAction)chooseCardClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(showChooseCardView)]) {
        [self.delegate showChooseCardView];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length < 1) {
        [MBProgressHUD bwm_showTitle:@"请输入合格证件号" toView:self hideAfter:1];
    }else{
        if ([self.delegate respondsToSelector:@selector(sendIDCardNumber:)]) {
            [self.delegate sendIDCardNumber:textField.text];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
