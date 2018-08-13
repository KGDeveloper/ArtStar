//
//  PreviewVC.m
//  ArtStar
//
//  Created by abc on 5/11/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "PreviewVC.h"
#import "PreviewVerticalView.h"
#import "PreviewHorizontalView.h"
#import "PreviewVideoPlayView.h"
#import "ZLPlayer.h"

@interface PreviewVC ()<PreviewVideoPlayViewDelegate>

@property (nonatomic,strong) UIImageView *headerIamge;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) PreviewHorizontalView *horizontalView;
@property (nonatomic,strong) PreviewVerticalView *verticalView;
@property (nonatomic,strong) PreviewVideoPlayView *videoView;
@property (nonatomic,strong) ZLPlayer *playVideo;

@end

@implementation PreviewVCModel
@end

@implementation PreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"预览" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"确定" image:nil];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    self.height = NavTopHeight + 30 + 28;
    
    [self setUI];
}

- (void)rightNavBtuAction:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __block NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[KGUserInfo shareInterace].userTokenCode forKey:@"tokenCode"];
    [parameters setObject:_model.visitPermission forKey:@"visitPermission"];
    [parameters setObject:_model.location forKey:@"location"];
    [parameters setObject:_model.composing forKey:@"composing"];
    [parameters setObject:@([_model.typeStr integerValue]) forKey:@"type"];
    //:--判断是否有文字内容--
    if (_model.str1.length > 0 && _model.str1 != nil) {
        NSArray *strArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:strArr options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        [parameters setObject:jsonStr forKey:@"content"];
    }else{
        [parameters setObject:@"" forKey:@"content"];
    }
    //:--判断是否@别人--
    if (_model.ids.count > 0) {
        [parameters setObject:_model.ids forKey:@"ids"];
    }else{
        [parameters setObject:@[] forKey:@"ids"];
    }
    //:--判断是否有话题--
    if (_model.title.length > 0 && _model.title != nil) {
        [parameters setObject:_model.title forKey:@"title"];
    }
    if ([self topicTypeWithString:_model.topicType] != 10) {
        [parameters setObject:@([self topicTypeWithString:_model.topicType]) forKey:@"topicType"];
    }
    //:--判断是否有图片--
    __weak typeof(self) mySelf = self;
    if (_model.imageURLs.count > 0) {
        __block NSMutableArray *imageArr = [NSMutableArray array];
        if ([_model.imageURLs[@"key"] isEqualToString:@"image"]) {
            dispatch_queue_t imageQueue = dispatch_queue_create("上传图片", DISPATCH_QUEUE_CONCURRENT);
            dispatch_sync(imageQueue, ^{
                [mySelf.model.imageURLs[@"image"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [[KGQiniuUploadManager shareInstance] uploadImageToQiniuWithFile:[[KGQiniuUploadManager shareInstance] getImagePath:obj] fileName:nil result:^(NSString *strPath) {
                        [imageArr addObject:strPath];
                        [parameters setObject:imageArr forKey:@"imageURLs"];
                        [mySelf requestDataWithArr:imageArr dic:parameters];
                    }];
                }];
            });
        }else{
            dispatch_queue_t imageQueue = dispatch_queue_create("上传视频", DISPATCH_QUEUE_CONCURRENT);
            dispatch_sync(imageQueue, ^{
                [[KGQiniuUploadManager shareInstance] uploadDataToQiniuWithData:mySelf.model.imageURLs[@"image"] result:^(NSString *strPath) {
                    [imageArr addObject:strPath];
                    [parameters setObject:imageArr forKey:@"imageURLs"];
                    [mySelf requestDataWithArr:imageArr dic:parameters];
                }];
            });
        }
    }else{
        [parameters setObject:@[] forKey:@"imageURLs"];
        [KGRequestNetWorking postWothUrl:ReleaseFriendTimelineAddfriendMessage parameters:parameters succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布成功" hideAfter:1];
                [mySelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布失败" hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布失败" hideAfter:1];
        }];
    }
    
}

- (void)requestDataWithArr:(NSMutableArray *)arr dic:(NSMutableDictionary *)parameters{
    __weak typeof(self) mySelf = self;
    NSArray *tmpArr = _model.imageURLs[@"image"];
    if (arr.count == tmpArr.count) {
        [KGRequestNetWorking postWothUrl:ReleaseFriendTimelineAddfriendMessage parameters:parameters succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布成功" hideAfter:1];
                [mySelf.navigationController popViewControllerAnimated:YES];
            }else{
                [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布失败" hideAfter:1];
            }
            
        } fail:^(NSError *error) {
            [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
            [[MBProgressHUD showHUDAddedTo:mySelf.view animated:YES] bwm_hideWithTitle:@"发布失败" hideAfter:1];
        }];
    }
}

- (NSInteger)topicTypeWithString:(NSString *)str{
    if ([str isEqualToString:@"美术"]) {
        return 1;
    }else if ([str isEqualToString:@"设计"]){
        return 8;
    }else if ([str isEqualToString:@"摄影"]){
        return 7;
    }else if ([str isEqualToString:@"电影"]){
        return 3;
    }else if ([str isEqualToString:@"书籍"]){
        return 5;
    }else if ([str isEqualToString:@"文学"]){
        return 9;
    }else if ([str isEqualToString:@"音乐"]){
        return 2;
    }else if ([str isEqualToString:@"戏剧"]){
        return 4;
    }else if ([str isEqualToString:@"美食"]){
        return 6;
    }else{
        return 10;
    }
}

//MARK:--选择加载页面--
- (void)setUI{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];
    back.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:back];
    
    _headerIamge = [[UIImageView alloc]initWithFrame:CGRectMake(15, NavTopHeight + 15, 28, 28)];
    [_headerIamge sd_setImageWithURL:[NSURL URLWithString:[KGUserInfo shareInterace].portraitUri]];
    _headerIamge.layer.cornerRadius = 14;
    _headerIamge.layer.masksToBounds = YES;
    [self.view addSubview:_headerIamge];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25 + 28, NavTopHeight + 15 + 4, kScreenWidth - 25 - 28, 20)];
    _nameLabel.text = [KGUserInfo shareInterace].userName;
    _nameLabel.font = SYFont(15);
    [self.view addSubview:_nameLabel];
    
    switch (self.type) {
        case EditTypeVideo:
            [self setVideoView];
            break;
        case EditTypeTheme:
            [self setThemeView];
            break;
        default:
            // !!!: --在这里删除了图文的调用，因为话题与图文合并了--
            break;
    }
}
//MARK:--话题页面--
- (void)setThemeView{
    switch (_themeType) {
        case EditThemeTypeOnlyTitle:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeOnlyLabel];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditThemeTypeOnlyPicture:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeOnlyImage];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditThemeTypeCircular:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeCircular];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditThemeTypeRightTop:
            [self setUpVerticalView:LabelTextLocationTypeTop];
            self.verticalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.verticalView.imageArr = _model.imageURLs[@"image"];
            self.verticalView.timeStr = @"5分钟前";
            self.verticalView.locationStr = _model.location;
            self.verticalView.themeStr = _model.title;
            break;
        case EditThemeTypeRightCenter:
            [self setUpVerticalView:LabelTextLocationTypeCenter];
            self.verticalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.verticalView.imageArr = _model.imageURLs[@"image"];
            self.verticalView.timeStr = @"5分钟前";
            self.verticalView.locationStr = _model.location;
            self.verticalView.themeStr = _model.title;
            break;
        case EditThemeTypeTopLeft:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeLeft;
            break;
        case EditThemeTypeTopCenter:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        case EditThemeTypeTopRight:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeLabelTop];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeRight;
            break;
        case EditThemeTypeLeft:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeLeft;
            break;
        case EditThemeTypeCenter:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeCenter;
            break;
        default:
            [self setHViewfrmae:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:LabelAndImageTypeImageTop];
            self.horizontalView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.horizontalView.imageArr = _model.imageURLs[@"image"];
            self.horizontalView.timeStr = @"5分钟前";
            self.horizontalView.locationStr = _model.location;
            self.horizontalView.themeStr = _model.title;
            self.horizontalView.type = TextAlignmentTypeRight;
            break;
    }
}
//MARK:--视频页面--
- (void)setVideoView{
    switch (_videoType) {
        case EditVideoTypeOnlyVideo:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, photoViewHeight + 50) type:VideoViewTextTypeOnlyVideo];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            break;
        case EditVideoTypeTopLeft:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeTopLeftText];
            self.videoView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            self.videoView.type = TextAlignmentLeft;
            break;
        case EditVideoTypeTopCenter:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeTopCenterText];
            self.videoView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            self.videoView.type = TextAlignmentCenter;
            break;
        case EditVideoTypeTopRight:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeTopRightText];
            self.videoView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            self.videoView.type = TextAlignmentRight;
            break;
        case EditVideoTypeLeft:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeButtomLeftText];
            self.videoView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            self.videoView.type = TextAlignmentLeft;
            break;
        case EditVideoTypeCenter:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeButtomCenterText];
            self.videoView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            self.videoView.type = TextAlignmentTypeCenter;
            break;
        default:
            [self setUpVideoViewframe:CGRectMake(0, _height, kScreenWidth, 220 + photoViewHeight) type:VideoViewTextTypeButtomRightText];
            self.videoView.titleArr = @[_model.str1,_model.str2,_model.str3,_model.str4,_model.str5];
            self.videoView.timeStr = @"5分钟前";
            self.videoView.locationStr = _model.location;
            self.videoView.playVideo = _model.imageURLs[@"image"];
            self.videoView.type = TextAlignmentRight;
            break;
    }
}
- (void)setHViewfrmae:(CGRect)frmae type:(LabelAndImageType)type{
    _horizontalView = [[PreviewHorizontalView alloc]initWithFrame:frmae type:type];
    _horizontalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_horizontalView];
}
- (void)setUpVerticalView:(LabelTextLocationType)type{
    _verticalView = [[PreviewVerticalView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, 281 + 100) type:type];
    _verticalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_verticalView];
}
- (void)setUpVideoViewframe:(CGRect)frame type:(VideoViewTextType)type{
    _videoView = [[PreviewVideoPlayView alloc]initWithFrame:frame type:type];
    _videoView.backgroundColor = [UIColor whiteColor];
    _videoView.delegate = self;
    [self.view addSubview:_videoView];
}
- (void)playVideoOnController{
    self.playVideo.videoUrl = _model.imageURLs[@"image"];
    self.playVideo.hidden = NO;
    [self.playVideo play];
    self.navigationController.navigationBar.hidden = YES;
}
- (ZLPlayer *)playVideo{
    if (!_playVideo) {
        _playVideo = [[ZLPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view insertSubview:_playVideo belowSubview:self.view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchVideoPlay)];
        [_playVideo addGestureRecognizer:tap];
    }
    return _playVideo;
}
- (void)touchVideoPlay{
    [self.playVideo reset];
    self.playVideo.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
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
