//
//  HeadLineHaveTitleNewsTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "HeadLineHaveTitleNewsTableViewCell.h"

@implementation HeadLineHaveTitleNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
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
