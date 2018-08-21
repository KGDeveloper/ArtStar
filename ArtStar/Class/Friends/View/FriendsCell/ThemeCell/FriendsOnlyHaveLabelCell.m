//
//  FriendsOnlyHaveLabelCell.m
//  ArtStar
//
//  Created by abc on 5/21/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsOnlyHaveLabelCell.h"

@interface FriendsOnlyHaveLabelCell ()

@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsOnlyHaveLabelCell

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
    if ([model[@"type"] integerValue] == 2) {
        _themeLab.hidden = YES;
    }else if ([model[@"type"] integerValue] == 1){
        _themeLab.hidden = NO;
        _themeLab.text = [NSString stringWithFormat:@"# %@ #",model[@"title"]];
    }else{
        _themeLab.hidden = YES;
    }
    
    NSDictionary *dic = model[@"user"];
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikeNameLab.text = dic[@"username"];
    if (model[@"location"]) {
        _locationLab.text = model[@"location"];
    }
    if (model[@"timeDiff "]) {
        _timeLab.text = model[@"timeDiff "];
    }else{
        _timeLab.text = model[@"createTimeStr"];
    }
    [_commentBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"rccommentNum"] integerValue]] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%li",[model[@"likeCount"] integerValue]] forState:UIControlStateNormal];
    
    _rfuid = model[@"id"];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)headerClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.rfuid.integerValue];
    }
}
- (IBAction)deleteClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.rfuid.integerValue];
    }
}
- (IBAction)shareClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.rfuid.integerValue];
    }
}
- (IBAction)commentClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.rfuid.integerValue];
    }
}
- (IBAction)zansClick:(UIButton *)sender {
    if ([sender.currentImage isEqual:Image(@"点赞")]) {
        [sender setImage:Image(@"点赞选中状态") forState:UIControlStateNormal];
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
