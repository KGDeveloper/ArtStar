//
//  FriendsDetailVC.m
//  ArtStar
//
//  Created by abc on 5/22/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsDetailVC.h"
#import "FriendsDetailTimeComponentView.h"
#import "FriendsDetailZansCell.h"
#import "FriendsDetailCommentCell.h"
#import "FriendsSuspensionView.h"
#import "ZLPlayer.h"
#import "FriendsPlayVideoView.h"
#import <AVKit/AVKit.h>


@interface FriendsDetailVC ()
<UITableViewDelegate,
UITableViewDataSource,
FriendsDetailTimeComponentViewDelegate,
FriendsCommentViewDelegate,
FriendsSuspensionViewDelegate,
FriendsPlayVideoViewdelegate>

@property (nonatomic,strong) UIView *headerView;
/**
 加载图片
 */
@property (nonatomic,strong) FriendsDetailScrollView *detailScrollView;
/**
 竖排排盘
 */
@property (nonatomic,strong) FriendsDetailVericalView *veritocalView;
/**
 显示时间
 */
@property (nonatomic,strong) FriendsDetailTimeComponentView *timeView;
/**
 评论框
 */
@property (nonatomic,strong) FriendsCommentView *commentView;
/**
 选择弹窗
 */
@property (nonatomic,strong) FriendsSuspensionView *suspensionView;
/**
 控制视频播放
 */
@property (nonatomic,strong) FriendsPlayVideoView *videoView;
/**
 播放视频
 */
@property (nonatomic,strong) ZLPlayer *playVideo;
/**
 评论
 */
@property (nonatomic,strong) UITableView *listView;
/**
 头像
 */
@property (nonatomic,strong) UIImageView *userImage;
/**
 昵称
 */
@property (nonatomic,strong) UILabel *nikName;
/**
 删除按钮
 */
@property (nonatomic,strong) UIButton *deleteBtu;
/**
 解析数据
 */
@property (nonatomic,strong) FriendsModel *model;

@end

@implementation FriendsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"动态详情" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"关注" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createDate];
}

/**
 数据拉取
 */
- (void)createDate{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:friendViews parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":_rfimd} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = [arr firstObject];
            mySelf.model = [FriendsModel mj_objectWithKeyValues:dic];
            [mySelf changeUI];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)changeUI{
    if (self.type == 1) {//:--横排--
        if ([_model.composing integerValue] == 0) {
            [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,115 + 65 + 58)];
        }else if ([_model.composing integerValue] == 1){
            [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 30)/690*468 + 20 + 65 + 58)];
        }else{
            [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 30)/690*468 + 20 + 115 + 65 + 58)];
        }
        self.detailScrollView.photosArr = _model.images;
        self.veritocalView.textAlinment = [self textAlignmentWithModelComposing:[_model.composing integerValue]];
        self.veritocalView.isVertical = NO;
        NSData *strData = [_model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        self.veritocalView.textStr = str;
    }else if(self.type == 0){//:--竖排--
        [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 165)/450*690 + 65 + 58)];
        
        self.detailScrollView.frame = CGRectMake(15, 58, kScreenWidth - 30 - 115 - 20, (kScreenWidth - 165)/450*690);
        self.detailScrollView.photosArr = _model.images;
        
        self.veritocalView.frame = CGRectMake(ViewWidth(self.detailScrollView) + 35,58, 115, (kScreenWidth - 165)/450*690);
        self.veritocalView.isVertical = YES;
        self.veritocalView.yyAlignment = YYTextVerticalAlignmentCenter;
        NSData *strData = [_model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        self.veritocalView.textStr = str;
    }else{
        if ([_model.composing integerValue] == 0) {
            [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,115 + 65 + 58)];
        }else if ([_model.composing integerValue] == 1){
            [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 30)/690*468 + 20 + 65 + 58)];
        }else{
            [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 30)/690*468 + 20 + 115 + 65 + 58)];
        }
        NSDictionary *dic = [_model.images firstObject];
        self.videoView.videoIamge = [self thumbnailImageForUrl:dic[@"imageURL"]];
        self.detailScrollView.hidden = YES;
        self.veritocalView.textAlinment = NSTextAlignmentCenter;
        self.veritocalView.isVertical = NO;
        NSData *strData = [_model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        self.veritocalView.textStr = str;
    }
    self.timeView.timeStr = _model.createTimeStr;
    self.timeView.locationStr = _model.location;
}
- (void)settableViewFrame:(CGRect)frame{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableHeaderView = [self setHeaderViewWithFrame:frame];
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _listView.separatorStyle = NO;
    [self.view addSubview:_listView];
    
    [_listView registerClass:[FriendsDetailZansCell class] forCellReuseIdentifier:@"FriendsDetailZansCell"];
    [_listView registerClass:[FriendsDetailCommentCell class] forCellReuseIdentifier:@"FriendsDetailCommentCell"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }else{
        return 55;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FriendsDetailZansCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsDetailZansCell"];
        cell.zansArr = @[@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5",@"1",@"2",@"3",@"4",@"5"];
        return cell;
    }else{
        FriendsDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsDetailCommentCell"];
        if (indexPath.row == 1) {
            cell.isShowCommentBtu = NO;
        }else{
            cell.isShowCommentBtu = YES;
        }
        [cell valuenikName:@"轩哥哥" comment:@"这是一个富文本的信息"];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
        CGRect fatherRact = [tableView convertRect:rect toView:[tableView superview]];
        self.suspensionView.hidden = NO;
        self.suspensionView.frame = CGRectMake(kScreenWidth/2 - 55, fatherRact.origin.y - 38, 110, 33);
    }
}

/**
 动态消息视图

 @param frame 动态消息视图
 @return 动态消息视图
 */
- (UIView *)setHeaderViewWithFrame:(CGRect)frame{
    self.headerView = [[UIView alloc]initWithFrame:frame];
    NSDictionary *dic = _model.user;
    _userImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 28, 28)];
    [_userImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    _userImage.layer.cornerRadius = 14;
    _userImage.layer.masksToBounds = YES;
    [self.headerView addSubview:_userImage];
    
    _nikName = [[UILabel alloc]initWithFrame:CGRectMake(53, 19, 150, 20)];
    _nikName.textColor = Color_333333;
    _nikName.textAlignment = NSTextAlignmentLeft;
    _nikName.font = SYFont(15);
    _nikName.text = dic[@"username"];
    [self.headerView addSubview:_nikName];
    
    _deleteBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtu.frame = CGRectMake(kScreenWidth - 65, 19, 50,20);
    [_deleteBtu setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtu.titleLabel.font = SYFont(11);
    _deleteBtu.contentHorizontalAlignment = NSTextAlignmentRight;
    [_deleteBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [_deleteBtu addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_deleteBtu];
    
    return self.headerView;
}

- (void)deleteAction{
    
}

/**
 图片加载

 @return 图片加载
 */
- (FriendsDetailScrollView *)detailScrollView{
    if (!_detailScrollView) {
        _detailScrollView = [[FriendsDetailScrollView alloc]initWithFrame:CGRectMake(15,58, kScreenWidth - 30, (kScreenWidth - 30)/690*468)];
        [self.headerView addSubview:_detailScrollView];
    }
    return _detailScrollView;
}

/**
 文字排版

 @return 文字排版
 */
- (FriendsDetailVericalView *)veritocalView{
    if (!_veritocalView) {
        _veritocalView = [[FriendsDetailVericalView alloc]initWithFrame:CGRectMake(15,58 + ViewHeight(self.detailScrollView) + 20, kScreenWidth - 30, 115)];
        [self.headerView addSubview:_veritocalView];
    }
    return _veritocalView;
}
/**
 底部时间点赞评论收藏界面

 @return 底部时间点赞评论收藏界面
 */
- (FriendsDetailTimeComponentView *)timeView{
    if (!_timeView) {
        _timeView = [[FriendsDetailTimeComponentView alloc]initWithFrame:CGRectMake(15, ViewHeight(self.headerView) - 65, kScreenWidth - 30, 65)];
        _timeView.delegate = self;
        [self.headerView addSubview:_timeView];
    }
    return _timeView;
}
/**
 评论弹窗

 @return 评论弹窗
 */
- (FriendsCommentView *)commentView{
    if (!_commentView) {
        _commentView = [[FriendsCommentView alloc]initWithFrame:CGRectMake(0,kScreenHeight - 45, kScreenWidth, 45)];
        _commentView.hidden = YES;
        _commentView.delegate = self;
        [self.view insertSubview:_commentView atIndex:99];
    }
    return _commentView;
}
/**
 赋值删除按钮悬浮窗

 @return  赋值删除按钮悬浮窗
 */
- (FriendsSuspensionView *)suspensionView{
    if (!_suspensionView) {
        _suspensionView = [[FriendsSuspensionView alloc]initWithFrame:CGRectMake(0, 0, 110, 33)];
        _suspensionView.delegate = self;
        [self.view insertSubview:_suspensionView atIndex:99];
    }
    return _suspensionView;
}
/**
 返回按钮点击事件

 @param sender 返回按钮点击事件
 */
- (void)leftNavBtuAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 右侧关注按钮惦记时间

 @param sender 右侧关注按钮惦记时间
 */
- (void)rightNavBtuAction:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"已关注"]) {
        [sender setTitle:@"关注" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"已关注" forState:UIControlStateNormal];
    }
}

//MARK:--FriendsDetailTimeComponentViewDelegate代理--
- (void)shareAction{
    DXShareView *shareView = [[DXShareView alloc] init];
    DXShareModel *shareModel = [[DXShareModel alloc] init];
    shareModel.title = @"测试分享功能";
    shareModel.descr = @"这里是描述内容";
    shareModel.url = @"https://www.baidu.com";
    UIImage *thumbImage = [UIImage imageNamed:@"weixin_allshare"];
    shareModel.thumbImage = thumbImage;
    [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeImage];
}
- (void)collectionAction{
    
}
- (void)zansAction{
    
}
/**
 评论弹窗
 */
- (void)commentAction{
    self.commentView.hidden = NO;
    [self.commentView.commnetView becomeFirstResponder];
    self.commentView.commnetView.text = @"";
    self.commentView.plholder = @"评论:";
}
//MARK:--FriendsCommentViewDelegate--
- (void)releaseComment:(NSString *)comment{
    
}
//MARK:--FriendsSuspensionViewDelegate--
- (void)leftAction:(NSInteger)index{
    
}
- (void)rightAction:(NSInteger)index{
    
}
/**
 在当前界面播放视频
 */
- (void)playModelVideo{
    
    NSArray *imageArr = _model.images;
    NSDictionary *dic = [imageArr firstObject];
    self.playVideo.videoUrl = [NSURL URLWithString:dic[@"imageURL"]];
    self.playVideo.hidden = NO;
    [self.playVideo play];
    self.navigationController.navigationBar.hidden = YES;
}
/**
 创建播放视频界面

 @return 视频播放器
 */
- (ZLPlayer *)playVideo{
    if (!_playVideo) {
        _playVideo = [[ZLPlayer alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.view insertSubview:_playVideo belowSubview:self.view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchVideoPlay)];
        [_playVideo addGestureRecognizer:tap];
    }
    return _playVideo;
}
/**
 点击播放视频
 */
- (void)touchVideoPlay{
    [self.playVideo reset];
    self.playVideo.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}
- (FriendsPlayVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[FriendsPlayVideoView alloc]initWithFrame:CGRectMake(15,58, kScreenWidth - 30, (kScreenWidth - 30)/690*468)];
        _videoView.delegate = self;
        [self.headerView addSubview:_videoView];
    }
    return _videoView;
}

/**
 根据模型排版数据判断文字对齐方式

 @param composing 根据模型排版数据判断文字对齐方式
 @return 根据模型排版数据判断文字对齐方式
 */
- (NSTextAlignment)textAlignmentWithModelComposing:(NSInteger)composing{
    switch (composing) {
        case 0:
            return NSTextAlignmentCenter;
            break;
        case 2:
            return NSTextAlignmentCenter;
            break;
        case 5:
            return NSTextAlignmentLeft;
            break;
        case 6:
            return NSTextAlignmentCenter;
            break;
        case 7:
            return NSTextAlignmentRight;
            break;
        case 8:
            return NSTextAlignmentLeft;
            break;
        case 9:
            return NSTextAlignmentCenter;
            break;
        default:
            return NSTextAlignmentRight;
            break;
    }
}
/**
 获取视频第一帧图片

 @param url 获取视频第一帧图片
 @return 获取视频第一帧图片
 */
- (UIImage *)thumbnailImageForUrl:(NSString *)url{
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:[NSURL URLWithString:url] options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImagegenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImagegenerator.appliesPreferredTrackTransform = YES;
    assetImagegenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTile = 1;
    NSError *error = nil;
    thumbnailImageRef = [assetImagegenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTile, 60) actualTime:NULL error:&error];
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
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
