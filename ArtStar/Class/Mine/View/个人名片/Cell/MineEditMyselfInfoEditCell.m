//
//  MineEditMyselfInfoEditCell.m
//  ArtStar
//
//  Created by abc on 6/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineEditMyselfInfoEditCell.h"

@implementation MineEditMyselfInfoEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nikNameTF.delegate = self;
    self.introudceTF.delegate = self;
    
    // Initialization code
}
- (IBAction)homeChooseClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(touchUITableViewCellMakeSomeThingWithTitle:)]) {
        [self.delegate touchUITableViewCellMakeSomeThingWithTitle:@"家乡"];
    }
}
- (IBAction)chooseHeaderImage:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(touchUITableViewCellMakeSomeThingWithTitle:)]) {
        [self.delegate touchUITableViewCellMakeSomeThingWithTitle:@"头像"];
    }
}
- (IBAction)chooseBrithday:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(touchUITableViewCellMakeSomeThingWithTitle:)]) {
        [self.delegate touchUITableViewCellMakeSomeThingWithTitle:@"生日"];
    }
}
- (IBAction)chooseHeight:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(touchUITableViewCellMakeSomeThingWithTitle:)]) {
        [self.delegate touchUITableViewCellMakeSomeThingWithTitle:@"身高"];
    }
}
- (IBAction)chooseWeight:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(touchUITableViewCellMakeSomeThingWithTitle:)]) {
        [self.delegate touchUITableViewCellMakeSomeThingWithTitle:@"体重"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.nikNameTF) {
        if ([self.delegate respondsToSelector:@selector(sendNikNameToController:)]) {
            [self.delegate sendNikNameToController:textField.text];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(sendIntroudceToController:)]) {
            [self.delegate sendIntroudceToController:textField.text];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
