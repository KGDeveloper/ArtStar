//
//  MineChooseMyHomeCell.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineChooseMyHomeCell.h"

@implementation MineChooseMyHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.titleLab.textColor = Color_333333;
    // Configure the view for the selected state
}

@end
