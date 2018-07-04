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

@interface FriendsVC ()
<UITableViewDelegate,
UITableViewDataSource,
FriendsThemeTopImageCellDelegate,
FriendsThemeButtomImageCellDelegate,
FriendsThemeLeftImageCellDelegate,
FriendsThemeCirulerImageCellDelegate,
FriendsOnlyHaveImageCellDelegate,
FriendsTopImageButtomLabelCellDelegate,
FriendsButtomImageTopLabelCellDelegate,
FriendsLeftImageRightLabelCellDelegate,
FriendsOnlyHaveLabelCellDelegate,
FriendsCurilerImageCellDelegate,
FriendsMessageViewDelegate>

@property (nonatomic,strong) HW3DBannerView *bannerView;
@property (nonatomic,strong) FriendsMessageView *messageView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,assign) NSNumber *msgCount;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation FriendsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _msgCount = 0;
    [self createData];
    [self createMsgArr];
    [self setTableView];
}

- (void)createMsgArr{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:ReleaseFriendTimelineunreadMessageCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        NSArray *tmpArr = result[@"data"];
        NSDictionary *dic = [tmpArr firstObject];
        if ([dic[@"count"] integerValue] == 0) {
            mySelf.headerView.size = CGSizeMake(kScreenWidth, (kScreenWidth - 40)/670*450);
        }else{
            mySelf.headerView.size = CGSizeMake(kScreenWidth, (kScreenWidth - 40)/670*450 + 60);
            mySelf.messageView.messStr = [NSString stringWithFormat:@"%@条新消息",mySelf.msgCount];
        }
        [mySelf.listView reloadData];
    } fail:^(NSString *error) {
        
    }];
}

- (void)createData{
    
    _dataArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:ReleaseFriendTimeline parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfquery":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *dataarray = result[@"data"];
            for (int i = 0; i <  dataarray.count; i++) {
                NSDictionary *dic = dataarray[i];
                FriendsModel *model = [FriendsModel mj_objectWithKeyValues:dic];
                [mySelf.dataArr addObject:model];
            }
            [mySelf.listView reloadData];
            [mySelf.listView.mj_header endRefreshing];
        }
    } fail:^(NSString *error) {

    }];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - NavButtomHeight - 20)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    _listView.tableHeaderView = [self setTableViewHeader];
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _listView.separatorStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) mySelf = self;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [mySelf createData];
        [mySelf createMsgArr];
        [mySelf.listView.mj_header beginRefreshing];
    }];
    [self.view addSubview:_listView];
    //:--只有图片--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsOnlyHaveImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsOnlyHaveImageCell"];
    //:--图片在上--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsTopImageButtomLabelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsTopImageButtomLabelCell"];
    //:--图片在下--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsButtomImageTopLabelCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsButtomImageTopLabelCell"];
    //:--图片在左--
    [_listView registerClass:[FriendsLeftImageRightLabelCell class] forCellReuseIdentifier:@"FriendsLeftImageRightLabelCell"];
    //:--圆形图片--
    [_listView registerNib:[UINib nibWithNibName:@"FriendsCurilerImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriendsCurilerImageCell"];
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
- (UIView *)setTableViewHeader{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenWidth - 40)/670*450 + 60)];
    _bannerView = [HW3DBannerView initWithFrame:CGRectMake(0,0, kScreenWidth, (kScreenWidth - 40)/670*450) imageSpacing:5 imageWidth:kScreenWidth - 40];
    _bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView.data = @[Image(@"1"),Image(@"2"),Image(@"3"),Image(@"4"),Image(@"5")];
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
    if ([model.composing isEqualToString:@"0"]) {
        return OnlyHaveTitleHeight;
    }else if ([model.composing isEqualToString:@"1"]){
        return OnlyHaveImageHeight;
    }else if ([model.composing isEqualToString:@"2"]){
        return curileImageHeight;
    }else if ([model.composing isEqualToString:@"3"]){
        return LeftAndRightHeight;
    }else if ([model.composing isEqualToString:@"4"]){
        return LeftAndRightHeight;
    }else if ([model.composing isEqualToString:@"5"]){
        return TopAndBottomHeight;
    }else if ([model.composing isEqualToString:@"6"]){
        return TopAndBottomHeight;
    }else if ([model.composing isEqualToString:@"7"]){
        return TopAndBottomHeight;
    }else if ([model.composing isEqualToString:@"8"]){
        return TopAndBottomHeight + 20;
    }else if ([model.composing isEqualToString:@"9"]){
        return TopAndBottomHeight + 20;
    }else if ([model.composing isEqualToString:@"10"]){
        return TopAndBottomHeight + 20;
    }else{
        return talentHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsModel *model = _dataArr[indexPath.row];
    if ([model.composing isEqualToString:@"0"]) {
        FriendsOnlyHaveLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveLabelCell"];
        [self changeTextViewLineSpace:cell.textView string:model.content alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        cell.timeLab.text = model.createTime;
        cell.locationLab.text = model.location;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        cell.cellIndex = indexPath.row;
        return cell;
    }else if ([model.composing isEqualToString:@"1"]){
        FriendsOnlyHaveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveImageCell"];
        cell.delegate = self;
        return cell;
    }else if ([model.composing isEqualToString:@"2"]){
        FriendsCurilerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCurilerImageCell"];
        [ChangeTextViewTextStyle changeTextView:cell.textView text:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        return cell;
    }else if ([model.composing isEqualToString:@"3"]){
        FriendsLeftImageRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsLeftImageRightLabelCell"];
        cell.delegate = self;
        return cell;
    }else if ([model.composing isEqualToString:@"4"]){
        FriendsLeftImageRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsLeftImageRightLabelCell"];
        cell.delegate = self;
        return cell;
    }else if ([model.composing isEqualToString:@"5"]){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentLeft];
        return cell;
    }else if ([model.composing isEqualToString:@"6"]){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        return cell;
    }else if ([model.composing isEqualToString:@"7"]){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentRight];
        return cell;
    }else if ([model.composing isEqualToString:@"8"]){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentLeft];
        cell.delegate = self;
        return cell;
    }else if ([model.composing isEqualToString:@"9"]){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        return cell;
    }else if ([model.composing isEqualToString:@"10"]){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentRight];
        cell.delegate = self;
        return cell;
    }else{
        FriendsTalentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsTalentTableViewCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    FriendsModel *model = _dataArr[indexPath.row];
//    if ([model.composing isEqualToString:@"10"]) {
        FriendsTalentDetailVC *vc = [[FriendsTalentDetailVC alloc]init];
        [self pushNoTabBarViewController:vc animated:YES];
//    }else{
//
//    }
}

//MARK:--横排文字改变排版--
- (UITextView *)changeTextViewLineSpace:(UITextView *)textView string:(NSString *)text alignment:(NSTextAlignment)alignment{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = alignment;
    NSDictionary *attributes = @{NSFontAttributeName:FZFont(12),NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    return textView;
}
//MARK:--竖排文字改变排版--
//MARK:--FriendsOnlyHaveImageCellDelegate,FriendsTopImageButtomLabelCellDelegate,FriendsButtomImageTopLabelCellDelegate,FriendsLeftImageRightLabelCellDelegate,FriendsOnlyHaveLabelCellDelegate--
- (void)headerPushInfo:(NSInteger)index{
    NSLog(@"点击头像%ld",(long)index);
}
- (void)deleteCell:(NSInteger)index{
    NSLog(@"点击删除%ld",(long)index);
}
- (void)lookAllCellImage:(NSInteger)index{
    FriendsDetailVC *vc = [[FriendsDetailVC alloc]init];
    vc.type = 1;
    [self pushNoTabBarViewController:vc animated:YES];
}
- (void)playCellVideo:(NSInteger)index{
    FriendsDetailVC *vc = [[FriendsDetailVC alloc]init];
    vc.type = 0;
    [self pushNoTabBarViewController:vc animated:YES];
}
- (void)zansCell:(NSInteger)index{
    FriendsModel *model = _dataArr[index];
    [KGRequestNetWorking postWothUrl:firendlikeCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":model.ID} succ:^(id result) {
        
    } fail:^(NSString *error) {
        
    }];
}
- (void)commentCell:(NSInteger)index{
    FriendsModel *model = _dataArr[index];
    [KGRequestNetWorking postWothUrl:friendComment parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":model.ID,@"content":@"大SB，小SB，中SB，SB群体"} succ:^(id result) {
        
    } fail:^(NSString *error) {
        
    }];
    
//    FriendsDetailVC *vc = [[FriendsDetailVC alloc]init];
//    vc.type = 2;
//    [self pushNoTabBarViewController:vc animated:YES];
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
