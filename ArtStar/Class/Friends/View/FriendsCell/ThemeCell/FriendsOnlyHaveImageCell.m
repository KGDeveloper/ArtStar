//
//  FriendsOnlyHaveImageCell.m
//  ArtStar
//
//  Created by abc on 5/17/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsOnlyHaveImageCell.h"
#import <AVFoundation/AVFoundation.h>

@interface FriendsOnlyHaveImageCell ()

@property (nonatomic,copy) NSNumber *rfuid;

@end

@implementation FriendsOnlyHaveImageCell

- (void)fillCellWithModel:(FriendsModel *)model{
    
    if ([model.type integerValue] == 2) {
        [self showVideo];
        _themeLab.hidden = YES;
    }else if ([model.type integerValue] == 1){
        [self showGraphic];
        _themeLab.text = model.title;
    }else{
        [self showGraphic];
        _themeLab.hidden = YES;
    }
    NSDictionary *imageDic = [model.images firstObject];
    if ([model.type integerValue] == 2) {
        _topImage.image = [self thumbnailImageForVideo:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }else{
        [_topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
    }
    
    NSDictionary *dic = model.user;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _nikNameLab.text = dic[@"username"];
    _locationLab.text = model.location;
    _timeLab.text = model.createTimeStr;
    
    [_commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
    [_zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)deleteClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(deleteCell:)]) {
        [self.delegate deleteCell:self.rfuid.integerValue];
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
- (IBAction)commentClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commentCell:)]) {
        [self.delegate commentCell:self.rfuid.integerValue];
    }
}
- (IBAction)shareClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shareCell:)]) {
        [self.delegate shareCell:self.rfuid.integerValue];
    }
}
- (IBAction)headerClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(headerPushInfo:)]) {
        [self.delegate headerPushInfo:self.rfuid.integerValue];
    }
}
- (void)showVideo{
    self.labView.hidden = YES;
    self.countLab.hidden = YES;
    self.lookAllImageBtu.hidden = YES;
    self.btuView.hidden = NO;
    self.playBtu.hidden = NO;
}
- (void)showGraphic{
    self.labView.hidden = NO;
    self.countLab.hidden = NO;
    self.lookAllImageBtu.hidden = NO;
    self.btuView.hidden = YES;
    self.playBtu.hidden = YES;
}

- (UIImage *)thumbnailImageForVideo:(NSURL *)video{
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:video options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 1;
    NSError *error = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&error];
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}

@end
