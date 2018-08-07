//
//  MineIntegralDetailVC.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineIntegralDetailVC.h"
#import "MineIntegralDetailCell.h"
#import "MineIntefralModel.h"

@interface MineIntegralDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MineIntegralDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"积分明细" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [NSMutableArray array];
    [self createData];
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.rowHeight = 50;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineIntegralDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineIntegralDetailCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineIntegralDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineIntegralDetailCell"];
    if (_dataArr.count > 0) {
        MineIntefralModel *model = _dataArr[indexPath.row];
        cell.titleLab.text = model.details;
        cell.timeLab.text = model.time;
        cell.countLab.text = [NSString stringWithFormat:@"+%@",model.number];
    }
    return cell;
}
// MARK: --积分明细--
- (void)createData{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在加载..."];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:findAllUserIntegral parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":[KGUserInfo shareInterace].userID} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.dataArr = [MineIntefralModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
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
