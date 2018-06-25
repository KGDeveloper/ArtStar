//
//  MineJoinTalentShowVC.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineJoinTalentShowVC.h"
#import "MineJointalentTopTableViewCell.h"
#import "MineJoinTalentSHowLowTableViewCell.h"
#import "MineTheIdentityAuthenticationVC.h"

@interface MineJoinTalentShowVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineJoinTalentShowVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"我的达人" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    [_listView registerNib:[UINib nibWithNibName:@"MineJointalentTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineJointalentTopTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineJoinTalentSHowLowTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineJoinTalentSHowLowTableViewCell"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }else{
        return 135;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineJointalentTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineJointalentTopTableViewCell"];
        return cell;
    }else{
        MineJoinTalentSHowLowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineJoinTalentSHowLowTableViewCell"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineTheIdentityAuthenticationVC *identity = [[MineTheIdentityAuthenticationVC alloc]init];
        [self pushNoTabBarViewController:identity animated:YES];
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
