//
//  MineIntegraltableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineIntegraltableViewCell.h"

@implementation MineIntegraltableViewCell

- (IBAction)doTask:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(clickBtuToDoSomeThing:)]) {
        [self.delegate clickBtuToDoSomeThing:[[_titleLab.text componentsSeparatedByString:@" "] firstObject]];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
