//
//  TaskDetailVC.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "TaskDetailVC.h"
#import "ReleaseTaskWriteCell.h"
#import "ReleaseTaskIntrduiceCell.h"
#import "TaskDetailTableViewCell.h"

@interface TaskDetailVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,ReleaseTaskIntrduiceCellDelegate>

@property (nonatomic,strong) UITableView *listView;
/**
 保存任务详情
 */
@property (nonatomic,copy) NSDictionary *dataDic;
/**
 保存cell标题以及预留字
 */
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"任务详情" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = @[@{@"name":@"任务名称",@"title":@"请填写任务名称"},@{@"name":@"开始时间",@"title":@"请选择任务开始时间"},@{@"name":@"结束时间",@"title":@"请选择任务结束时间"},@{@"name":@"任务地点",@"title":@"请填写任务地点"},@{@"name":@"任务薪酬",@"title":@"请填写任务薪酬"},@{@"name":@"联系方式",@"title":@"请填写联系方式"},@{@"name":@"任务类型",@"title":@"请填写任务类型"}];
    [self createData];
    [self setTaskListView];
}
// MARK: --创建任务详情--
- (void)setTaskListView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"ReleaseTaskWriteCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReleaseTaskWriteCell"];
    [_listView registerNib:[UINib nibWithNibName:@"ReleaseTaskIntrduiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ReleaseTaskIntrduiceCell"];
    [_listView registerNib:[UINib nibWithNibName:@"TaskDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TaskDetailTableViewCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 8) {
        return 50;
    }else{
        return 200;
    }
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TaskDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskDetailTableViewCell" forIndexPath:indexPath];
        NSDictionary *userDic = _dataDic[@"user"];
        cell.nameLab.text = userDic[@"username"];
        [cell.headerIamge sd_setImageWithURL:[NSURL URLWithString:userDic[@"portraitUri"]]];
        return cell;
    }else if (indexPath.row > 0 & indexPath.row < 8){
        ReleaseTaskWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskWriteCell" forIndexPath:indexPath];
        NSDictionary *dic = _dataArr[indexPath.row - 1];
        cell.nameLab.text = dic[@"name"];
        cell.titleText.placeholder = dic[@"title"];
        if (indexPath.row == 1) {
            cell.titleText.text = _dataDic[@"tname"];
        }else if (indexPath.row == 2){
            cell.titleText.text = _dataDic[@"btime"];
        }else if (indexPath.row == 3){
            cell.titleText.text = _dataDic[@"otime"];
        }else if (indexPath.row == 4){
            cell.titleText.text = _dataDic[@"tdrtess"];
        }else if (indexPath.row == 5){
            cell.titleText.text = [NSString stringWithFormat:@"%@/小时",_dataDic[@"money"]];
        }else if (indexPath.row == 6){
            cell.titleText.text = _dataDic[@"tel"];
        }else if (indexPath.row == 7){
            cell.titleText.text = _dataDic[@"type"];
        }
        cell.titleText.enabled = NO;
        return cell;
    }else{
        ReleaseTaskIntrduiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskIntrduiceCell" forIndexPath:indexPath];
        cell.placehodleLab.hidden = YES;
        cell.writeLab.text = _dataDic[@"describes"];
        cell.writeLab.editable = YES;
        cell.delegate = self;
        cell.taskID = [_dataDic[@"tid"] integerValue];
        if ([_dataDic[@"stuts"] integerValue] == 1) {
            cell.type = @"待接取";
            [cell.releaseBtu setTitle:@"待接取" forState:UIControlStateNormal];
        }else if ([_dataDic[@"stuts"] integerValue] == 2){
            cell.type = @"已接取";
            cell.writeLab.editable = NO;
            [cell.releaseBtu setTitle:@"已接取" forState:UIControlStateNormal];
            cell.releaseBtu.backgroundColor = Color_333333;
        }else if ([_dataDic[@"stuts"] integerValue] == 3){
            if ([_dataDic[@"uid"] integerValue] == [[KGUserInfo shareInterace].userID integerValue]) {
                cell.type = @"能确认";
            }else{
                cell.type = @"没有权限";
            }
            [cell.releaseBtu setTitle:@"待完成" forState:UIControlStateNormal];
        }else if ([_dataDic[@"stuts"] integerValue] == 4){
            [cell.releaseBtu setTitle:@"已完成" forState:UIControlStateNormal];
            cell.writeLab.editable = NO;
            cell.releaseBtu.backgroundColor = Color_333333;
        }
        return cell;
    }
}
// MARK: --ReleaseTaskIntrduiceCellDelegate--
- (void)releaseTask:(NSString *)type taskId:(NSInteger)taskID{
    if ([type isEqualToString:@"待接取"]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:receptionUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":@(taskID)} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:result[@"message"] toView:weakSelf.view hideAfter:1];
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    }else if ([type isEqualToString:@"能确认"]){
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        __weak typeof(self) weakSelf = self;
        [KGRequestNetWorking postWothUrl:overUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":@(taskID)} succ:^(id result) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
            [MBProgressHUD bwm_showTitle:result[@"message"] toView:weakSelf.view hideAfter:1];
        } fail:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        }];
    }
}

- (void)sendTaskDescribe:(NSString *)describe {
    
}


- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [KGRequestNetWorking postWothUrl:checkOneUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":_tid} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            weakSelf.dataDic = [tmp firstObject];
            [weakSelf.listView reloadData];
        }else{
            [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf.view hideAfter:1];
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
