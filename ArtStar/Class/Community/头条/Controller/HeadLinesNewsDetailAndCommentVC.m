//
//  HeadLinesNewsDetailAndCommentVC.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "HeadLinesNewsDetailAndCommentVC.h"
#import "HeadLineNotTitleNewsTableViewCell.h"
#import "HeadLineImageNewsTableViewCell.h"
#import "HeadLinesDetaialCommentCell.h"

@interface HeadLinesNewsDetailAndCommentVC ()<UITableViewDelegate,UITableViewDataSource,ReportViewDelegate,HeadLinesDetaialCommentCellDelegate>

/**
 筛选框
 */
@property (nonatomic,strong) CommunitySmartView *smartView;
/**
 新闻详情列表
 */
@property (nonatomic,strong) UITableView *listView;
/**
 新闻列表分区头
 */
@property (nonatomic,strong) UIView *headerView;
/**
 详情数据
 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/**
 评论数据
 */
@property (nonatomic,strong) NSMutableArray *commentArr;
/**
 详情
 */
@property (nonatomic,strong) NSDictionary *model;
/**
 举报页面
 */
@property (nonatomic,strong) ReportView *reportView;

@end

@implementation HeadLinesNewsDetailAndCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
    [self createCommentArrData];
    [self setTableView];
    [self setLowView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.smartView.hidden = YES;
}
// MARK: --评论列表--
- (void)createCommentArrData{
    _commentArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:commentNews parameters:@{@"nid":_ID,@"uid":[KGUserInfo shareInterace].userID,@"query":@{@"page":@"0",@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                [mySelf.commentArr addObject:dic];
                [mySelf.listView reloadSection:1 withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --拉数据--
- (void)createData{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在加载详情..."];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:selectNewsByUid parameters:@{@"nid":_ID,@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            mySelf.model = [result[@"data"] firstObject];
            mySelf.dataArr = [NSMutableArray arrayWithArray:mySelf.model[@"contentImg"]];
            mySelf.listView.tableHeaderView = [mySelf tableViewHeader];
            [mySelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:mySelf.view animated:YES];
    }];
}
//MARK:--导航栏右侧按钮点击事件--
- (void)rightNavBtuAction:(UIButton *)sender{
    if (self.smartView.hidden == NO) {
        self.smartView.hidden = YES;
    }else{
        self.smartView.hidden = NO;
    }
}
//MARK:--右侧筛选按钮--
- (CommunitySmartView *)smartView{
    if (!_smartView) {
        _smartView = [[CommunitySmartView alloc]initWithFrame:CGRectMake(ViewWidth(self.view) - 100, NavTopHeight - 5, 100, 135) titleArr:@[@"消息",@"收藏",@"举报"] iconArr:@[@"more popup message",@"more popup collection",@"more popup report"]];
        // !!!: --右侧按钮点击事件--
        __weak typeof(self) weakSelf = self;
        _smartView.action = ^(NSString *title) {
            if ([title isEqualToString:@"消息"]) {
                
            }else if ([title isEqualToString:@"收藏"]){
                
            }else if ([title isEqualToString:@"举报"]){
                weakSelf.reportView.hidden = NO;
            }
        };
        _smartView.hidden = YES;
        [self.navigationController.view addSubview:_smartView];
    }
    return _smartView;
}
//MARK:--新闻详情页--
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
    _listView.showsVerticalScrollIndicator = NO;
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.bounces = NO;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerClass:[HeadLineNotTitleNewsTableViewCell class] forCellReuseIdentifier:@"HeadLineNotTitleNewsTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HeadLineImageNewsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLineImageNewsTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesDetaialCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesDetaialCommentCell"];
}
// !!!: --这里放两个分区，第一个分区显示新闻详情，第二个分区显示评论列表--
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
// !!!: --根据不同分区加载不同数据量--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArr.count;
    }else{
        return _commentArr.count;
    }
}
// !!!: --根据分区加载分区头--
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    if (section == 1) {
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 45);
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15,20, kScreenWidth - 30, 13)];
        titleLab.text = @"评论列表";
        titleLab.font = SYFont(13);
        titleLab.textColor = Color_333333;
        [headerView addSubview:titleLab];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 43, 55, 2)];
        line.backgroundColor = Color_333333;
        [headerView addSubview:line];
    }else{
        headerView.frame = CGRectMake(0, 0, 0, 0);
    }
    return headerView;
}
// !!!: --根据分去确定分区头高度--
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 45;
    }
}
// !!!: --根据不同分区设置不同高度cell--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        if ([dic[@"img"] isKindOfClass:[NSNull class]]) {
            HeadLineNotTitleNewsTableViewCell *cell = [HeadLineNotTitleNewsTableViewCell new];
            return [cell tableViewCellRowHeight:dic[@"content"]];
        }else{
            if ([dic[@"content"] isKindOfClass:[NSNull class]]) {
                return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:dic[@"img"]] layoutWidth:kScreenWidth - 30 estimateHeight:300];
            }else{
                return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:dic[@"img"]] layoutWidth:kScreenWidth - 30 estimateHeight:300] + 15;
            }
        }
    }else{
        return 145;
    }
}
// !!!: --根据分区加载详情和评论--
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//:--详情--
        NSDictionary *dic = _dataArr[indexPath.row];
        if ([dic[@"img"] isKindOfClass:[NSNull class]]) {
            HeadLineNotTitleNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineNotTitleNewsTableViewCell"];
            cell.detailStr = dic[@"content"];
            return cell;
        }else{
            HeadLineImageNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineImageNewsTableViewCell"];
            [cell.topImage sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    if (result) {
                        [tableView xh_reloadDataForURL:imageURL];
                    }
                }];
            }];
            if ([dic[@"content"] isKindOfClass:[NSNull class]]) {
                cell.labHeight.constant = 0;
            }else{
                cell.labHeight.constant = 15;
                cell.titleLab.text = dic[@"content"];
            }
            return cell;
        }
    }else{//:--评论--
        HeadLinesDetaialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesDetaialCommentCell"];
        NSDictionary *dic = _commentArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikName.text = dic[@"username"];
        cell.timeLab.text = dic[@"pltime"];
        cell.commentLab.text = dic[@"pinglun"];
        cell.delegate = self;
        cell.cellID = [dic[@"id"] integerValue];
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%@",dic[@"zansum"]] forState:UIControlStateNormal];
        return cell;
    }
}
// MARK: --HeadLinesDetaialCommentCellDelegate--
- (void)zansCommentWithID:(NSInteger)ID withStyle:(NSString *)style{
    [KGRequestNetWorking postWothUrl:dianComment parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"cid":[NSString stringWithFormat:@"%li",ID],@"zantype":style} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            [self createCommentArrData];
        }
    } fail:^(NSError *error) {
        
    }];
}
//:--新闻详情头--
- (UIView *)tableViewHeader{
    CGFloat labHeight = 15;
    CGFloat labwidth = kScreenWidth - 60;
    //:--先给头视图一个默认大小，加载完内容后动态计算--
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, kScreenWidth - 60, 15)];
    for (int i = 0 ; i < 5; i++) {
        if ([self attributedStringWithString:self.model[@"title"]].size.width - labwidth > kScreenWidth - 60) {
            labHeight = labHeight + 25;
        }else{
            break;
        }
    }
    //:--标题--
    titleLab.size = CGSizeMake(kScreenWidth - 60, labHeight);
    titleLab.attributedText = [self attributedStringWithString:self.model[@"title"]];
    titleLab.textColor = Color_333333;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:titleLab];
    //:--副标题--
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(0, labHeight + 50, kScreenWidth, 13)];
    detailLab.textColor = Color_999999;
    detailLab.font = SYFont(13);
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.text = self.model[@"sitename"];
    [_headerView addSubview:detailLab];
    //:--时间--
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, labHeight + 73, kScreenWidth, 11)];
    timeLab.textColor = Color_999999;
    timeLab.font = SYFont(11);
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.text = self.model[@"newstime"];
    [_headerView addSubview:timeLab];
    //:--动态计算头视图大小--
    _headerView.size = CGSizeMake(kScreenWidth,labHeight + 134);
    
    return _headerView;
}
// !!!: --加载富文本内容详情--
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string{
    NSMutableParagraphStyle *pargraph = [[NSMutableParagraphStyle alloc]init];
    pargraph.lineSpacing = 10;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (attributedStr.size.width > kScreenWidth - 60) {
        [attributedStr addAttributes:@{NSFontAttributeName:SYBFont(15),NSParagraphStyleAttributeName:pargraph} range:NSMakeRange(0, [string length])];
    }else{
        [attributedStr addAttributes:@{NSFontAttributeName:SYBFont(15)} range:NSMakeRange(0, [string length])];
    }
    return attributedStr;
}
// MARK: --底部评论框--
- (void)setLowView{
    KGLowCommentView *commnetView = [[KGLowCommentView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    commnetView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) mySelf = self;
    // !!!: --评论框中按钮的点击事件--
    commnetView.actionWithTitle = ^(NSString *title, NSString *text) {
        if ([title isEqualToString:@"评论"]) {
            [mySelf addComment:text];
        }
    };
    [self.view addSubview:commnetView];
}
// MARK: --添加新闻评论--
- (void)addComment:(NSString *)comment{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:commentNewsByUid parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"nid":_ID,@"pinglun":comment} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            [mySelf createCommentArrData];
        }
    } fail:^(NSError *error) {
        
    }];
}
// MARK: --举报页面--
- (ReportView *)reportView{
    if (!_reportView) {
        _reportView = [[ReportView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _reportView.delegate = self;
        [self.navigationController.view addSubview:_reportView];
    }
    return _reportView;
}
// MARK: --ReportViewDelegate--
- (void)sendReportResonToServer:(NSString *)reson{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在提交..."];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:addBackPinglun parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"nid":_ID,@"jbname":reson} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"举报成功！" toView:weakSelf.view hideAfter:1];
        }else{
            [MBProgressHUD bwm_showTitle:@"举报失败！" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"网络出错！" toView:weakSelf.view hideAfter:1];
    }];
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
