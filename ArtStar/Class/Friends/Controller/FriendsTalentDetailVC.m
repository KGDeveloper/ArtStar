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

@interface FriendsTalentDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation FriendsTalentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 30) title:@"798:那些不被人发现的好地方" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
}

- (void)setTableView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 145;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesDetaialCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesDetaialCommentCell"];
    
}

- (UIView *)setTableViewHeaderView{
    FriendsTalentDetailHeaderView *headerView = [FriendsTalentDetailHeaderView initWithView];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 535);
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadLinesDetaialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesDetaialCommentCell"];
    return cell;
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
