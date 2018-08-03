//
//  HotmoviesActorCell.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotmoviesActorCell.h"

@implementation HotmoviesActorCell

- (void)setActorArr:(NSArray *)actorArr{
    _actorArr = actorArr;
    
    _scrollView.contentSize = CGSizeMake(95*actorArr.count, 145);
    
    for (int i = 0; i < actorArr.count; i++) {
        
        NSDictionary *dic = actorArr[i];
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(95*i, 0, 80, 100)];
        [image sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]]];
        [_scrollView addSubview:image];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(95*i, 110, 80, 15)];
        nameLab.textColor = Color_333333;
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.text = dic[@"name"];
        nameLab.font = SYFont(13);
        [_scrollView addSubview:nameLab];
        
        UILabel *actorLab = [[UILabel alloc]initWithFrame:CGRectMake(95*i, 130, 80, 15)];
        actorLab.textColor = Color_999999;
        actorLab.textAlignment = NSTextAlignmentCenter;
        actorLab.text = dic[@"actor"];
        actorLab.font = SYFont(13);
        [_scrollView addSubview:actorLab];
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
