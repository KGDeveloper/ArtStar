//
//  FocusViewChatPermissionsCell.m
//  ArtStar
//
//  Created by abc on 6/8/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FocusViewChatPermissionsCell.h"

@implementation FocusViewChatPermissionsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)changeSwitchValue:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(changeStatusWithName:status:)]) {
        if (_statusSwitch.on == YES) {
            [self.delegate changeStatusWithName:_titleLab.text status:@"0"];
        }else{
            [self.delegate changeStatusWithName:_titleLab.text status:@"-1"];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
