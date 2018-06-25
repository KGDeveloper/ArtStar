//
//  MyselfLoveMoviesCell.m
//  ArtStar
//
//  Created by abc on 6/6/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfLoveMoviesCell.h"

@implementation MyselfLoveMoviesCell

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    _scrollView.contentSize = CGSizeMake(120*imageArr.count, 155);
    for (int i = 0; i < imageArr.count; i++) {
        NSDictionary *dic = imageArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120*i, 0, 100, 130)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
        [_scrollView addSubview:imageView];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(120*i, 140, 100, 15)];
        nameLab.textColor = Color_333333;
        nameLab.font = SYFont(14);
        nameLab.text = dic[@"name"];
        nameLab.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:nameLab];
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
