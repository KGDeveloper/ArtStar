//
//  TaskListVC.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "TaskListVC.h"
#import "TaskListViewTableViewCell.h"
#import "TaskDetailVC.h"

@interface TaskListVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**
 待完成
 */
@property (nonatomic,strong) UIButton *waitBtu;
/**
 已完成
 */
@property (nonatomic,strong) UIButton *finishBtu;
/**
 我发布的
 */
@property (nonatomic,strong) UIButton *releaseBtu;
/**
 移动的线条
 */
@property (nonatomic,strong) UIView *line;
/**
 任务清单
 */
@property (nonatomic,strong) UITableView *listView;
/**
 数据
 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/**
 判断是否点击自己发布
 */
@property (nonatomic,assign) BOOL isSelf;

@end

@implementation TaskListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"清单" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray array];
    _isSelf = NO;
    [self createWaitData];
    [self setTopHeaderViewUI];
    [self setTaskListView];
}

// MARK: --顶部切换热不任务和接去任务--
- (void)setTopHeaderViewUI{
    // !!!: --待完成--
    _waitBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _waitBtu.frame = CGRectMake(0, NavTopHeight, kScreenWidth/3,48);
    [_waitBtu setTitle:@"待完成" forState:UIControlStateNormal];
    [_waitBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _waitBtu.titleLabel.font = SYFont(15);
    [_waitBtu addTarget:self action:@selector(waitTaskAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_waitBtu];
    // !!!: --已完成--
    _finishBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _finishBtu.frame = CGRectMake(kScreenWidth/3, NavTopHeight, kScreenWidth/3,48);
    [_finishBtu setTitle:@"已完成" forState:UIControlStateNormal];
    [_finishBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _finishBtu.titleLabel.font = SYFont(14);
    [_finishBtu addTarget:self action:@selector(finishTaskAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_finishBtu];
    // !!!: --我发布的--
    _releaseBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseBtu.frame = CGRectMake(kScreenWidth/3*2, NavTopHeight, kScreenWidth/3,48);
    [_releaseBtu setTitle:@"我发布的" forState:UIControlStateNormal];
    [_releaseBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _releaseBtu.titleLabel.font = SYFont(14);
    [_releaseBtu addTarget:self action:@selector(releaseTaskAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_releaseBtu];
    // !!!: --滑动线条--
    _line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/6 - 30, NavTopHeight + 48, 60, 2)];
    _line.backgroundColor = Color_333333;
    [self.view addSubview:_line];
    // !!!: --底部线条--
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 49, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [self.view addSubview:lowLine];
}
// MARK: --待完成点击事件--
- (void)waitTaskAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [_finishBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _finishBtu.titleLabel.font = SYFont(14);
    [_releaseBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _releaseBtu.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isSelf = NO;
    [self createWaitData];
}
// MARK: --已完成点击事件--
- (void)finishTaskAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [_waitBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _waitBtu.titleLabel.font = SYFont(14);
    [_releaseBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _releaseBtu.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isSelf = NO;
    [self createFinishData];
}
// MARK: --我发布的点击事件--
- (void)releaseTaskAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(15);
    [_finishBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _finishBtu.titleLabel.font = SYFont(14);
    [_waitBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _waitBtu.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isSelf = YES;
    [self createReleaseData];
}
// MARK: --创建任务清单--
- (void)setTaskListView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"TaskListViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TaskListViewTableViewCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskListViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskListViewTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.titleLab.text = dic[@"tname"];
    cell.timeLab.text = [NSString stringWithFormat:@"任务时间：%@-%@",dic[@"btime"],dic[@"otime"]];
    cell.detailLab.text = [NSString stringWithFormat:@"任务描述：%@",dic[@"describes"]];
    if (_isSelf == NO) {
        cell.statusBtu.hidden = YES;
    }else{
        if ([dic[@"stuts"] integerValue] == 1) {
            [cell.statusBtu setTitle:@"未接受" forState:UIControlStateNormal];
        }else if ([dic[@"stuts"] integerValue] == 2){
            [cell.statusBtu setTitle:@"未完成" forState:UIControlStateNormal];
        }else if ([dic[@"stuts"] integerValue] == 3){
            [cell.statusBtu setTitle:@"已超时" forState:UIControlStateNormal];
        }else if ([dic[@"stuts"] integerValue] == 4){
            [cell.statusBtu setTitle:@"已完成" forState:UIControlStateNormal];
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    TaskDetailVC *vc = [[TaskDetailVC alloc]init];
    vc.tid = dic[@"tid"];
    [self pushNoTabBarViewController:vc animated:YES];
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (_isSelf == YES) {
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消任务" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            NSDictionary *dic = weakSelf.dataArr[indexPath.row];
            if ([dic[@"stuts"] integerValue] == 1) {
                [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
                [KGRequestNetWorking postWothUrl:delUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":dic[@"tid"]} succ:^(id result) {
                    [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                    if ([result[@"code"] integerValue] == 200) {
                        [MBProgressHUD bwm_showTitle:@"撤销任务成功" toView:weakSelf.view hideAfter:1];
                        [weakSelf createReleaseData];
                    }else{
                        [MBProgressHUD bwm_showTitle:@"撤销任务失败" toView:weakSelf.view hideAfter:1];
                    }
                } fail:^(NSError *error) {
                    [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                }];
            }else{
                [MBProgressHUD bwm_showTitle:@"此任务无法撤销" toView:weakSelf.view hideAfter:1];
            }
        }];
        deleteAction.backgroundColor = Color_999999;
        return @[deleteAction];
    }else{
        return nil;
    }
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"木有内容哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}
// MARK: --待完成--
- (void)createWaitData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:MyreceptionUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.dataArr = [NSMutableArray arrayWithArray:result[@"data"]];
            [weakSelf.listView reloadData];
        }else{
            weakSelf.dataArr = [NSMutableArray array];
            [weakSelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --已完成--
- (void)createFinishData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:MyreceptionOverUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.dataArr = [NSMutableArray arrayWithArray:result[@"data"]];
            [weakSelf.listView reloadData];
        }else{
            weakSelf.dataArr = [NSMutableArray array];
            [weakSelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}
// MARK: --我发布的--
- (void)createReleaseData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:MyreceptionAllUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.dataArr = [NSMutableArray arrayWithArray:result[@"data"]];
            [weakSelf.listView reloadData];
        }else{
            weakSelf.dataArr = [NSMutableArray array];
            [weakSelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
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
