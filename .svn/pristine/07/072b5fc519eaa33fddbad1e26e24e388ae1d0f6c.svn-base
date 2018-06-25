//
//  MineSetUpChangePhoneTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineSetUpChangePhoneTableViewCell.h"

@implementation MineSetUpChangePhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)passWordAudit:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(changeYourPhone:)]) {
        [self.delegate changeYourPhone:@"密码认证"];
    }
}
- (IBAction)SMSAudit:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(changeYourPhone:)]) {
        [self.delegate changeYourPhone:@"短信认证"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
