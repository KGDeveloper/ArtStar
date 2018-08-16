//
//  MusicThemeMyThemeCell.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicThemeMyThemeCell.h"

@implementation MusicThemeMyThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setThemeArr:(NSArray *)themeArr{
    _themeArr = themeArr;
    
    _scrollView.contentSize = CGSizeMake(65*themeArr.count, 75);
    for (int i = 0;  i < themeArr.count; i++) {
        NSDictionary *dic = themeArr[i];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(65*i, 0, 50, 50)];
        NSArray *imageArr = dic[@"imgList"];
        NSDictionary *imageDic = [imageArr firstObject];
        [image sd_setImageWithURL:[NSURL URLWithString:imageDic[@"locationimg"]]];
        [_scrollView addSubview:image];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(65*i, 60, 50, 15)];
        nameLab.textColor = Color_333333;
        nameLab.text = dic[@"topictitle"];
        nameLab.font = SYFont(14);
        nameLab.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:nameLab];
    }
    
}

- (IBAction)rightAction:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
