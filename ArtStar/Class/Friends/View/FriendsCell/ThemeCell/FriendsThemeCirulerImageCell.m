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

- (void)fillCellWithModel:(NSDictionary *)model{
    if (![model[@"content"] isKindOfClass:[NSNull class]]) {
        NSData *strData = [model[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
        if (!error) {
            NSString *str = dataArr[0];
            for (int i = 1; i < dataArr.count; i++) {str = [NSString stringWithFormat:@"%@\n%@",str,dataArr[i]];}
            [ChangeTextViewTextStyle changeTextView:_textView text:str alignment:NSTextAlignmentCenter];
        }
    }
    
    if (model[@"type"]) {
        if ([model[@"type"] integerValue] == 2) {
            _themelab.hidden = YES;
        }else if ([model[@"type"] integerValue] == 1){
            _themelab.hidden = NO;
            _themelab.text = [NSString stringWithFormat:@"# %@ #",model[@"title"]];
        }else{
            _themelab.hidden = YES;
        }
    }else{
        _themelab.text = [NSString stringWithFormat:@"# %@ #",model[@"topictitle"]];
    }
    NSArray *imageArr = model[@"images"];
    _countLab.text = [NSString stringWithFormat:@"1/%li",imageArr.count];
    NSDictionary *imageDic = [imageArr lastObject];
    if (imageDic[@"imageURL"]) {
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }else{
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"locationimg"]]];
    }
    
    _countLab.text = [NSString stringWithFormat:@"1/%li",imageArr.count];
    NSDictionary *dic = model[@"user"];
    if ([[NSString stringWithFormat:@"%@",dic[@"id"]] isEqualToString:[KGUserInfo shareInterace].userID]){
        _deleteBtu.hidden = NO;
    }else{
        _deleteBtu.hidden = YES;
    }
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    if (![model[@"location"] isKindOfClass:[NSNull class]]) {
        _locationLab.text = model[@"location"];
    }else{
        _locationLab.text = @"";
    }
    if (model[@"timeDiff "]) {
        _timeLab.text = model[@"timeDiff "];
    }else{
        _timeLab.text = model[@"createTimeStr"];
    }
    _rfuid = model[@"id"];
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"rccommentNum"] integerValue]] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"likeCount"] integerValue]] forState:UIControlStateNormal];
    if ([model[@"islikeCount"] integerValue] == 0) {
        [_zansBtu setImage:Image(@"点赞") forState:UIControlStateNormal];
    }else{
        [_zansBtu setImage:Image(@"点赞选中") forState:UIControlStateNormal];
    }
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
        [sender setTitle:[NSString stringWithFormat:@"%li",[sender.currentTitle integerValue] + 1] forState:UIControlStateNormal];
    }else{
        [sender setImage:Image(@"点赞") forState:UIControlStateNormal];
        [sender setTitle:[NSString stringWithFormat:@"%li",[sender.currentTitle integerValue] - 1] forState:UIControlStateNormal];
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
