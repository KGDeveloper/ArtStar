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

/**
 图文记录按钮
 */
@property (nonatomic,strong) MineBookButtonView *pictureBtu;
/**
 视频记录按钮
 */
@property (nonatomic,strong) MineBookButtonView *videoBtu;
/**
 话题记录按钮
 */
@property (nonatomic,strong) MineBookButtonView *themeBtu;
/**
 达人记录按钮
 */
@property (nonatomic,strong) MineBookButtonView *articleBtu;
/**
 移动直线
 */
@property (nonatomic,strong) UIView *line;
/**
 图文记录展示列表
 */
@property (nonatomic,strong) MineReleasePictureView *pictureView;
/**
 视频记录展示列表
 */
@property (nonatomic,strong) MineReleaseVideoView *videoView;
/**
 话题记录展示列表
 */
@property (nonatomic,strong) MineReleaseThemeView *themeView;
/**
 达人记录展示列表
 */
@property (nonatomic,strong) MineReleaseArticleView *articleView;
/**
 判断图文记录是否开启编辑模式
 */
@property (nonatomic,assign) BOOL photoAndTitleIsEdit;
/**
 判断视频记录是否开始编辑模式
 */
@property (nonatomic,assign) BOOL videoIsEdit;
/**
 判断话题记录是否开启编辑模式
 */
@property (nonatomic,assign) BOOL themeIsEdit;
/**
 判断达人记录是否开始编辑模式
 */
@property (nonatomic,assign) BOOL alentIsEdit;
/**
 当前所选记录
 */
@property (nonatomic,copy) NSString *status;

@end

@implementation MineReleaseHistoryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"发布记录" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _photoAndTitleIsEdit = NO;
    _videoIsEdit = NO;
    _themeIsEdit = NO;
    _alentIsEdit = NO;
    _status = @"图文记录";
    [self createData];
    [self setTopView];
    
}
- (void)rightNavBtuAction:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"编辑"]) {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        if ([_status isEqualToString:@"图文记录"]) {
            self.photoAndTitleIsEdit = YES;
        }else if ([_status isEqualToString:@"视频记录"]){
            self.videoIsEdit = YES;
        }else if ([_status isEqualToString:@"话题记录"]){
            self.themeIsEdit = YES;
        }else if ([_status isEqualToString:@"达人记录"]){
            self.alentIsEdit = YES;
        }
    }else{
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        if ([_status isEqualToString:@"图文记录"]) {
            self.photoAndTitleIsEdit = NO;
        }else if ([_status isEqualToString:@"视频记录"]){
            self.videoIsEdit = NO;
        }else if ([_status isEqualToString:@"话题记录"]){
            self.themeIsEdit = NO;
        }else if ([_status isEqualToString:@"达人记录"]){
            self.alentIsEdit = NO;
        }
    }
}

- (void)setTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    //:--图文记录按钮--
    _pictureBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth/4, 60)];
    _pictureBtu.name = @"图文记录";
    _pictureBtu.count = @"0";
    _pictureBtu.btuColor = Color_333333;
    __weak typeof(self) mySelf = self;
    _pictureBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_333333;
        mySelf.videoBtu.btuColor = Color_999999;
        mySelf.themeBtu.btuColor = Color_999999;
        mySelf.articleBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.pictureBtu];
        [mySelf.view bringSubviewToFront:mySelf.pictureView];
        mySelf.status = @"图文记录";
        [mySelf changeNavRightTitle:mySelf.status];
    };
    [topView addSubview:_pictureBtu];
    //:--视频记录按钮--
    _videoBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 0,kScreenWidth/4, 60)];
    _videoBtu.name = @"视频记录";
    _videoBtu.count = @"0";
    _videoBtu.btuColor = Color_999999;
    _videoBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_999999;
        mySelf.videoBtu.btuColor = Color_333333;
        mySelf.themeBtu.btuColor = Color_999999;
        mySelf.articleBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.videoBtu];
        [mySelf.view bringSubviewToFront:mySelf.videoView];
        mySelf.status = @"视频记录";
        [mySelf changeNavRightTitle:mySelf.status];
    };
    [topView addSubview:_videoBtu];
    //:--话题记录按钮--
    _themeBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0,kScreenWidth/4, 60)];
    _themeBtu.name = @"话题记录";
    _themeBtu.count = @"0";
    _themeBtu.btuColor = Color_999999;
    _themeBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_999999;
        mySelf.videoBtu.btuColor = Color_999999;
        mySelf.themeBtu.btuColor = Color_333333;
        mySelf.articleBtu.btuColor = Color_999999;
        [mySelf changeLineOriginX:mySelf.themeBtu];
        [mySelf.view bringSubviewToFront:mySelf.themeView];
        mySelf.status = @"话题记录";
        [mySelf changeNavRightTitle:mySelf.status];
    };
    [topView addSubview:_themeBtu];
    //:--达人记录按钮--
    _articleBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/4*3, 0,kScreenWidth/4, 60)];
    _articleBtu.name = @"达人记录";
    _articleBtu.count = @"0";
    _articleBtu.btuColor = Color_999999;
    _articleBtu.touchUpInside = ^{
        mySelf.pictureBtu.btuColor = Color_999999;
        mySelf.videoBtu.btuColor = Color_999999;
        mySelf.themeBtu.btuColor = Color_999999;
        mySelf.articleBtu.btuColor = Color_333333;
        [mySelf changeLineOriginX:mySelf.articleBtu];
        [mySelf.view bringSubviewToFront:mySelf.articleView];
        mySelf.status = @"达人记录";
        [mySelf changeNavRightTitle:mySelf.status];
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
// MARK: --图文记录--
- (MineReleasePictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = [[MineReleasePictureView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_pictureView];
    }
    return _pictureView;
}
// MARK: --视频记录--
- (MineReleaseVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[MineReleaseVideoView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_videoView];
    }
    return _videoView;
}
// MARK: --话题记录--
- (MineReleaseThemeView *)themeView{
    if (!_themeView) {
        _themeView = [[MineReleaseThemeView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_themeView];
    }
    return _themeView;
}
// MARK: --达人记录--
- (MineReleaseArticleView *)articleView{
    if (!_articleView) {
        _articleView = [[MineReleaseArticleView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight - 60)];
        [self.view addSubview:_articleView];
    }
    return _articleView;
}

- (void)createData{
    
    dispatch_queue_t imageAndTitleQueue = dispatch_queue_create("请求图文发布记录", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(imageAndTitleQueue, ^{
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:seachIssueRecord parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"issueType":@"0",@"irQuery":@{@"page":@(0),@"rows":@"15"}} succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.pictureBtu.count = [NSString stringWithFormat:@"%@",result[@"total"]];
            }
        } fail:^(NSError *error) {
            
        }];
    });
    
    dispatch_queue_t videoQueue = dispatch_queue_create("请求视频发布记录", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(videoQueue, ^{
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:seachIssueRecord parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"issueType":@"1",@"irQuery":@{@"page":@(2),@"rows":@"15"}} succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.videoBtu.count = [NSString stringWithFormat:@"%@",result[@"total"]];
            }
        } fail:^(NSError *error) {
            
        }];
    });
    
    dispatch_queue_t themeQueue = dispatch_queue_create("请求话题发布记录", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(themeQueue, ^{
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:seachIssueRecord parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"issueType":@"0",@"irQuery":@{@"page":@(1),@"rows":@"15"}} succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.themeBtu.count = [NSString stringWithFormat:@"%@",result[@"total"]];
            }
        } fail:^(NSError *error) {
            
        }];
    });
    
    dispatch_queue_t alentQueue = dispatch_queue_create("请求达人发布记录", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(alentQueue, ^{
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:seachIssueRecord parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"issueType":@"0",@"irQuery":@{@"page":@(3),@"rows":@"15"}} succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                weakSelf.articleBtu.count = [NSString stringWithFormat:@"%@",result[@"total"]];
            }
        } fail:^(NSError *error) {
            
        }];
    });
    
}

- (void)changeNavRightTitle:(NSString *)status{
    if ([_status isEqualToString:@"图文记录"]) {
        if (_photoAndTitleIsEdit == NO) {
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
        }else{
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"完成" image:nil];
        }
    }else if ([_status isEqualToString:@"视频记录"]){
        if (_videoIsEdit == NO) {
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
        }else{
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"完成" image:nil];
        }
    }else if ([_status isEqualToString:@"话题记录"]){
        if (_themeIsEdit == NO) {
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
        }else{
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"完成" image:nil];
        }
    }else if ([_status isEqualToString:@"达人记录"]){
        if (_alentIsEdit == NO) {
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"编辑" image:nil];
        }else{
            [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"完成" image:nil];
        }
    }
}

- (void)setPhotoAndTitleIsEdit:(BOOL)photoAndTitleIsEdit{
    _photoAndTitleIsEdit = photoAndTitleIsEdit;
    self.pictureView.isEditCell = photoAndTitleIsEdit;
}

- (void)setVideoIsEdit:(BOOL)videoIsEdit{
    _videoIsEdit = videoIsEdit;
    self.videoView.isEditCell = videoIsEdit;
}

- (void)setThemeIsEdit:(BOOL)themeIsEdit{
    _themeIsEdit = themeIsEdit;
    self.themeView.isEditCell = themeIsEdit;
}

- (void)setAlentIsEdit:(BOOL)alentIsEdit{
    _alentIsEdit = alentIsEdit;
    self.articleView.isEditCell = alentIsEdit;
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
