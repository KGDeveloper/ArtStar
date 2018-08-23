//
//  CommunityExhibitionWorkerCell.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/2.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "CommunityExhibitionWorkerCell.h"

@implementation CommunityExhibitionWorkerCell

- (void)changeScrollViewWithArray:(NSArray *)arr{
    if (arr.count == 0) {
        _centerScrollView.contentSize = CGSizeMake(110, 140);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 168)];
        imageView.image = Image(@"空空如也");
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_centerScrollView addSubview:imageView];
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ViewHeight(_centerScrollView) - 12, 110, 12)];
        nameLab.textColor = Color_999999;
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.font = SYFont(12);
        nameLab.text = @"暂无数据";
        [_centerScrollView addSubview:nameLab];
        
        _topScrollView.contentSize = CGSizeMake(110, 50);
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
        titleLab.textColor = Color_999999;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = SYFont(12);
        titleLab.text = @"参展艺术家(0)";
        [_topScrollView addSubview:titleLab];
    }else{
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 50)];
        titleLab.textColor = Color_999999;
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = SYFont(12);
        titleLab.text = [NSString stringWithFormat:@"参展艺术家(%li)",arr.count];
        [_topScrollView addSubview:titleLab];
        
        for (int i = 0; i < arr.count ; i++) {
            NSDictionary *dic = arr[i];
            [self createArtistViewWIth:dic[@"artist"] heardimage:dic[@"artistimg"] frame:CGRectMake(117*i, 0, 110, 155)];
        }
    }
}

- (void)createArtistViewWIth:(NSString *)name heardimage:(NSString *)headerimage frame:(CGRect)frame{
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    [headView sd_setImageWithURL:[NSURL URLWithString:headerimage]];
    [self.contentView addSubview:headView];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x, frame.size.height - 15, frame.size.width, 15)];
    nameLab.textColor = Color_333333;
    nameLab.textAlignment = NSTextAlignmentCenter;
    nameLab.font = SYFont(12);
    nameLab.text = name;
    [self.contentView addSubview:nameLab];
    
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
