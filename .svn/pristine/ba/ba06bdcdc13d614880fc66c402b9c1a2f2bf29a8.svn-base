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
#import "FriendsPlayVideoView.h"
#import "FriendsVideoView.h"


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
@property (nonatomic,strong) FriendsPlayVideoView *playVideo;
/**
 播放视频
 */
@property (nonatomic,strong) FriendsVideoView *videoView;
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
        [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 30)/690*468 + 20 + 115 + 65 + 58)];
        self.detailScrollView.photosArr = _model.images;
        self.veritocalView.textAlinment = NSTextAlignmentCenter;
        self.veritocalView.isVertical = NO;
        self.veritocalView.textStr = @"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯";
    }else if(self.type == 0){//:--竖排--
        [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 165)/450*690 + 65 + 58)];
        
        self.detailScrollView.frame = CGRectMake(15, 58, kScreenWidth - 30 - 115 - 20, (kScreenWidth - 165)/450*690);
        self.detailScrollView.photosArr = _model.images;
        
        self.veritocalView.frame = CGRectMake(ViewWidth(self.detailScrollView) + 35,58, 115, (kScreenWidth - 165)/450*690);
        self.veritocalView.isVertical = YES;
        self.veritocalView.yyAlignment = YYTextVerticalAlignmentCenter;
        self.veritocalView.textStr = @"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯";
    }else{
        [self settableViewFrame:CGRectMake(0, 0, kScreenWidth,(kScreenWidth - 30)/690*468 + 20 + 115 + 65 + 58)];
        
        self.playVideo.hidden = NO;
        self.detailScrollView.hidden = YES;
        
        self.veritocalView.textAlinment = NSTextAlignmentCenter;
        self.veritocalView.isVertical = NO;
        self.veritocalView.textStr = @"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯";
    }
    self.timeView.timeStr = @"2018-05-22";
    self.timeView.locationStr = @"北京";
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

- (UIView *)setHeaderViewWithFrame:(CGRect)frame{
    self.headerView = [[UIView alloc]initWithFrame:frame];
    
    _userImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 28, 28)];
    _userImage.image = Image(@"1");
    _userImage.layer.cornerRadius = 14;
    _userImage.layer.masksToBounds = YES;
    [self.headerView addSubview:_userImage];
    
    _nikName = [[UILabel alloc]initWithFrame:CGRectMake(53, 19, 150, 20)];
    _nikName.textColor = Color_333333;
    _nikName.textAlignment = NSTextAlignmentLeft;
    _nikName.font = SYFont(15);
    _nikName.text = @"巴啦啦能量";
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

- (FriendsDetailScrollView *)detailScrollView{
    if (!_detailScrollView) {
        _detailScrollView = [[FriendsDetailScrollView alloc]initWithFrame:CGRectMake(15,58, kScreenWidth - 30, (kScreenWidth - 30)/690*468)];
        [self.headerView addSubview:_detailScrollView];
    }
    return _detailScrollView;
}

- (FriendsDetailVericalView *)veritocalView{
    if (!_veritocalView) {
        _veritocalView = [[FriendsDetailVericalView alloc]initWithFrame:CGRectMake(15,58 + ViewHeight(self.detailScrollView) + 20, kScreenWidth - 30, 115)];
        [self.headerView addSubview:_veritocalView];
    }
    return _veritocalView;
}

- (FriendsDetailTimeComponentView *)timeView{
    if (!_timeView) {
        _timeView = [[FriendsDetailTimeComponentView alloc]initWithFrame:CGRectMake(15, ViewHeight(self.headerView) - 65, kScreenWidth - 30, 65)];
        _timeView.delegate = self;
        [self.headerView addSubview:_timeView];
    }
    return _timeView;
}

- (FriendsCommentView *)commentView{
    if (!_commentView) {
        _commentView = [[FriendsCommentView alloc]initWithFrame:CGRectMake(0,kScreenHeight - 45, kScreenWidth, 45)];
        _commentView.hidden = YES;
        _commentView.delegate = self;
        [self.view insertSubview:_commentView atIndex:99];
    }
    return _commentView;
}

- (FriendsPlayVideoView *)playVideo{
    if (!_playVideo) {
        _playVideo = [[FriendsPlayVideoView alloc]initWithFrame:CGRectMake(15,58, kScreenWidth - 30, (kScreenWidth - 30)/690*468)];
        _playVideo.delegate = self;
        [self.headerView addSubview:_playVideo];
    }
    return _playVideo;
}

- (FriendsSuspensionView *)suspensionView{
    if (!_suspensionView) {
        _suspensionView = [[FriendsSuspensionView alloc]initWithFrame:CGRectMake(0, 0, 110, 33)];
        _suspensionView.delegate = self;
        [self.view insertSubview:_suspensionView atIndex:99];
    }
    return _suspensionView;
}
- (void)leftNavBtuAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
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
//MARK:--FriendsPlayVideoViewdelegate--
- (void)playModelVideo{
    self.videoView.hidden = NO;
    [self.videoView playWith:[NSURL URLWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"]];
}

- (FriendsVideoView *)videoView{
    if (!_videoView) {
        _videoView = [[FriendsVideoView alloc]initWithFrame:CGRectMake(0, NavTopHeight - 44, kScreenWidth, kScreenHeight - NavTopHeight + 44)];
        [self.navigationController.view addSubview:_videoView];
    }
    return _videoView;
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
