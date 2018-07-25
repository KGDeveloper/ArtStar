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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:friendsunreadMessageCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        NSArray *tmpArr = result[@"data"];
        NSDictionary *dic = [tmpArr firstObject];
        if ([dic[@"count"] integerValue] == 0) {
            mySelf.headerView.size = CGSizeMake(kScreenWidth, (kScreenWidth - 40)/670*450);
        }else{
            mySelf.headerView.size = CGSizeMake(kScreenWidth, (kScreenWidth - 40)/670*450 + 60);
            mySelf.messageView.messStr = [NSString stringWithFormat:@"%@条新消息",mySelf.msgCount];
        }
        [mySelf.listView reloadData];
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}

- (void)createData{
    
    _dataArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:searchfriendMessages parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfquery":@{@"page":@"1",@"rows":@"15"},@"brushPerss":@"1"} succ:^(id result) {
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
    } fail:^(NSError *error) {

    }];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - NavButtomHeight - 49 - 20)];
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
    if ([model.composing integerValue] == 0) {
        return OnlyHaveTitleHeight;
    }else if ([model.composing integerValue] == 1){
        return OnlyHaveImageHeight;
    }else if ([model.composing integerValue] == 2){
        return curileImageHeight;
    }else if ([model.composing integerValue] == 3){
        return LeftAndRightHeight;
    }else if ([model.composing integerValue] == 4){
        return LeftAndRightHeight;
    }else if ([model.composing integerValue] == 5){
        return TopAndBottomHeight;
    }else if ([model.composing integerValue] == 6){
        return TopAndBottomHeight;
    }else if ([model.composing integerValue] == 7){
        return TopAndBottomHeight;
    }else if ([model.composing integerValue] == 8){
        return TopAndBottomHeight + 20;
    }else if ([model.composing integerValue] == 9){
        return TopAndBottomHeight + 20;
    }else if ([model.composing integerValue] == 10){
        return TopAndBottomHeight + 20;
    }else{
        return talentHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsModel *model = _dataArr[indexPath.row];
    //MARK:----------------------------------------只有文字------------------------------------------------
    if ([model.composing integerValue] == 0) {
        FriendsOnlyHaveLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveLabelCell"];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        cell.timeLab.text = model.createTimeStr;
        cell.locationLab.text = model.location;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        cell.cellIndex = indexPath.row;
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikeNameLab.text = dic[@"username"];
        cell.tileWidth.constant = [TransformChineseToPinying stringWidthFromString:model.createTimeStr font:SYFont(12) width:kScreenWidth];
        return cell;
        //MARK:----------------------------------------只有图片------------------------------------------------
    }else if ([model.composing integerValue] == 1){
        FriendsOnlyHaveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveImageCell"];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        if (model.images.count > 0) {
            [cell showGraphic];
        }
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.timeLab.text = model.createTimeStr;
        cell.locationLab.text = model.location;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:-----------------------------------------圆形图片-----------------------------------------------
    }else if ([model.composing integerValue] == 2){
        FriendsCurilerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCurilerImageCell"];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [ChangeTextViewTextStyle changeTextView:cell.textView text:str alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerIamge sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        return cell;
        //MARK:----------------------------------------文字居右居上------------------------------------------------
    }else if ([model.composing integerValue] == 3){
        FriendsLeftImageRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsLeftImageRightLabelCell"];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        cell.textAlignment = YYTextVerticalAlignmentTop;
        cell.contentStr = model.content;
        NSDictionary *imageDic = [model.images firstObject];
        cell.topImageUrl = imageDic[@"imageURL"];
        cell.countLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)model.images.count];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:------------------------------------------文字居右居中----------------------------------------------
    }else if ([model.composing integerValue] == 4){
        FriendsLeftImageRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsLeftImageRightLabelCell"];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        cell.textAlignment = YYTextVerticalAlignmentCenter;
        cell.contentStr = model.content;
        NSDictionary *imageDic = [model.images firstObject];
        cell.topImageUrl = imageDic[@"imageURL"];
        cell.countLab.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)model.images.count];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:-------------------------------------------文字居上局座---------------------------------------------
    }else if ([model.composing integerValue] == 5){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 1; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentLeft];
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikName.text = dic[@"username"];
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:------------------------------------------文字居上居中----------------------------------------------
    }else if ([model.composing integerValue] == 6){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 0; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentCenter];
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikName.text = dic[@"username"];
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:-----------------------------------------文字居上居右-----------------------------------------------
    }else if ([model.composing integerValue] == 7){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 0; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentRight];
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikName.text = dic[@"username"];
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:---------------------------------------------文字局下局座-------------------------------------------
    }else if ([model.composing integerValue] == 8){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 0; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentLeft];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerIamge sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:---------------------------------------------文字局下居中-------------------------------------------
    }else if ([model.composing integerValue] == 9){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 0; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerIamge sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
        return cell;
        //MARK:----------------------------------------------文字局下居右------------------------------------------
    }else if ([model.composing integerValue] == 10){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        NSData *strData = [model.content dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *strArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:nil];
        NSString *str = strArr[0];
        for (int i = 0; i < strArr.count; i++) {
            str = [NSString stringWithFormat:@"%@\n%@",str,strArr[i]];
        }
        [self changeTextViewLineSpace:cell.textView string:str alignment:NSTextAlignmentRight];
        cell.delegate = self;
        NSDictionary *dic = model.user;
        [cell.headerIamge sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikNameLab.text = dic[@"username"];
        NSDictionary *imageDic = [model.images firstObject];
        [cell.topImage sd_setImageWithURL:[NSURL URLWithString:imageDic[@"imageURL"]]];
        cell.locationLab.text = model.location;
        cell.timeLab.text = model.createTimeStr;
        [cell.commentBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.rccommentNum.integerValue] forState:UIControlStateNormal];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%ld",(long)model.likeCount.integerValue] forState:UIControlStateNormal];
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
            vc.type = 1;
            [self pushNoTabBarViewController:vc animated:YES];
        }
    }
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
- (void)zansCell:(NSInteger)index{
    FriendsModel *model = _dataArr[index];
    [KGRequestNetWorking postWothUrl:firendlikeCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":model.ID} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
}
- (void)commentCell:(NSInteger)index{
    FriendsModel *model = _dataArr[index];
    [KGRequestNetWorking postWothUrl:friendComment parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":model.ID,@"content":@"大SB，小SB，中SB，SB群体"} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
    }];
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
