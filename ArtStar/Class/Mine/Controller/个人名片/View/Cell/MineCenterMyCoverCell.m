//
//  MineCenterMyCoverCell.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineCenterMyCoverCell.h"

@implementation MineCenterMyCoverCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)loadresultAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(pushControllerLoadResult)]) {
        [self.delegate pushControllerLoadResult];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
