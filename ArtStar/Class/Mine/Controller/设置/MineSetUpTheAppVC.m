//
//  MineSetUpTheAppVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineSetUpTheAppVC.h"
#import "MineSetUpTopTableViewCell.h"
#import "MineSetUpPushTableViewCell.h"
#import "MineSetUpChangePhoneTableViewCell.h"
#import "MineChangePhoneWithPassWordVC.h"
#import "MineChangePhoneWithOldPhoneVC.h"
#import "MineChangePassWordVC.h"
#import "MineFeedBackVC.h"

@interface MineSetUpTheAppVC ()<UITableViewDelegate,UITableViewDataSource,MineSetUpChangePhoneTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) BOOL status;

@end

@implementation MineSetUpTheAppVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"设置" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
    [self setTableView];
    
}

- (void)createData{
    _dataArr = [NSMutableArray array];
    NSArray *topArr = @[@"消息提醒",@"流量播放提醒",@"wifi下自动播放"];
    NSArray *centerArr = @[@"修改绑定手机号",@"修改密码"];
    NSArray *lowArr = @[@"意见反馈",@"版本v1.00"];
    [_dataArr addObject:topArr];
    [_dataArr addObject:centerArr];
    [_dataArr addObject:lowArr];
    [_dataArr addObject:@[@"退出当前账号"]];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.rowHeight = 50;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineSetUpTopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineSetUpTopTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineSetUpPushTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineSetUpPushTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineSetUpChangePhoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineSetUpChangePhoneTableViewCell"];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = Color_fafafa;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 3){
        return 1;
    }else{
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (_status == YES) {
                return 153;
            }else{
                return 50;
            }
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineSetUpTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetUpTopTableViewCell"];
        cell.textLab.text = _dataArr[indexPath.section][indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            if (_status == YES) {
                MineSetUpChangePhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetUpChangePhoneTableViewCell"];
                cell.delegate = self;
                return cell;
            }else{
                MineSetUpPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetUpPushTableViewCell"];
                cell.textLab.text = _dataArr[indexPath.section][indexPath.row];
                return cell;
            }
        }else{
            MineSetUpPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetUpPushTableViewCell"];
            cell.textLab.text = _dataArr[indexPath.section][indexPath.row];
            return cell;
        }
    }else if (indexPath.section == 2){
        MineSetUpPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetUpPushTableViewCell"];
        cell.textLab.text = _dataArr[indexPath.section][indexPath.row];
        if (indexPath.row == 1) {
            cell.rightIamge.hidden = YES;
        }
        return cell;
    }else{
        MineSetUpPushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineSetUpPushTableViewCell"];
        cell.textLab.text = _dataArr[indexPath.section][indexPath.row];
        cell.rightIamge.hidden = YES;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (_status == YES) {
                _status = NO;
            }else{
                _status = YES;
            }
            [_listView reloadData];
        }else{
            [self pushNoTabBarViewController:[[MineChangePassWordVC alloc]init] animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            [self pushNoTabBarViewController:[[MineFeedBackVC alloc]init] animated:YES];
        }
    }
}
//MARK:----------------------------------------MineSetUpChangePhoneTableViewCellDelegate------------------------------------------------
- (void)changeYourPhone:(NSString *)type{
    if ([type isEqualToString:@"密码认证"]) {
        [self pushNoTabBarViewController:[[MineChangePhoneWithPassWordVC alloc]init] animated:YES];
    }else{
        [self pushNoTabBarViewController:[[MineChangePhoneWithOldPhoneVC alloc]init] animated:YES];
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
