//
//  FriendsThemeButtomImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsThemeButtomImageCell.h"

@implementation FriendsThemeButtomImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)headerClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.cellIndex];
    }
}

- (IBAction)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.cellIndex];
    }
}
- (IBAction)allIamgeClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(lookAllCellImage:)]) {
        [self.delegate lookAllCellImage:self.cellIndex];
    }
}
- (IBAction)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.cellIndex];
    }
}
- (IBAction)commentClick:(id)sender {
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
