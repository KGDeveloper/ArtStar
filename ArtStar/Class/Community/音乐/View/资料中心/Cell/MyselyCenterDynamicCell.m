//
//  MyselyCenterDynamicCell.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselyCenterDynamicCell.h"

@implementation MyselyCenterDynamicCell

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    
    _scrollView.contentSize = CGSizeMake(100*imageArr.count, 100);
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(125*i, 0, 100, 100)];
        [image sd_setImageWithURL:[NSURL URLWithString:imageArr[i]]];
        [_scrollView addSubview:image];
    }
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
