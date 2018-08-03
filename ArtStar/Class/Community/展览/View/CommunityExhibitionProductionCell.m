//
//  CommunityExhibitionProductionCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionProductionCell.h"

@implementation CommunityExhibitionProductionCell

- (void)addProductionToScrollViewWithArray:(NSArray *)arr{
    _scrollView.contentSize = CGSizeMake(117*arr.count, _scrollView.frame.size.height);
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(117*i, 0, 110, 85)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"worksimg"]]];
        [_scrollView addSubview:imageView];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(117*i, ViewHeight(_scrollView) - 12, 110, 12)];
        nameLab.font = SYFont(12);
        if ([dic[@"worksname"] isKindOfClass:[NSNull class]]) {
            nameLab.text = @"暂无";
        }else{
            nameLab.text = dic[@"worksname"];
        }
        nameLab.textColor = Color_999999;
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
