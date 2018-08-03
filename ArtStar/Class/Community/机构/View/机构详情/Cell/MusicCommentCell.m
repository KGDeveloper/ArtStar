//
//  MusicCommentCell.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicCommentCell.h"

@implementation MusicCommentCell

- (void)setTopCount:(NSString *)topCount{
    _topCount = topCount;
    NSArray *arr = [topCount componentsSeparatedByString:@"."];
    if ([[arr lastObject] integerValue] > 0) {
        for (int i = 0; i < [[arr firstObject] integerValue] + 1; i++) {
            if (i < [[arr firstObject] integerValue]) {
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
                image.image = Image(@"star");
                [_topView addSubview:image];
            }else{
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
                image.image = Image(@"yellowstay");
                [_topView addSubview:image];
            }
        }
    }else{
        for (int i = 0; i < [[arr firstObject] integerValue]; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
            image.image = Image(@"star");
            [_topView addSubview:image];
        }
    }
}

- (void)setCenterCount:(NSString *)centerCount{
    _centerCount = centerCount;
    NSArray *arr = [centerCount componentsSeparatedByString:@"."];
    if ([[arr lastObject] integerValue] > 0) {
        for (int i = 0; i < [[arr firstObject] integerValue] + 1; i++) {
            if (i < [[arr firstObject] integerValue]) {
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
                image.image = Image(@"star");
                [_centerView addSubview:image];
            }else{
                UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
                image.image = Image(@"yellowstay");
                [_centerView addSubview:image];
            }
        }
    }else{
        for (int i = 0; i < [[arr firstObject] integerValue]; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(17*i, 0, 12, 12)];
            image.image = Image(@"star");
            [_centerView addSubview:image];
        }
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
