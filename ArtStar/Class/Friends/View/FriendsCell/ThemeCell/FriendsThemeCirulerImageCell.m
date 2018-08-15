//
//  FriendsThemeCirulerImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsThemeCirulerImageCell.h"

@interface FriendsThemeCirulerImageCell ()

@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsThemeCirulerImageCell

- (void)fillCellWithModel:(FriendsModel *)model{
    NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
    NSString *str = dataArr[0];
    for (int i = 1; i < dataArr.count; i++) {
        str = [NSString stringWithFormat:@"%@\n%@",str,dataArr[i]];
    }
    
    [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentCenter];
    
    if ([model.type integerValue] == 2) {
        _themelab.hidden = YES;
    }else if ([model.type integerValue] == 1){
        _themelab.hidden = NO;
        _themelab.text = [NSString stringWithFormat:@"# %@ #",model.title];
    }else{
        _themelab.hidden = YES;
    }
    NSDictionary *imageDic = [model.images firstObject];
    [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    _countLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)model.images.count];
    NSDictionary *dic = model.user;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    _locationLab.text = model.location;
    _timeLab.text = model.createTimeStr;
    _rfuid = model.ID;
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)headerClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.rfuid.integerValue];
    }
}

- (IBAction)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.rfuid.integerValue];
    }
}
- (IBAction)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.rfuid.integerValue];
    }
}
- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.rfuid.integerValue];
    }
}
- (IBAction)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:self.rfuid.integerValue];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
