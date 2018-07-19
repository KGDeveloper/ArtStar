//
//  TalentPushPhotosTableViewCell.m
//  ArtStar
//
//  Created by abc on 2018/6/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "TalentPushPhotosTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TalentPushPhotosTableViewCell ()

@property (nonatomic,strong) UIImageView *chooseImageView;

@end

@implementation TalentPushPhotosTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    [_backView removeAllSubviews];
    if (_cellIndex == 5) {
        if (imageArr.count > 0) {
            if (imageArr.count < 9) {
                _backViewHeight.constant = 120*(imageArr.count/3 + 1);
            }else{
                _backViewHeight.constant = 120*(imageArr.count/3);
            }
            
            CGFloat width = 0;
            CGFloat height = 0;
            for (int i = 0; i < _imageArr.count; i++) {
                if (i%3 == 0 && i != 0) {
                    height = height + 120;
                    width = 0;
                }
                [_backView addSubview:[self imageViewWithImage:imageArr[i] frame:CGRectMake(width, height, 100, 100)]];
                width = 110 + width;
            }
            if (imageArr.count < 9) {
                if (imageArr.count%3 == 0) {
                    width = 0;
                    height = height + 120;
                }
                [_backView addSubview:[self createAddButtonWithFrame:CGRectMake(width, height, 100, 100)]];
            }
        }else{
            [_backView addSubview:[self createAddButtonWithFrame:CGRectMake(0, 0, 100, 100)]];
        }
    }else{
        
    }
}

- (void)setVideoStr:(NSURL *)videoStr{
    _videoStr = videoStr;
    [_backView removeAllSubviews];
    if (_cellIndex == 6) {
        if (videoStr == nil) {
            [_backView addSubview:[self createAddButtonWithFrame:CGRectMake(0, 0, 100, 100)]];
        }else{
            MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoStr];
            UIImage *urlImage = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
            [_backView addSubview:[self imageViewWithImage:urlImage frame:CGRectMake(0, 0, 100, 100)]];
        }
    }else{
        
    }
}

- (UIView *)imageViewWithImage:(UIImage *)image frame:(CGRect)frame{
    UIView *imageBack = [[UIView alloc]initWithFrame:frame];
    _chooseImageView = [[UIImageView alloc]initWithFrame:imageBack.bounds];
    _chooseImageView.image = image;
    [imageBack addSubview:_chooseImageView];
    
    UIButton *deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtu.frame = CGRectMake(ViewWidth(imageBack) - 20, 0, 20, 20);
    [deleteBtu setImage:Image(@"delete") forState:UIControlStateNormal];
    [deleteBtu addTarget:self action:@selector(deleteImageFrameSupView:) forControlEvents:UIControlEventTouchUpInside];
    [imageBack addSubview:deleteBtu];
    
    return imageBack;
}

- (void)deleteImageFrameSupView:(UIButton *)sender{
    if (_cellIndex == 5) {
        if ([self.delegate respondsToSelector:@selector(deleteImageFrameCell:)]) {
            [self.delegate deleteImageFrameCell:_chooseImageView.image];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(deleteVideos)]) {
            [self.delegate deleteVideos];
        }
    }
}

- (UIButton *)createAddButtonWithFrame:(CGRect)frame{
    UIButton *addBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtu.frame = frame;
    addBtu.backgroundColor = Color_999999;
    if (_cellIndex == 5) {
        [addBtu setImage:Image(@"uploadd") forState:UIControlStateNormal];
    }else{
        [addBtu setImage:Image(@"uploadd") forState:UIControlStateNormal];
    }
    [addBtu addTarget:self action:@selector(addIamge:) forControlEvents:UIControlEventTouchUpInside];
    return addBtu;
}

- (void)addIamge:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(touchAddButtonWithIndex:)]) {
        [self.delegate touchAddButtonWithIndex:_cellIndex];
    }
}

- (CGFloat)cellHeightFromArray:(NSArray *)imageArr{
    if (imageArr.count + 1 <= 3) {
        return 190;
    }else if (imageArr.count + 1 > 3 && imageArr.count + 1 <= 6){
        return 310;
    }else{
        return 430;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
