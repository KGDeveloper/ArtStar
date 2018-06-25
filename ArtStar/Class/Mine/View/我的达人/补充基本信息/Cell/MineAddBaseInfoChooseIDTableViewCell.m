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
    // Initialization code
}
- (IBAction)chooseCardClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(showChooseCardView)]) {
        [self.delegate showChooseCardView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
