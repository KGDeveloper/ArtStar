//
//  FriendsTalentDetailVC.m
//  ArtStar
//
//  Created by abc on 2018/7/3.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "FriendsTalentDetailVC.h"
#import "FriendsTalentDetailHeaderView.h"
#import "HeadLinesDetaialCommentCell.h"
#import "FriendsTalentModel.h"
#import "HeadLinesNormalCell.h"
#import "KGLowCommentView.h"
#import "FriendsTalentsCommentModel.h"

@interface FriendsTalentDetailVC ()<UITableViewDelegate,UITableViewDataSource,FriendsCommentViewDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) FriendsTalentModel *model;
@property (nonatomic,strong) FriendsTalentDetailHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation FriendsTalentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30) title:@"798:那些不被人发现的好地方" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [NSMutableArray array];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self createData];
    [self setTableView];
    [self createLowCommentView];
}

- (void)createLowCommentView{
    KGLowCommentView *commentView = [[KGLowCommentView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    __weak typeof(self) mySelf = self;
    commentView.actionWithTitle = ^(NSString *title, NSString *text) {
        if ([title isEqualToString:@"评论"]) {
            [mySelf requestComment:text];
        }else if ([title isEqualToString:@"点赞"]){
            [mySelf zansNews];
        }
    };
    [self.view insertSubview:commentView atIndex:99];
}

- (void)zansNews{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:firendlikeCount parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":_msgID} succ:^(id result) {
        [[MBProgressHUD bwm_showHUDAddedTo:mySelf.view title:result[@"message"]] hide:YES afterDelay:1];
    } fail:^(NSError *error) {
        
    }];
}

- (void)requestComment:(NSString *)commentStr{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:commentOrReply parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":_msgID,@"content":commentStr} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = [arr firstObject];
            FriendsModel *model = [FriendsModel mj_objectWithKeyValues:dic];
            NSArray *commentArr = model.rccomment;
            mySelf.dataArr = [FriendsTalentsCommentModel mj_objectArrayWithKeyValuesArray:commentArr];
            [mySelf.listView reloadData];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}

- (void)createData{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:friendViews parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"rfmid":_msgID,@"issId":@([_ID integerValue])} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = [arr firstObject];
            mySelf.model = [FriendsTalentModel mj_objectWithKeyValues:dic];
            mySelf.headerView.size = CGSizeMake(kScreenWidth, [mySelf.headerView calculateHeaderViewHeightWithModel:mySelf.model]);
            NSArray *countArr = mySelf.model.allTreeByLoop;
            mySelf.dataArr = [FriendsTalentsCommentModel mj_objectArrayWithKeyValuesArray:countArr];
            [mySelf setLeftBtuWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30) title:mySelf.model.headline image:Image(@"back")];
            [mySelf.listView reloadData];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        
    }];
}

- (void)setTableView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 145;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesDetaialCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesDetaialCommentCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesNormalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesNormalCell"];
    
}

- (UIView *)setTableViewHeaderView{
    _headerView = [FriendsTalentDetailHeaderView initWithView];
    _headerView.frame = CGRectMake(0, 0, kScreenWidth, 0);
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArr.count > 0) {
        return _dataArr.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArr.count > 0) {
        HeadLinesDetaialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesDetaialCommentCell"];
        FriendsTalentsCommentModel *model = _dataArr[indexPath.row];
        NSDictionary *dic = model.user;
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        cell.nikName.text = dic[@"username"];
        cell.timeLab.text = model.createTimeStr;
        cell.commentLab.text = model.content;
        return cell;
    }else{
        HeadLinesNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesNormalCell"];
        return cell;
    }
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
