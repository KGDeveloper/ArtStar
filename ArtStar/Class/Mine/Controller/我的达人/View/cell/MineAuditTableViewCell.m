//
//  MineAuditTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineAuditTableViewCell.h"

@implementation MineAuditTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)editClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"编辑选中状态")]) {
        [sender setImage:Image(@"编辑未选中状态") forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(changeTalentStatusWithID:status:)]) {
            [self.delegate changeTalentStatusWithID:_cellID status:@"取消"];
        }
    }else{
        [sender setImage:Image(@"编辑选中状态") forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(changeTalentStatusWithID:status:)]) {
            [self.delegate changeTalentStatusWithID:_cellID status:@"添加"];
        }
    }
}
- (IBAction)playClick:(UIButton *)sender {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
