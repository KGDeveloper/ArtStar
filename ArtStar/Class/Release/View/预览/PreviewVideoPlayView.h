//
//  PreviewVideoPlayView.h
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VideoViewTextType){
    VideoViewTextTypeOnlyVideo = 0,
    VideoViewTextTypeTopLeftText,
    VideoViewTextTypeTopCenterText,
    VideoViewTextTypeTopRightText,
    VideoViewTextTypeButtomLeftText,
    VideoViewTextTypeButtomCenterText,
    VideoViewTextTypeButtomRightText,
};

typedef NS_ENUM(NSInteger,TextAlignment){
    TextAlignmentLeft = 0,
    TextAlignmentCenter,
    TextAlignmentRight,
};

@protocol PreviewVideoPlayViewDelegate <NSObject>

- (void)playVideoOnController;

@end

@interface PreviewVideoPlayView : UIView

@property (nonatomic,copy) NSArray *titleArr;
@property (nonatomic,copy) NSURL *playVideo;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *locationStr;
@property (nonatomic,copy) NSString *themeStr;
@property (nonatomic,copy) UIImage *videoImage;
@property (nonatomic,assign) TextAlignment type;
@property (nonatomic,weak) id<PreviewVideoPlayViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame type:(VideoViewTextType)type;

@end
