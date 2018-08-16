//
//  MusicThemeView.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicThemeView.h"
#import "MusicThemeMyThemeCell.h"

@interface MusicThemeView ()<UITableViewDelegate,UITableViewDataSource,FriendsThemeTopImageCellDelegate,FriendsThemeLeftImageCellDelegate,FriendsThemeCirulerImageCellDelegate,FriendsOnlyHaveImageCellDelegate,FriendsOnlyHaveLabelCellDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic,strong) HeaderScrollAndPageView *pageView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *topArr;

@end

@implementation MusicThemeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _dataArr = [NSMutableArray array];
        _topArr = [NSMutableArray array];
        [self topCellData];
        [self setView];
    }
    return self;
}

- (void)setView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicThemeMyThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicThemeMyThemeCell"];
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
//MARK:---------------------------------------创建头视图------------------------------------------
- (UIView *)tableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self),ViewWidth(self)/750*500 + 50)];
    _headerView.backgroundColor = Color_fafafa;
    
    _pageView = [[HeaderScrollAndPageView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_headerView), ViewHeight(_headerView) - 10) style:HeaderStyleHeadLines];
//    _pageView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
    [_headerView addSubview:_pageView];
    
    return _headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_topArr.count > 0) {
        return _dataArr.count + 1;
    }else{
        return _dataArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 140;
    }else{
        NSDictionary *dic = _dataArr[indexPath.row];
        if ([dic[@"makeup"] integerValue] == 0) {
            return OnlyHaveTitleHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 1){
            return OnlyHaveImageHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 2){
            return curileImageHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 3){
            return LeftAndRightHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 4){
            return LeftAndRightHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 5){
            return TopAndBottomHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 6){
            return TopAndBottomHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 7){
            return TopAndBottomHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 8){
            return TopAndBottomHeight + 40;
        }else if ([dic[@"makeup"] integerValue] == 9){
            return TopAndBottomHeight + 40;
        }else{
            return TopAndBottomHeight + 40;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MusicThemeMyThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicThemeMyThemeCell"];
        cell.themeArr = _topArr.copy;
        return cell;
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    NSMutableDictionary *keyDic = [NSMutableDictionary dictionary];
    [keyDic setValuesForKeysWithDictionary:dic];
    NSString *value = [NSString stringWithFormat:@"%@",keyDic[@"makeup"]];
    if (![keyDic[@"imgList"] isKindOfClass:NSClassFromString(@"__NSSingleObjectArrayI")]) {
        NSArray<NSDictionary *> *tmp = keyDic[@"imgList"];
        [keyDic removeObjectForKey:@"imgList"];
        [keyDic setObject:tmp forKey:@"images"];
    }
    [keyDic removeObjectForKey:@"makeup"];
    [keyDic setObject:value forKey:@"composing"];
    
    if ([dic[@"makeup"] integerValue] == 0) {
        FriendsOnlyHaveLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveLabelCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 1){
        FriendsOnlyHaveImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsOnlyHaveImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 2){
        FriendsThemeCirulerImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeCirulerImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 9){
        FriendsThemeLeftImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeLeftImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 10){
        FriendsThemeLeftImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeLeftImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 3){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 4){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 5){
        FriendsThemeButtomImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeButtomImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 6){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else if ([dic[@"makeup"] integerValue] == 7){
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }else{
        FriendsThemeTopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsThemeTopImageCell"];
        cell.delegate = self;
        [cell fillCellWithModel:keyDic];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.pushViewController) {
            self.pushViewController();
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
- (void)setTitleName:(NSString *)titleName{
    _titleName = titleName;
    [self createHeadLineData:titleName];
}
// MARK: --拉去数据--
- (void)createHeadLineData:(NSString *)name{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequestNetWorking postWothUrl:ntvByTopic parameters:@{@"typename":name,@"uid":[KGUserInfo shareInterace].userID,@"query":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                if (weakSelf.dataArr.count > 0) {
                    [weakSelf.dataArr addObjectsFromArray:tmp];
                }else{
                    weakSelf.dataArr = [NSMutableArray arrayWithArray:tmp];
                }
            }
        }
        [weakSelf.listView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        [weakSelf.listView reloadData];
    }];
}
- (void)topCellData{
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:utBytopic parameters:@{@"query":@{@"page":@"1",@"rows":@"15"},@"uid":[KGUserInfo shareInterace].userID,@"utnexus":@"1"} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                weakSelf.topArr = [NSMutableArray arrayWithArray:tmp];
            }
        }
    } fail:^(NSError *error) {
        
    }];
}
- (void)headerPushInfo:(NSInteger)index{
    
}
- (void)deleteCell:(NSInteger)index{
    
}
- (void)zansCell:(NSInteger)index{
    __weak typeof(self) mySelf = self;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequestNetWorking postWothUrl:firendlikeCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":@(index)} succ:^(id result) {
        [MBProgressHUD hideHUDForView:mySelf animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf animated:YES];
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
//    FriendsMessageVC *vc = [[FriendsMessageVC alloc]init];
//    [self pushNoTabBarViewController:vc animated:YES];
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
