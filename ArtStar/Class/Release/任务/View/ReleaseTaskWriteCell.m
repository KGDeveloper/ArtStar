//
//  ReleaseTaskWriteCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseTaskWriteCell.h"

@implementation ReleaseTaskWriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleText.delegate = self;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
