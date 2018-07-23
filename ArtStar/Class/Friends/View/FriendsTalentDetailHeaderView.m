//
//  FriendsTalentDetailHeaderView.m
//  ArtStar
//
//  Created by abc on 2018/7/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "FriendsTalentDetailHeaderView.h"

@implementation FriendsTalentDetailHeaderView

+ (instancetype)initWithView{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FriendsTalentDetailHeaderView" owner:self options:nil];
    FriendsTalentDetailHeaderView *view = [arr firstObject];
    return view;
}

- (CGFloat)calculateHeaderViewHeightWithModel:(FriendsTalentModel *)model{
    if (!model) {
        return 0;
    }
    
    _titleLab.text = model.headline;
    NSDictionary *dic = model.user;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikeName.text = [NSString stringWithFormat:@"%@  的发布",dic[@"username"]];
    _timeLab.text = model.issueDate;
    CGFloat textHeight = [TransformChineseToPinying string:model.siteIntroduce font:SYFont(14) space:10].size.width/(kScreenWidth - 30)*25 + 14;
    _detailHeight.constant = textHeight;
    _detailLab.attributedText = [TransformChineseToPinying string:model.siteIntroduce font:SYFont(14) space:10];
    CGFloat height = 0;
    NSArray *arr = model.images;
    if (arr.count <= 3) {
        height = 100;
    }else if (arr.count >3 && arr.count <=6){
        height = 220;
    }else if (arr.count >6 && arr.count <=9){
        height = 340;
    }
    _imageViewHeight.constant = height;
    
    CGFloat imageWidth = 0;
    CGFloat imageHeight = 0;
    for (int i = 0; i < arr.count; i++) {
        if (i%3 == 0 && i != 0) {
            imageHeight = imageHeight + 120;
            imageWidth = 0;
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageWidth, imageHeight, 100, 100)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
        [_imageBack addSubview:imageView];
        imageWidth = imageWidth + 103;
    }
    _locationLab.text = model.location;
    _infoNiknameLab.text = model.siteName;
    [_infoHeaderImage sd_setImageWithURL:arr[0]];
    _infoLocationLab.text = model.siteAddress;
    _infoTelephoneLab.text = model.siteTelephone;
    
    return 330 + textHeight + height;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
