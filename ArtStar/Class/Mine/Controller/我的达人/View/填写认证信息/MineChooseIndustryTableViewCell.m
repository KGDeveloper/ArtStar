//
//  MineChooseIndustryTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChooseIndustryTableViewCell.h"

@implementation MineChooseIndustryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)touchChooseBtu:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(showIndustryViewChooseJob)]) {
        [self.delegate showIndustryViewChooseJob];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
