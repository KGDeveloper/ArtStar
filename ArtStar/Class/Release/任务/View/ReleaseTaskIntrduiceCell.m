//
//  ReleaseTaskIntrduiceCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseTaskIntrduiceCell.h"

@implementation ReleaseTaskIntrduiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.writeLab.delegate = self;
    // Initialization code
}
// FIXME: ----
- (IBAction)releaseBtuAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(releaseTask:taskId:)]) {
        [self.delegate releaseTask:_type taskId:_taskID];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placehodleLab.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length < 1) {
        self.placehodleLab.hidden = NO;
    }
    if ([self.delegate respondsToSelector:@selector(sendTaskDescribe:)]) {
        [self.delegate sendTaskDescribe:textView.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
