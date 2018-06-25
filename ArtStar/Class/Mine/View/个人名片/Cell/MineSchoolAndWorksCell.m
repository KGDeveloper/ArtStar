//
//  MineSchoolAndWorksCell.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineSchoolAndWorksCell.h"

@implementation MineSchoolAndWorksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)chooseWorks:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(showWorksIndutryView)]) {
        [self.delegate showWorksIndutryView];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
