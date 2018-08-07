//
//  MineIntegralVC.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineIntegralVC.h"
#import "MineIntegralHeaderView.h"
#import "MineIntegraltableViewCell.h"
#import "MineIntegralDetailVC.h"

@interface MineIntegralVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MineIntegralHeaderView *headerView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *dataArr;

@end

@implementation MineIntegralVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,-(NavTopHeight - 44), kScreenWidth, kScreenHeight + (NavTopHeight - 44))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    _listView.rowHeight = 50;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableHeaderView];
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineIntegraltableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineIntegraltableViewCell"];
}
- (UIView *)setTableHeaderView{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenWidth/750*430)];
    _headerView = [[MineIntegralHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ViewHeight(header))];
    __weak typeof(self) mySelf = self;
    _headerView.doTaskWithTitle = ^(NSString *title) {
        if ([title isEqualToString:@"返回"]) {
            [mySelf.navigationController popViewControllerAnimated:YES];
        }else if ([title isEqualToString:@"积分明细"]){
            [mySelf pushNoTabBarViewController:[[MineIntegralDetailVC alloc]init] animated:YES];
        }else{
            
        }
    };
    [header addSubview:_headerView];
    return header;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = Color_fafafa;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15,0, kScreenWidth - 30, 40)];
    titleLab.text = @"每日任务";
    titleLab.textColor = Color_333333;
    titleLab.font = SYBFont(13);
    [header addSubview:titleLab];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineIntegraltableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineIntegraltableViewCell"];
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
