//
//  ReleaseTaskWriteCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "ReleaseTaskWriteCell.h"

@implementation ReleaseTaskWriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleText.delegate = self;
    
    // Initialization code
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([textField.placeholder isEqualToString:@"请选择任务开始时间"] || [textField.placeholder isEqualToString:@"请选择任务结束时间"] || [textField.placeholder isEqualToString:@"请填写任务城市"]) {
        [textField resignFirstResponder];
        [textField endEditing:YES];
        textField.enabled = NO;
        if ([self.delegate respondsToSelector:@selector(changeTextFieldEditStyleWithString:)]) {
            [self.delegate changeTextFieldEditStyleWithString:textField.placeholder];
            textField.enabled = YES;
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(whenTextFieldEndEditSendContentTextToTheUIView:placeholder:)]) {
        [self.delegate whenTextFieldEndEditSendContentTextToTheUIView:textField.text placeholder:textField.placeholder];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
