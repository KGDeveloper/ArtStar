//
//  MovieNewsDetaialVC.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MovieNewsDetaialVC.h"
#import "HeadLineNotTitleNewsTableViewCell.h"
#import "HeadLineImageNewsTableViewCell.h"
#import "HeadLinesDetaialCommentCell.h"
#import "CommenityDetailCommentModel.h"

@interface MovieNewsDetaialVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) CommunitySmartView *smartView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) NSMutableArray *commentArr;
@property (nonatomic,strong) CommenityNewsDetailModel *model;

@end

@implementation MovieNewsDetaialVC

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
- (void)createCommentArrData{
    _commentArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:commentNews parameters:@{@"nid":_ID,@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                CommenityDetailCommentModel *model = [CommenityDetailCommentModel mj_objectWithKeyValues:dic];
                [mySelf.commentArr addObject:model];
                [mySelf.listView reloadData];
            }
        }
    } fail:^(NSString *error) {
        
    }];
}
- (void)createData{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:selectNewsByUid parameters:@{@"nid":_ID} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = arr[0];
            mySelf.model = [CommenityNewsDetailModel mj_objectWithKeyValues:dic];
            NSData *data = [mySelf.model.content dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            mySelf.dataArr = [NSMutableArray arrayWithArray:array];
            mySelf.listView.tableHeaderView = [mySelf tableViewHeader];
            [mySelf.listView reloadData];
        }
    } fail:^(NSString *error) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.smartView.hidden = YES;
}
//MARK:----------------------------------------导航栏右侧按钮点击事件------------------------------------------------
- (void)rightNavBtuAction:(UIButton *)sender{
    if (self.smartView.hidden == NO) {
        self.smartView.hidden = YES;
    }else{
        self.smartView.hidden = NO;
    }
}
//MARK:--------------------------------------右侧筛选按钮--------------------------------------------------
- (CommunitySmartView *)smartView{
    if (!_smartView) {
        _smartView = [[CommunitySmartView alloc]initWithFrame:CGRectMake(ViewWidth(self.view) - 100, NavTopHeight - 5, 100, 135) titleArr:@[@"消息",@"收藏",@"举报"] iconArr:@[@"more popup message",@"more popup collection",@"more popup report"]];
        _smartView.hidden = YES;
        [self.navigationController.view addSubview:_smartView];
    }
    return _smartView;
}
//MARK:-----------------------------------------新闻详情页-----------------------------------------------
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArr.count;
    }else{
        return _commentArr.count;
    }
}
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        NSArray *arr = dic.allKeys;
        if ([arr[0] isEqualToString:@"img"]) {
            return [XHWebImageAutoSize imageHeightForURL:[NSURL URLWithString:dic[@"img"]] layoutWidth:kScreenWidth - 30 estimateHeight:300];
        }else{
            HeadLineNotTitleNewsTableViewCell *cell = [HeadLineNotTitleNewsTableViewCell new];
            return [cell tableViewCellRowHeight:dic[@"content"]];
        }
    }else{
        return 145;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        NSArray *arr = dic.allKeys;
        if ([arr[0] isEqualToString:@"img"]) {
            HeadLineImageNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineImageNewsTableViewCell"];
            [cell.topImage sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
                    if (result) {
                        [tableView xh_reloadDataForURL:imageURL];
                    }
                }];
            }];
            return cell;
        }else{
            HeadLineNotTitleNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLineNotTitleNewsTableViewCell"];
            cell.detailStr = dic[@"content"];
            return cell;
        }
    }else{
        HeadLinesDetaialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesDetaialCommentCell"];
        CommenityDetailCommentModel *model = _commentArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.portraitUri]];
        cell.nikName.text = model.username;
        cell.timeLab.text = model.pltime;
        cell.commentLab.text = model.pinglun;
        [cell.zansBtu setTitle:[NSString stringWithFormat:@"%@",model.zansum] forState:UIControlStateNormal];
        return cell;
    }
}

- (UIView *)tableViewHeader{
    CGFloat labHeight = 15;
    CGFloat labwidth = kScreenWidth - 60;
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, kScreenWidth - 60, 15)];
    for (int i = 0 ; i < 5; i++) {
        if ([self attributedStringWithString:_model.title].size.width - labwidth > kScreenWidth - 60) {
            labHeight = labHeight + 25;
        }else{
            break;
        }
    }
    titleLab.size = CGSizeMake(kScreenWidth - 60, labHeight);
    titleLab.attributedText = [self attributedStringWithString:_model.title];
    titleLab.textColor = Color_333333;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:titleLab];
    
    UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(0, labHeight + 50, kScreenWidth, 13)];
    detailLab.textColor = Color_999999;
    detailLab.font = SYFont(13);
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.text = _model.sitename;
    [_headerView addSubview:detailLab];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, labHeight + 73, kScreenWidth, 11)];
    timeLab.textColor = Color_999999;
    timeLab.font = SYFont(11);
    timeLab.textAlignment = NSTextAlignmentCenter;
    timeLab.text = _model.newstime;
    [_headerView addSubview:timeLab];
    
    _headerView.size = CGSizeMake(kScreenWidth,labHeight + 134);
    
    return _headerView;
}

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

- (void)setLowView{
    KGLowCommentView *commnetView = [[KGLowCommentView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    commnetView.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) mySelf = self;
    commnetView.actionWithTitle = ^(NSString *title, NSString *text) {
        if ([title isEqualToString:@"评论"]) {
            [mySelf addComment:text];
        }
    };
    [self.view addSubview:commnetView];
}

- (void)addComment:(NSString *)comment{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:commentNewsByUid parameters:@{@"uid":[KGUserInfo shareInterace].userID,@"nid":_ID,@"pinglun":comment} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            [mySelf createCommentArrData];
        }
    } fail:^(NSString *error) {
        
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
