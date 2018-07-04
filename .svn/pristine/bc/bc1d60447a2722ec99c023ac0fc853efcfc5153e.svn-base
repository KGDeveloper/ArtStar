//
//  MineTheIdentityAuthenticationVC.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineTheIdentityAuthenticationVC.h"
#import "MineTheIdentityTableViewCell.h"
#import "MineTheIdentityJoinTableViewCell.h"
#import "MineJoinAddBaseInfoVC.h"

@interface MineTheIdentityAuthenticationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MineTheIdentityAuthenticationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"身份认证" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 70;
    }else{
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        return cell;
    }else{
        MineTheIdentityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityTableViewCell"];
        NSDictionary *dic = _dataArr[indexPath.row];
        cell.iconImage.image = Image(dic[@"icon"]);
        cell.textLab.text = dic[@"title"];
        cell.statusLab.text = dic[@"status"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        MineJoinAddBaseInfoVC *join = [[MineJoinAddBaseInfoVC alloc]init];
        [self pushNoTabBarViewController:join animated:YES];
    }
}
- (void)createData{
    _dataArr = [NSMutableArray array];
    NSArray *iconArr = @[@"绑定手机号",@"粉丝数量",@"关注数量"];
    NSArray *titleArr = @[@"绑定手机号",@"粉丝数量≥50",@"关注数量≥50"];
    for (int i = 0;i < iconArr.count; i ++ ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:iconArr[i] forKey:@"icon"];
        [dic setObject:titleArr[i] forKey:@"title"];
        [dic setObject:@"已满足" forKey:@"status"];
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
