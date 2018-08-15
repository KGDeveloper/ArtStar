//
//  FriendsThemeTopImageCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsThemeTopImageCell.h"
#import <AVFoundation/AVFoundation.h>

@interface FriendsThemeTopImageCell ()

@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsThemeTopImageCell

- (void)fillCellWithModel:(FriendsModel *)model{
    NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
    NSString *str = dataArr[0];
    for (int i = 1; i < dataArr.count; i++) {
        str = [NSString stringWithFormat:@"%@\n%@",str,dataArr[i]];
    }
    if ([model.composing integerValue] == 8) {
        [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentLeft];
    }else if ([model.composing integerValue] == 9){
        [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentCenter];
    }else if ([model.composing integerValue] == 10){
        [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentRight];
    }
    if ([model.type integerValue] == 2) {
        [self showVideo];
        _themeLab.hidden = YES;
    }else if ([model.type integerValue] == 1){
        [self hideVideo];
        _themeLab.hidden = NO;
        _themeLab.text = [NSString stringWithFormat:@"# %@ #",model.title];
    }else{
        [self hideVideo];
        _themeLab.hidden = YES;
    }
    NSDictionary *imageDic = [model.images firstObject];
    if ([model.type integerValue] == 2) {
        _topImage.image = [[KGRequestNetWorking shareIntance] thumbnailImageForVideo:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }else{
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }
    
    NSDictionary *dic = model.user;
    [_headerIamge sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    _locationLab.text = model.location;
    _timeLab.text = model.createTimeStr;
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
}

- (void)showVideo{
    _playView.hidden = NO;
    _playImage.hidden = NO;
}
- (void)hideVideo{
    _playView.hidden = YES;
    _playImage.hidden = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)headerClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:_rfuid.integerValue];
    }
}

- (IBAction)deleteClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:_rfuid.integerValue];
    }
}
- (IBAction)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:_rfuid.integerValue];
    }
}
- (IBAction)commentClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:_rfuid.integerValue];
    }
}
- (IBAction)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(zansCell:)]) {
        [self.delegate zansCell:_rfuid.integerValue];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
