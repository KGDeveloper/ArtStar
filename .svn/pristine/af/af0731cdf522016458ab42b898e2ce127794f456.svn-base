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
@property (nonatomic,strong) NSMutableArray *zansArr;

@end

@implementation FriendsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.zansArr = [NSMutableArray array];
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight - 44 + 20, kScreenWidth, kScreenHeight - NavTopHeight + 44 - 20 - NavButtomHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    _listView.tableHeaderView = [self setTableViewHeader];
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _listView.separatorStyle = UITableViewCellSelectionStyleNone;
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    self.messageView.messStr = @"20条新消息";
    
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
    if (indexPath.row == 0) {
        return 58 + 55 + photoViewHeight + 10;
    }else if (indexPath.row == 1){
        return 58 + 55 + photoViewHeight + 115 + 10 + 20;
    }else if (indexPath.row == 2){
        return 58 + 55 + photoViewHeight + 115 + 10 + 20;
    }else if (indexPath.row == 3){
        return 58 + 55 + 115 + 10;
    }else if (indexPath.row == 4){
        return 58 + 55 + (kScreenWidth - 115 - 30)/450*690 + 10;
    }else if (indexPath.row == 5){
        return 58 + 55 + photoViewHeight + 115 + 10 + 20;
    }else if (indexPath.row == 6){
        return 58 + 95 + photoViewHeight + 115 + 20;
    }else if (indexPath.row == 7){
        return 58 + 95 + photoViewHeight + 115 + 20;
    }else if (indexPath.row == 8){
        return 58 + 95 + photoViewHeight + 115 + 20;
    }else{
        return 58 + 95 + photoViewHeight + 115 + 20;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FriendsOnlyHaveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveImageCell"];
        cell.delegate = self;
        [cell showGraphic];
        return cell;
    }else if (indexPath.row == 1){
        FriendsTopImageButtomLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsTopImageButtomLabelCell"];
        cell.delegate = self;
        [cell showVideo];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        return cell;
    }else if (indexPath.row == 2){
        FriendsButtomImageTopLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsButtomImageTopLabelCell"];
        cell.delegate = self;
        [cell showGraphic];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        return cell;
    }else if (indexPath.row == 3){
        FriendsOnlyHaveLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveLabelCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 4){
        FriendsLeftImageRightLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsLeftImageRightLabelCell"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 5){
        FriendsCurilerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCurilerImageCell"];
        [ChangeTextViewTextStyle changeTextView:cell.textView text:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 6){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 7){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        return cell;
    }else if(indexPath.row == 8){
        FriendsThemeLeftImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeLeftImageCell"];
        cell.delegate = self;
        return cell;
    }else{
        FriendsThemeCirulerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeCirulerImageCell"];
        [self changeTextViewLineSpace:cell.textView string:@"君不见，黄河之水天上来，奔流到海不复回\n君不见，高堂明镜悲白发，朝成青丝暮成雪\n人生得意须尽欢，莫使金樽空对月\n天生我材必有用，千金散尽还复来\n烹羊宰牛且为乐，会须一饮三百杯" alignment:NSTextAlignmentCenter];
        cell.delegate = self;
        return cell;
    }
}
- (BOOL)findIndexIsThereAreArr:(NSInteger)index{
    BOOL isShure = NO;
    for (NSString * obj in self.zansArr) {
        if ([obj integerValue] == index) {
            isShure = YES;
            break;
        }else{
            isShure = NO;
        }
    }
    return isShure;
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
    if ([self findIndexIsThereAreArr:index] == NO) {
        [self.zansArr addObject:[NSString stringWithFormat:@"%ld",(long)index]];
    }
}
- (void)commentCell:(NSInteger)index{
    FriendsDetailVC *vc = [[FriendsDetailVC alloc]init];
    vc.type = 2;
    [self pushNoTabBarViewController:vc animated:YES];
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
