//
//  ActivityCellTableViewCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/9/7.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ActivityCellTableViewCell.h"

@implementation ActivityCellTableViewCell

- (void)setFrame:(CGRect)frame{
    frame.size.height = 40;
    [super setFrame:frame];
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
