//
//  HeadLinesDetaialCommentCell.m
//  ArtStar
//
//  Created by abc on 5/25/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesDetaialCommentCell.h"

@implementation HeadLinesDetaialCommentCell


- (IBAction)zansAction:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(zansCommentWithID:withStyle:)]) {
            [self.delegate zansCommentWithID:_cellID withStyle:@"1"];
        }
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(zansCommentWithID:withStyle:)]) {
            [self.delegate zansCommentWithID:_cellID withStyle:@"0"];
        }
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
