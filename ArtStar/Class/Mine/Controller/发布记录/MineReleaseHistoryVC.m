//
//  MineReleaseHistoryVC.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineReleaseHistoryVC.h"
#import "MineBookButtonView.h"

#import "MineReleasePictureView.h"
#import "MineReleaseVideoView.h"
#import "MineReleaseThemeView.h"
#import "MineReleaseArticleView.h"

@interface MineReleaseHistoryVC ()

@property (nonatomic,strong) MineBookButtonView *pictureBtu;
@property (nonatomic,strong) MineBookButtonView *videoBtu;
@property (nonatomic,strong) MineBookButtonView *themeBtu;
@property (nonatomic,strong) MineBookButtonView *articleBtu;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) MineReleasePictureView *pictureView;
@property (nonatomic,strong) MineReleaseVideoView *videoView;
@property (nonatomic,strong) MineReleaseThemeView *themeView;
@property (nonatomic,strong) MineReleaseArticleView *articleView;

@end

@implementation MineReleaseHistoryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"发布记录" image:Image(@"back")];
    [self setRightBtuWithTitle:@"编辑" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopView];
    
}
- (void)setTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    _pictureBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth/4, 60)];
    _pictureBtu.name = @"图文记录";
    _pictureBtu.count = @"10";
    _pictureBtu.btuColor = Color_333333;
    __weak typeof(self) mySelf = self;
    _pictureBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_333333;
        mySelf.videoBtu.btuColor = Color_999999;
        mySelf.themeBtu.btuColor = Color_999999;
        mySelf.articleBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.pictureBtu];
        [mySelf.view bringSubviewToFront:mySelf.pictureView];
    };
    [topView addSubview:_pictureBtu];
    
    _videoBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 0,kScreenWidth/4, 60)];
    _videoBtu.name = @"视频记录";
    _videoBtu.count = @"12";
    _videoBtu.btuColor = Color_999999;
    _videoBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_999999;
        mySelf.videoBtu.btuColor = Color_333333;
        mySelf.themeBtu.btuColor = Color_999999;
        mySelf.articleBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.videoBtu];
      [mySelf.view bringSubviewToFront:mySelf.videoView];
    };
    [topView addSubview:_videoBtu];
    
    _themeBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0,kScreenWidth/4, 60)];
    _themeBtu.name = @"话题记录";
    _themeBtu.count = @"7";
    _themeBtu.btuColor = Color_999999;
    _themeBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_999999;
        mySelf.videoBtu.btuColor = Color_999999;
        mySelf.themeBtu.btuColor = Color_333333;
        mySelf.articleBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.themeBtu];
        [mySelf.view bringSubviewToFront:mySelf.themeView];
    };
    [topView addSubview:_themeBtu];
    
    _articleBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/4*3, 0,kScreenWidth/4, 60)];
    _articleBtu.name = @"文章记录";
    _articleBtu.count = @"20";
    _articleBtu.btuColor = Color_999999;
    _articleBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_999999;
        mySelf.videoBtu.btuColor = Color_999999;
        mySelf.themeBtu.btuColor = Color_999999;
        mySelf.articleBtu.btuColor = Color_333333;
        [mySelf changeLineOriginX:mySelf.articleBtu];
        [mySelf.view bringSubviewToFront:mySelf.articleView];
    };
    [topView addSubview:_articleBtu];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/8 - 30, 58, 60, 2)];
    _line.backgroundColor = Color_333333;
    [topView addSubview:_line];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 59, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [topView addSubview:lowLine];
    
    self.pictureView.hidden = NO;
}

- (void)changeLineOriginX:(MineBookButtonView *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
}

- (MineReleasePictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = [[MineReleasePictureView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_pictureView];
    }
    return _pictureView;
}

- (MineReleaseVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[MineReleaseVideoView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_videoView];
    }
    return _videoView;
}

- (MineReleaseThemeView *)themeView{
    if (!_themeView) {
        _themeView = [[MineReleaseThemeView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_themeView];
    }
    return _themeView;
}

- (MineReleaseArticleView *)articleView{
    if (!_articleView) {
        _articleView = [[MineReleaseArticleView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_articleView];
    }
    return _articleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
