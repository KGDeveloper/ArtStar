//
//  FriednsMessageCell.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriednsMessageCell.h"

@implementation FriednsMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showZansImage{
    self.zansImage.hidden = NO;
    self.detaialLab.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
