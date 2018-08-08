//
//  MineFeedBackIdeaTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineFeedBackIdeaTableViewCell.h"

@implementation MineFeedBackIdeaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.alertLab.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(sendIdeaToController:)]) {
        [self.delegate sendIdeaToController:textView.text];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length > 200) {
        [MBProgressHUD bwm_showTitle:@"最多只能输入200字" toView:self hideAfter:1];
    }
    _countLab.text = [NSString stringWithFormat:@"%li/200",textView.text.length];
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
