//
//  FriendsVideoView.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsVideoView.h"
#import <AVFoundation/AVFoundation.h>

@interface FriendsVideoView (){
    NSTimer *_timer;
}

@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,strong) UIView *progressLine;
@property (nonatomic,assign) BOOL isReadToPlay;
@property (nonatomic,assign) NSInteger allTime;
@property (nonatomic,strong) UIButton *playBtu;
@property (nonatomic,strong) UIView *backView;

@end

@implementation FriendsVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    UIButton *returnBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtu.frame = CGRectMake(15, NavTopHeight - 15, 8, 15);
    [returnBtu setImage:Image(@"back") forState:UIControlStateNormal];
    [returnBtu addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:returnBtu atIndex:99];
    
    UIView *playLine = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 52,ViewWidth(self), 2)];
    playLine.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    playLine.alpha = 0.5;
    [self insertSubview:playLine atIndex:99];
    
    _progressLine = [[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(self) - 52, 0, 2)];
    _progressLine.backgroundColor = [UIColor whiteColor];
    [self insertSubview:_progressLine atIndex:99];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/2 - 20, ViewHeight(self)/2 - 20, 40, 40)];
    self.backView.backgroundColor = [UIColor colorWithHexString:@"#000000"];
    self.backView.alpha = 0.4;
    self.backView.layer.cornerRadius = 20;
    self.backView.layer.masksToBounds = YES;
    [self insertSubview:self.backView atIndex:99];
    
    self.playBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playBtu.frame = self.backView.frame;
    [self.playBtu setImage:Image(@"播放按钮") forState:UIControlStateNormal];
    self.playBtu.layer.cornerRadius = 20;
    self.playBtu.layer.borderWidth = 1;
    self.playBtu.layer.borderColor = [UIColor colorWithHexString:@"#ffffff"].CGColor;
    self.playBtu.layer.masksToBounds = YES;
    [self.playBtu addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:self.playBtu atIndex:99];
    
}

- (void)playVideo{
    self.playBtu.hidden = YES;
    self.backView.hidden = YES;
    [self.player play];
    [_timer setFireDate:[NSDate date]];
}

- (void)changeViewWidth{
    self.progressLine.width = CMTimeGetSeconds(self.player.currentItem.currentTime)/CMTimeGetSeconds(self.player.currentItem.duration) * kScreenWidth;
}

- (void)returnClick{
    _timer = nil;
    [_timer invalidate];
    self.backView.hidden = NO;
    self.playBtu.hidden = NO;
    self.hidden = YES;
}

- (void)playWith:(NSURL *)url{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeViewWidth) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer setFireDate:[NSDate distantFuture]];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.bounds;
    [self.layer addSublayer:self.playerLayer];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                self.isReadToPlay = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                self.isReadToPlay = YES;
                self.allTime = self.playerItem.duration.value/self.playerItem.duration.timescale;
                break;
            case AVPlayerItemStatusUnknown:
                self.isReadToPlay = NO;
                break;
            default:
                break;
        }
    }
    [object removeObserver:self forKeyPath:@"status"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.player pause];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
