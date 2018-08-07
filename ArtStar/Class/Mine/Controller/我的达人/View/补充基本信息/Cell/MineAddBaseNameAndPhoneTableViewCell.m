//
//  MineAddBaseNameAndPhoneTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineAddBaseNameAndPhoneTableViewCell.h"

@implementation MineAddBaseNameAndPhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _nameTF.delegate = self;
    _phoneTF.delegate = self;
    // Initialization code
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_nameTF]) {
        if (textField.text.length < 1) {
            [MBProgressHUD bwm_showTitle:@"请输入正确姓名" toView:self hideAfter:1];
        }else{
            if ([self.delegate respondsToSelector:@selector(sendYourNameTelephone:phone:)]) {
                [self.delegate sendYourNameTelephone:textField.text phone:nil];
            }
        }
    }else{
        if (textField.text.length != 11) {
            [MBProgressHUD bwm_showTitle:@"请输入正确手机号" toView:self hideAfter:1];
        }else{
            if ([self.delegate respondsToSelector:@selector(sendYourNameTelephone:phone:)]) {
                [self.delegate sendYourNameTelephone:nil phone:textField.text];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
