//
//  ReadBooksHeaderViewCell.m
//  ArtStar
//
//  Created by abc on 6/5/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "ReadBooksHeaderViewCell.h"

@implementation ReadBooksHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (IBAction)returnView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(popViewControler)]) {
        [self.delegate popViewControler];
    }
}
- (IBAction)shareView:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareBooks)]) {
        [self.delegate shareBooks];
    }
}
- (IBAction)wantRead:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sendMyIdea:)]) {
        [self.delegate sendMyIdea:@"想读"];
    }
}
- (IBAction)readIngAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sendMyIdea:)]) {
        [self.delegate sendMyIdea:@"在读"];
    }
}
- (IBAction)readedAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sendMyIdea:)]) {
        [self.delegate sendMyIdea:@"读过：评分"];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
