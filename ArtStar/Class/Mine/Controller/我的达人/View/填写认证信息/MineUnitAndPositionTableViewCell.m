//
//  MineUnitAndPositionTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineUnitAndPositionTableViewCell.h"

@implementation MineUnitAndPositionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _unitTF.delegate = self;
    _positionTF.delegate = self;
    // Initialization code
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:_unitTF]) {
        if ([self.delegate respondsToSelector:@selector(sendUnitPosition:position:)]) {
            [self.delegate sendUnitPosition:nil position:textField.text];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(sendUnitPosition:position:)]) {
            [self.delegate sendUnitPosition:textField.text position:nil];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
