//
//  MineFeedBackPictureTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineFeedBackPictureTableViewCell.h"

@implementation MineFeedBackPictureTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPhotosArr:(NSArray *)photosArr{
    _photosArr = photosArr;
    if (photosArr.count < 3) {
        for (int i = 0; i < photosArr.count + 1; i++) {
            if (i == photosArr.count) {
                UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
                but.frame = CGRectMake(90*i, 0, 75, 75);
                [but setImage:Image(@"tianjia") forState:UIControlStateNormal];
                [but addTarget:self action:@selector(butTouchUp) forControlEvents:UIControlEventTouchUpInside];
                [_backView addSubview:but];
            }else{
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90*i, 0, 75, 75)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
                [_backView addSubview:imageView];
            }
        }
        _countLab.text = [NSString stringWithFormat:@"%li/3",photosArr.count];
    }else{
        for (int i = 0; i < photosArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(90*i, 0, 75, 75)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:photosArr[i]]];
            [_backView addSubview:imageView];
        }
        _countLab.text = [NSString stringWithFormat:@"%li/3",photosArr.count];
    }
}

- (void)butTouchUp{
    if ([self.delegate respondsToSelector:@selector(chooseImage)]) {
        [self.delegate chooseImage];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
