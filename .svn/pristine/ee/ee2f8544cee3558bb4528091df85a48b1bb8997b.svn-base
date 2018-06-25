//
//  HeadLinesVideoPlayVide.m
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesVideoPlayVide.h"
#import <AVFoundation/AVFoundation.h>

@interface HeadLinesVideoPlayVide (){
    NSTimer *_timer;
}

@property (nonatomic,strong) AVPlayer *myPlayer;
@property (nonatomic,strong) AVPlayerItem *playerItme;
@property (nonatomic,strong) AVPlayerLayer *player;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIButton *playBtu;
@property (nonatomic,strong) UISlider *playSlider;
@property (nonatomic,assign) BOOL isCarsh;
@property (nonatomic,strong) UIView *playView;

@end

@implementation HeadLinesVideoPlayVide

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#000000"];
        _isCarsh = NO;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _playView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    [self addSubview:_playView];
    
    _backView = [[UIView alloc]initWithFrame:self.bounds];
    _backView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    _backView.alpha = 0.2;
    [self insertSubview:_backView atIndex:99];
    
    _playBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtu.frame = CGRectMake(ViewWidth(self)/2 - 20, ViewHeight(self)/2 - 20, 40, 40);
    [_playBtu setImage:Image(@"播放按钮") forState:UIControlStateNormal];
    [_playBtu addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:_playBtu atIndex:99];
    
    _playSlider = [[UISlider alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 5, ViewWidth(self), 5)];
    _playSlider.minimumTrackTintColor = [UIColor colorWithHexString:@"#00a0e9"];
    _playSlider.maximumTrackTintColor = [UIColor whiteColor];
    _playSlider.thumbTintColor = [UIColor clearColor];
    _playSlider.enabled = NO;
    [self insertSubview:_playSlider atIndex:99];
    
}

- (void)playVideo{
    if (_isCarsh == YES) {
        [_timer setFireDate:[NSDate date]];
        [self.myPlayer play];
        _backView.hidden = YES;
        _playBtu.hidden = YES;
    }
}

- (void)playVideoWithUrl:(NSURL *)url{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playCurrent) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer setFireDate:[NSDate distantFuture]];
    
    self.playerItme = [AVPlayerItem playerItemWithURL:url];
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.playerItme];
    self.player = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.player.frame = self.bounds;
    [self.playView.layer addSublayer:self.player];
    
    [self.playerItme addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)playCurrent{
    if (_playSlider.value == _playSlider.maximumValue) {
        [_timer setFireDate:[NSDate distantFuture]];
        _backView.hidden = NO;
        _playBtu.hidden = NO;
    }
    _playSlider.value = CMTimeGetSeconds(self.myPlayer.currentTime);
}

- (void)releasePlayer{
    _timer = nil;
    [_timer invalidate];
    _playSlider.value = 0;
    
    [self.myPlayer pause];
    [self.myPlayer setRate:0];
    self.playerItme = nil;
    self.myPlayer = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                _isCarsh = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                _isCarsh = YES;
                _playSlider.maximumValue = _playerItme.duration.value/_playerItme.duration.timescale;
                break;
            case AVPlayerItemStatusUnknown:
                _isCarsh = NO;
                break;
            default:
                break;
        }
    }
    
    [object removeObserver:self forKeyPath:@"status"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
