//
//  PreviewVideoPlayView.m
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "PreviewVideoPlayView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PreviewVideoPlayView (){
    CGFloat _timeWidth;
}

@property (nonatomic,strong) UILabel *oneLab;
@property (nonatomic,strong) UILabel *twoLab;
@property (nonatomic,strong) UILabel *threeLab;
@property (nonatomic,strong) UILabel *fourLab;
@property (nonatomic,strong) UILabel *fiveLab;
@property (nonatomic,strong) UIView *textView;

@property (nonatomic,strong) UIView *videoView;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *lowView;
@property (nonatomic,strong) UILabel *timelab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *themeLab;

@end

@implementation PreviewVideoPlayView

- (instancetype)initWithFrame:(CGRect)frame type:(VideoViewTextType)type{
    if (self = [super initWithFrame:frame]) {
        [self setUIWithType:type];
    }
    return self;
}
//MARK:--判断搭建界面--
- (void)setUIWithType:(VideoViewTextType)type{
    switch (type) {
        case VideoViewTextTypeOnlyVideo:
            [self setVideo:CGRectMake(15, 0, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, photoViewHeight, kScreenWidth - 15, 50)];
            break;
        case VideoViewTextTypeTopLeftText:
            [self setTextViewWithLocation:0 textAlignment:NSTextAlignmentLeft];
            [self setVideo:CGRectMake(15, 170, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, ViewHeight(self) - 50, kScreenWidth - 15, 50)];
            break;
        case VideoViewTextTypeTopCenterText:
            [self setTextViewWithLocation:0 textAlignment:NSTextAlignmentCenter];
            [self setVideo:CGRectMake(15, 170, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, ViewHeight(self) - 50, kScreenWidth - 15, 50)];
            break;
        case VideoViewTextTypeTopRightText:
            [self setTextViewWithLocation:0 textAlignment:NSTextAlignmentRight];
            [self setVideo:CGRectMake(15, 170, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, ViewHeight(self) - 50, kScreenWidth - 15, 50)];
            break;
        case VideoViewTextTypeButtomLeftText:
            [self setTextViewWithLocation:1 textAlignment:NSTextAlignmentLeft];
            [self setVideo:CGRectMake(15, 0, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, ViewHeight(self) - 50, kScreenWidth - 15, 50)];
            break;
        case VideoViewTextTypeButtomCenterText:
            [self setTextViewWithLocation:1 textAlignment:NSTextAlignmentCenter];
            [self setVideo:CGRectMake(15, 0, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, ViewHeight(self) - 50, kScreenWidth - 15, 50)];
            break;
        default:
            [self setTextViewWithLocation:1 textAlignment:NSTextAlignmentRight];
            [self setVideo:CGRectMake(15, 0, kScreenWidth - 30, photoViewHeight)];
            [self setLocationView:CGRectMake(15, ViewHeight(self) - 50, kScreenWidth - 15, 50)];
            break;
    }
}
//MARK:--创建文本框--
- (void)setTextViewWithLocation:(NSInteger)location textAlignment:(NSTextAlignment)textAlignment{
    if (location == 0) {
        if (textAlignment == NSTextAlignmentLeft) {
            _textView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, 281, textViewHeight)];
        }else if (textAlignment == NSTextAlignmentCenter){
            _textView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 281)/2, 0, 281, textViewHeight)];
        }else{
            _textView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 281 - 15, 0, 281, textViewHeight)];
        }
    }else{
        if (textAlignment == NSTextAlignmentLeft) {
            _textView = [[UIView alloc]initWithFrame:CGRectMake(15, photoViewHeight + 20, 281, textViewHeight)];
        }else if (textAlignment == NSTextAlignmentCenter){
            _textView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth - 281)/2, photoViewHeight + 20, 281, textViewHeight)];
        }else{
            _textView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth - 281 - 15, photoViewHeight + 20, 281, textViewHeight)];
        }
    }
    [self addSubview:_textView];
    
    //:--加载label--
    _oneLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_textView), 22)];
    _oneLab.font = FZFont(13);
    _oneLab.textColor = Color_333333;
    [_textView addSubview:_oneLab];
    
    _twoLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, ViewWidth(_textView), 22)];
    _twoLab.font = FZFont(13);
    _twoLab.textColor = Color_333333;
    [_textView addSubview:_twoLab];
    
    _threeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, ViewWidth(_textView), 22)];
    _threeLab.font = FZFont(13);
    _threeLab.textColor = Color_333333;
    [_textView addSubview:_threeLab];
    
    _fourLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 96, ViewWidth(_textView), 22)];
    _fourLab.font = FZFont(13);
    _fourLab.textColor = Color_333333;
    [_textView addSubview:_fourLab];
    
    _fiveLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 128, ViewWidth(_textView), 22)];
    _fiveLab.font = FZFont(13);
    _fiveLab.textColor = Color_333333;
    [_textView addSubview:_fiveLab];
}
//MARK:--创建图片加载界面--
- (void)setVideo:(CGRect)frame{
    _videoView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:_videoView];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_videoView), ViewHeight(_videoView))];
    [_videoView addSubview:_imageView];
    
    UIButton *touchBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    touchBtu.frame = CGRectMake((ViewWidth(_imageView) - 40)/2, (ViewHeight(_imageView) - 40)/2, 40, 40);
    [touchBtu setImage:Image(@"play") forState:UIControlStateNormal];
    [touchBtu addTarget:self action:@selector(touchImageView) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:touchBtu];
}
- (void)touchImageView{
    if ([self.delegate respondsToSelector:@selector(playVideoOnController)]) {
        [self.delegate playVideoOnController];
    }
}
//MARK:--创建底部时间，位置，话题label--
- (void)setLocationView:(CGRect)frame{
    //:--加载view--
    _lowView = [[UIView alloc]initWithFrame:frame];
    [self addSubview:_lowView];
    //:--时间标签--
    _timelab = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 0, 0)];
    _timelab.textColor = Color_999999;
    _timelab.font = FZFont(12);
    [_lowView addSubview:_timelab];
    //:--位置标签--
    _locationLab = [[UILabel alloc]initWithFrame:CGRectMake(0,25, 0, 0)];
    _locationLab.textColor = Color_999999;
    _locationLab.font = FZFont(12);
    [_lowView addSubview:_locationLab];
    //:--话题标签--
    _themeLab = [[UILabel alloc]initWithFrame:CGRectMake(ViewWidth(_lowView) - 150,15, 135, 15)];
    _themeLab.textAlignment = NSTextAlignmentRight;
    _themeLab.textColor = Color_333333;
    _themeLab.font = FZFont(12);
    [_lowView addSubview:_themeLab];
}
//MARK:--给label赋值--
- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    //:--判断数组是为了防止数组越界--
    if (titleArr.count == 1) {
        _oneLab.text = titleArr[0];
    }else if (titleArr.count == 2){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
    }else if (titleArr.count == 3){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
        _threeLab.text = titleArr[2];
    }else if (titleArr.count == 4){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
        _threeLab.text = titleArr[2];
        _fourLab.text = titleArr[3];
    }else if (titleArr.count == 5){
        _oneLab.text = titleArr[0];
        _twoLab.text = titleArr[1];
        _threeLab.text = titleArr[2];
        _fourLab.text = titleArr[3];
        _fiveLab.text = titleArr[4];
    }
}
//MARK:--给时间label赋值--
- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    _timeWidth = [TransformChineseToPinying stringWidthFromString:timeStr font:FZFont(12) width:kScreenWidth];
    _timelab.frame = CGRectMake(0, 25, _timeWidth, 15);
    _timelab.text = timeStr;
}
//MARK:--给位置信息label赋值--
- (void)setLocationStr:(NSString *)locationStr{
    _locationStr = locationStr;
    CGFloat width = [TransformChineseToPinying stringWidthFromString:locationStr font:FZFont(12) width:kScreenWidth];
    _locationLab.frame = CGRectMake(_timeWidth + 10, 25, width, 15);
    _locationLab.text = locationStr;
}
//MARK:--给话题label赋值--
- (void)setThemeStr:(NSString *)themeStr{
    _themeStr = themeStr;
    _themeLab.text = themeStr;
}
//MARK:--改变label的对齐方式--
- (void)setType:(TextAlignment)type{
    _type = type;
    switch (type) {
        case TextAlignmentLeft:
            [self changeTextAligment:NSTextAlignmentLeft];
            break;
        case TextAlignmentCenter:
            [self changeTextAligment:NSTextAlignmentCenter];
            break;
        default:
            [self changeTextAligment:NSTextAlignmentRight];
            break;
    }
}
- (void)setPlayVideo:(NSURL *)playVideo{
    _playVideo = playVideo;
    self.imageView.image = [[KGRequestNetWorking shareIntance] thumbnailImageForVideo:playVideo];
}
- (void)setVideoImage:(UIImage *)videoImage{
    _videoImage = videoImage;
    self.imageView.image = videoImage;
}
//MARK:--改变label上面文字对齐方式--
- (void)changeTextAligment:(NSTextAlignment)type{
    for (UILabel *tmp in self.textView.subviews) {
        if ([tmp isKindOfClass:[UILabel class]]) {
            tmp.textAlignment = type;
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
