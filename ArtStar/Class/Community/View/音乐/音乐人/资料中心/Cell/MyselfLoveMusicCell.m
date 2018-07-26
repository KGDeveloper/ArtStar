//
//  MyselfLoveMusicCell.m
//  ArtStar
//
//  Created by abc on 6/6/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfLoveMusicCell.h"

@implementation MyselfLoveMusicCell

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    _scrollView.contentSize = CGSizeMake(130*imageArr.count, 135);
    for (int i = 0; i < imageArr.count; i++) {
        NSDictionary *dic = imageArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(130*i, 0, 110, 110)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imageUrl"]]];
        imageView.layer.cornerRadius = 55;
        imageView.layer.masksToBounds = YES;
        [_scrollView addSubview:imageView];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(130*i, 120, 110, 15)];
        nameLab.textColor = Color_333333;
        nameLab.font = SYFont(14);
        nameLab.text = dic[@"musicName"];
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
