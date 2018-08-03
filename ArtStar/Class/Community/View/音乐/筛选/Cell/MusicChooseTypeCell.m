//
//  MusicChooseTypeCell.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicChooseTypeCell.h"

@implementation MusicChooseTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.titleLab setHighlightedTextColor:Color_333333];
    }
    // Configure the view for the selected state
}

@end
