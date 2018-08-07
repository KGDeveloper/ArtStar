//
//  MinePushIDCardTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MinePushIDCardTableViewCell.h"

@implementation MinePushIDCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)leftAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(chooseImage:)]) {
        if ([_titleLab.text isEqualToString:@"上传以下证件材料(例如工牌等)"]) {
            [self.delegate chooseImage:@"证明"];
        }else{
            [self.delegate chooseImage:@"正面"];
        }
    }
}
- (IBAction)rightAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(chooseImage:)]) {
        [self.delegate chooseImage:@"反面"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
