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

@end

@implementation TaskDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"任务详情" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
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
        return cell;
    }else if (indexPath.row > 0 & indexPath.row < 9){
        ReleaseTaskWriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskWriteCell" forIndexPath:indexPath];
        return cell;
    }else{
        ReleaseTaskIntrduiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTaskIntrduiceCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
}
// MARK: --ReleaseTaskIntrduiceCellDelegate--
- (void)releaseTask{
    
}

- (void)createData{
    [KGRequestNetWorking postWothUrl:checkOneUserTask parameters:@{@"":[KGUserInfo shareInterace].userTokenCode,@"id":_tid} succ:^(id result) {
        
    } fail:^(NSError *error) {
        
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
