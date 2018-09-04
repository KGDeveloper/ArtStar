//
//  MusicPhotosCell.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicPhotosCell.h"

@implementation MusicPhotosCell

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    
    _scrollView.contentSize = CGSizeMake(95*imageArr.count, 85);
    
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(95*i, 0, 85, 85)];
        [image sd_setImageWithURL:[NSURL URLWithString:imageArr[i]]];
        [_scrollView addSubview:image];
    }
}
- (IBAction)tletePhoneAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tletePhoneAction)]) {
        [self.delegate tletePhoneAction];
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
