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
        if ([dic[@"status"] integerValue] == 0) {
            cell.statusLab.text = @"未满足";
        }else{
            cell.statusLab.text = @"已满足";
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        __block BOOL isOK = NO;
        [_dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
            if ([dic[@"status"] integerValue] == 0) {
                *stop = YES;
            }
            isOK = YES;
        }];
        if (isOK == YES) {
            MineJoinAddBaseInfoVC *join = [[MineJoinAddBaseInfoVC alloc]init];
            [self pushNoTabBarViewController:join animated:YES];
        }else{
            [[MBProgressHUD bwm_showHUDAddedTo:self.view title:@"您还不满足条件，请努力"] hide:YES afterDelay:1];
        }
    }
}
- (void)createData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:celestialBodyAttestation parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"uid":[KGUserInfo shareInterace].userID} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSDictionary *tmpDic = [result[@"data"] firstObject];
            [weakSelf createUIDataWithDic:tmpDic];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}

- (void)createUIDataWithDic:(NSDictionary *)tmpDic{
    _dataArr = [NSMutableArray array];
    NSArray *iconArr = @[@"绑定手机号",@"粉丝数量",@"关注数量"];
    NSArray *titleArr = @[@"绑定手机号",@"粉丝数量≥50",@"关注数量≥50"];
    for (int i = 0;i < iconArr.count; i ++ ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:iconArr[i] forKey:@"icon"];
        [dic setObject:titleArr[i] forKey:@"title"];
        if (i == 0) {
            [dic setObject:tmpDic[@"手机号"] forKey:@"status"];
        }else if (i == 1){
            [dic setObject:tmpDic[@"关注"] forKey:@"status"];
        }else{
            [dic setObject:tmpDic[@"粉丝"] forKey:@"status"];
        }
        [_dataArr addObject:dic];
    }
    [_listView reloadData];
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
