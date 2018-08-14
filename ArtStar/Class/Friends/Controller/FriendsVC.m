//
//  FriendsVC.m
//  ArtStar
//
//  Created by abc on 5/17/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsVC.h"
#import "HW3DBannerView.h"
#import "FriendsDetailVC.h"
#import "FriendsMessageView.h"
#import "FriendsMessageVC.h"
#import "FriendsTalentTableViewCell.h"
#import "FriendsTalentDetailVC.h"
#import "FriendsThemeLeftImageCell.h"

@interface FriendsVC ()
<UITableViewDelegate,
UITableViewDataSource,
FriendsThemeTopImageCellDelegate,//:--话题cell--
FriendsThemeButtomImageCellDelegate,
FriendsThemeLeftImageCellDelegate,
FriendsThemeCirulerImageCellDelegate,
FriendsOnlyHaveImageCellDelegate,//:--图文cell--
FriendsOnlyHaveLabelCellDelegate,
FriendsMessageViewDelegate,
DZNEmptyDataSetDelegate,//:--空白页面代理--
DZNEmptyDataSetSource
>

@property (nonatomic,strong) HW3DBannerView *bannerView;//:--顶部滚动式图--
@property (nonatomic,strong) FriendsMessageView *messageView;//:--消息提示窗--
@property (nonatomic,strong) UITableView *listView;//:--动态加载--
@property (nonatomic,strong) UIView *headerView;//:--承载顶部滚动视图以及消息提示框--
@property (nonatomic,strong) NSMutableArray *dataArr;//:--解析后的数据保存--
@property (nonatomic,assign) NSInteger page;//:--页数--
@property (nonatomic,assign) BOOL isFirst;//:--是否是第一次进入页面--


@end

@implementation FriendsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    if (_isFirst == YES) {
        _dataArr = [NSMutableArray array];
        _page = 1;
        [self createData];
        [self createMsgArr];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    _isFirst = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    _page = 1;
    _dataArr = [NSMutableArray array];
    [self createData];
    [self createMsgArr];
    [self setTableView];
}
//:--每次页面刷新都去请求是否有新消息--
- (void)createMsgArr{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:friendsunreadMessageCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        NSArray *tmpArr = result[@"data"];
        NSDictionary *dic = [tmpArr firstObject];
        if ([dic[@"count"] integerValue] == 0) {//:--消息数为0，降低头视图的高度，去掉消息弹窗--
            mySelf.headerView.size = CGSizeMake(kScreenWidth, (kScreenWidth - 40)/670*450);
            mySelf.messageView.hidden = YES;
        }else{//:--如果有最新消息，加载消息弹窗，增加头视图高度--
            mySelf.messageView.hidden = NO;
            mySelf.headerView.size = CGSizeMake(kScreenWidth, (kScreenWidth - 40)/670*450 + 60);
            mySelf.messageView.messStr = [NSString stringWithFormat:@"%ld条新消息",[dic[@"count"] integerValue]];
        }
        [mySelf.listView reloadData];
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}
//:--请求动态数据--
- (void)createData{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:searchfriendMessages parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfquery":@{@"page":@(_page),@"rows":@"15"},@"brushPerss":@"1"} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *dataarray = result[@"data"];
            for (int i = 0; i <  dataarray.count; i++) {
                NSDictionary *dic = dataarray[i];
                FriendsModel *model = [FriendsModel mj_objectWithKeyValues:dic];
                [mySelf.dataArr addObject:model];
            }
            [mySelf.listView reloadData];
            [mySelf.listView.mj_header endRefreshing];
            [mySelf.listView.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {

    }];
}
//:--创建动态显示页面--
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - NavButtomHeight - 49 - 20)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.emptyDataSetSource = self;
    _listView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    _listView.tableHeaderView = [self setTableViewHeader];
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _listView.separatorStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) mySelf = self;
    //:--在此处刷新的时候，不仅仅刷新动态，还要请求最新消息--
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        mySelf.page = 1;
        mySelf.dataArr = [NSMutableArray array];
        [mySelf createData];
        [mySelf createMsgArr];
        [mySelf.listView.mj_header beginRefreshing];
    }];
    _listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        mySelf.page ++;
        [mySelf createData];
        [mySelf.listView.mj_footer beginRefreshing];
    }];
    [self.view addSubview:_listView];
    //:--只有图片--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsOnlyHaveImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsOnlyHaveImageCell"];
    //:--只有文字--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsOnlyHaveLabelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsOnlyHaveLabelCell"];
    //:--话题--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsThemeTopImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsThemeTopImageCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FriendsThemeButtomImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsThemeButtomImageCell"];
    [_listView registerClass:[FriendsThemeLeftImageCell class] forCellReuseIdentifier:@"FriendsThemeLeftImageCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FriendsThemeCirulerImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsThemeCirulerImageCell"];
    [_listView registerNib:[UINib nibWithNibName:@"FriendsTalentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsTalentTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
//:--加载顶部广告位--
- (UIView *)setTableViewHeader{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenWidth - 40)/670*450 + 60)];
    _bannerView = [HW3DBannerView initWithFrame:CGRectMake(0,0, kScreenWidth, (kScreenWidth - 40)/670*450) imageSpacing:5 imageWidth:kScreenWidth - 40];
    _bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView.data = @[Image(@"图片加载失败"),Image(@"图片加载失败"),Image(@"图片加载失败"),Image(@"图片加载失败"),Image(@"图片加载失败")];
    _bannerView.imageRadius = 5;
    _bannerView.imageHeightPoor = 25;
    _bannerView.showPageControl = NO;
    _bannerView.autoScroll = YES;
    _bannerView.autoScrollTimeInterval = 1;
    _bannerView.initAlpha = 0.9;
    _bannerView.buttomViewColor = [UIColor whiteColor];
    [self.headerView addSubview:_bannerView];
    self.headerView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    return self.headerView;
}
//:--加载消息弹窗--
- (FriendsMessageView *)messageView{
    if (!_messageView) {
        _messageView = [[FriendsMessageView alloc]initWithFrame:CGRectMake(0, ViewHeight(_bannerView), kScreenWidth, 60)];
        _messageView.delegate = self;
        [self.headerView addSubview:_messageView];
    }
    return _messageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsModel *model = _dataArr[indexPath.row];
    if ([model.composing integerValue] == 0) {
        return OnlyHaveTitleHeight + 40;
    }else if ([model.composing integerValue] == 1){
        return OnlyHaveImageHeight + 40;
    }else if ([model.composing integerValue] == 2){
        return curileImageHeight + 40;
    }else if ([model.composing integerValue] == 3){
        return LeftAndRightHeight + 40;
    }else if ([model.composing integerValue] == 4){
        return LeftAndRightHeight + 40;
    }else if ([model.composing integerValue] == 5){
        return TopAndBottomHeight + 40;
    }else if ([model.composing integerValue] == 6){
        return TopAndBottomHeight + 40;
    }else if ([model.composing integerValue] == 7){
        return TopAndBottomHeight + 40;
    }else if ([model.composing integerValue] == 8){
        return TopAndBottomHeight + 40;
    }else if ([model.composing integerValue] == 9){
        return TopAndBottomHeight + 40;
    }else if ([model.composing integerValue] == 10){
        return TopAndBottomHeight + 40;
    }else{
        return talentHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsModel *model = _dataArr[indexPath.row];
    //MARK:----------------------------------------只有文字------------------------------------------------
    if ([model.composing integerValue] == 0) {
        FriendsOnlyHaveLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveLabelCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:----------------------------------------只有图片------------------------------------------------
    }else if ([model.composing integerValue] == 1){
        FriendsOnlyHaveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:-----------------------------------------圆形图片-----------------------------------------------
    }else if ([model.composing integerValue] == 2){
        FriendsThemeCirulerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeCirulerImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:----------------------------------------文字居右居上------------------------------------------------
    }else if ([model.composing integerValue] == 3){
        FriendsThemeLeftImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeLeftImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:------------------------------------------文字居右居中----------------------------------------------
    }else if ([model.composing integerValue] == 4){
        FriendsThemeLeftImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeLeftImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:-------------------------------------------文字居上局座---------------------------------------------
    }else if ([model.composing integerValue] == 5){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:------------------------------------------文字居上居中----------------------------------------------
    }else if ([model.composing integerValue] == 6){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:-----------------------------------------文字居上居右-----------------------------------------------
    }else if ([model.composing integerValue] == 7){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:---------------------------------------------文字局下局座-------------------------------------------
    }else if ([model.composing integerValue] == 8){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:---------------------------------------------文字局下居中-------------------------------------------
    }else if ([model.composing integerValue] == 9){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
        //MARK:----------------------------------------------文字局下居右------------------------------------------
    }else if ([model.composing integerValue] == 10){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:model];
        return cell;
    }else{
        //MARK:--------------------------------------------达人发布的内容--------------------------------------------
        FriendsTalentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsTalentTableViewCell"];
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikName.text = dic[@"username"];
        cell.titleLab.text = model.title;
        cell.detailLab.attributedText = [TransformChineseToPinying string:model.content font:SYFont(12) space:10];;
        NSArray *arr = model.images;
        NSDictionary *imageDic = [arr firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.videoBack.hidden = YES;
        cell.videoPlay.hidden = YES;
        cell.locationLab.text = model.location;
        cell.countLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)arr.count];
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsModel *model = _dataArr[indexPath.row];
    if ([model.composing integerValue] == 11) {
        FriendsTalentDetailVC *vc = [[FriendsTalentDetailVC alloc]init];
        vc.ID = model.issId;
        vc.msgID = model.ID;
        [self pushNoTabBarViewController:vc animated:YES];
    }else{
        if ([model.type integerValue] == 0 || [model.type integerValue] == 1) {
            FriendsDetailVC *vc = [[FriendsDetailVC alloc]init];
            if ([model.composing integerValue] == 3 || [model.composing integerValue] == 4) {
                vc.type = 0;
            }else{
                vc.type = 1;
            }
            vc.rfimd = model.ID;
            [self pushNoTabBarViewController:vc animated:YES];
        }else if ([model.type integerValue] == 2){
            FriendsDetailVC *vc = [[FriendsDetailVC alloc]init];
            vc.type = 2;
            vc.rfimd = model.ID;
            [self pushNoTabBarViewController:vc animated:YES];
        }
    }
}

//MARK:--横排文字改变排版--
- (UITextView *)changeTextViewLineSpace:(UITextView *)textView string:(NSString *)text alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 7;
    paragraphStyle.alignment = alignment;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(12),NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
}
//MARK:--竖排文字改变排版--
//MARK:--FriendsOnlyHaveImageCellDelegate,FriendsTopImageButtomLabelCellDelegate,FriendsButtomImageTopLabelCellDelegate,FriendsLeftImageRightLabelCellDelegate,FriendsOnlyHaveLabelCellDelegate--
- (void)headerPushInfo:(NSInteger)index{
    
}
- (void)deleteCell:(NSInteger)index{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:deleteFriendMsg parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":@(index)} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"删除成功" toView:weakSelf.view hideAfter:1];
            [weakSelf createData];
            [weakSelf createMsgArr];
        }else{
            [MBProgressHUD bwm_showTitle:@"删除失败" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"删除失败" toView:weakSelf.view hideAfter:1];
    }];
}
- (void)zansCell:(NSInteger)index{
    __weak typeof(self) mySelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:firendlikeCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":@(index)} succ:^(id result) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}
- (void)commentCell:(NSInteger)index{
    
    
}
- (void)shareCell:(NSInteger)index{
    DXShareView *shareView = [[DXShareView alloc] init];
    DXShareModel *shareModel = [[DXShareModel alloc] init];
    shareModel.title = @"测试分享功能";
    shareModel.descr = @"这里是描述内容";
    shareModel.url = @"https://www.baidu.com";
    UIImage *thumbImage = [UIImage imageNamed:@"weixin_allshare"];
    shareModel.thumbImage = thumbImage;
    [shareView showShareViewWithDXShareModel:shareModel shareContentType:DXShareContentTypeImage];
}

//MARK:--FriendsMessageViewDelegate--
- (void)loadMessage{
    FriendsMessageVC *vc = [[FriendsMessageVC alloc]init];
    [self pushNoTabBarViewController:vc animated:YES];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"木有内容哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
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
