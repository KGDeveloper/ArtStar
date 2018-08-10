//
//  MineBooksFriendsTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBooksFriendsTableViewCell.h"

@implementation MineBooksFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (IBAction)foucsAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(foucsActionWithID:)]) {
        [self.delegate foucsActionWithID:_ID];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
