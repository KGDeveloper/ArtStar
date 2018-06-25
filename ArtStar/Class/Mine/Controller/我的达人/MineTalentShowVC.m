//
//  MineTalentShowVC.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineTalentShowVC.h"
#import "MineTalentShowTableViewCell.h"
#import "MineJoinTalentShowVC.h"
#import "MineMyselfTalentAuditVC.h"

@interface MineTalentShowVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MineTalentShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"我的达人" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
    [self setTableView];
    
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTbaleViewHeaderView];
    _listView.rowHeight = 50;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineTalentShowTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTalentShowTableViewCell"];
}

- (UIView *)setTbaleViewHeaderView{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTalentShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTalentShowTableViewCell"];
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.iconImage.image = Image(dic[@"icon"]);
    cell.titleLab.text = dic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineJoinTalentShowVC *joinVC = [[MineJoinTalentShowVC alloc]init];
        [self pushNoTabBarViewController:joinVC animated:YES];
    }else{
        MineMyselfTalentAuditVC *talentVC = [[MineMyselfTalentAuditVC alloc]init];
        [self pushNoTabBarViewController:talentVC animated:YES];
    }
}

- (void)createData{
    _dataArr = [NSMutableArray array];
    NSArray *iconArr = @[@"加入星球认证",@"审核(1)"];
    NSArray *titleArr = @[@"加入星球认证",@"审核"];
    for (int i = 0; i < iconArr.count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:iconArr[i] forKey:@"icon"];
        [dic setObject:titleArr[i] forKey:@"title"];
        [_dataArr addObject:dic];
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
