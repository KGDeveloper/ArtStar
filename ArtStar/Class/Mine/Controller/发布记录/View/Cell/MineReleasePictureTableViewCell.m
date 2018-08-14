//
//  MineReleasePictureTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineReleasePictureTableViewCell.h"

@implementation MineReleasePictureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteAction:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"编辑未选中状态")]) {
        [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(sendDeleteIDtoView:style:)]) {
            [self.delegate sendDeleteIDtoView:_ID style:0];
        }
    }else{
        [sender setImage:Image(@"编辑未选中状态") forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(sendDeleteIDtoView:style:)]) {
            [self.delegate sendDeleteIDtoView:_ID style:1];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
