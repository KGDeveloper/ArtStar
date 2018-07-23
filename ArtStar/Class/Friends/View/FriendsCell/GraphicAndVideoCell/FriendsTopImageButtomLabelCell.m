//
//  FriendsTopImageButtomLabelCell.m
//  ArtStar
//
//  Created by abc on 5/18/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsTopImageButtomLabelCell.h"

@implementation FriendsTopImageButtomLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)deleteClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.cellIndex];
    }
}
- (IBAction)headerClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.cellIndex];
    }
}
- (IBAction)playClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(playCellVideo:)]) {
        [self.delegate playCellVideo:self.cellIndex];
    }
}
- (IBAction)shareClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.cellIndex];
    }
}
- (IBAction)commentClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.cellIndex];
    }
}
- (IBAction)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:self.cellIndex];
    }
}

- (void)showVideo{
    self.countView.hidden = YES;
    self.countLab.hidden = YES;
    self.imageBtu.hidden = YES;
    self.playView.hidden = NO;
    self.playBtu.hidden = NO;
}
- (void)showGraphic{
    self.countView.hidden = NO;
    self.countLab.hidden = NO;
    self.imageBtu.hidden = NO;
    self.playView.hidden = YES;
    self.playBtu.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
