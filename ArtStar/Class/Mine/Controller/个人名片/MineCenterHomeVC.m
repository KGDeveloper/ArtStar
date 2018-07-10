//
//  MyselfCenterVC.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MineCenterHomeVC.h"
#import "MyselfCenterHeaderView.h"
#import "MineCenterMyCoverCell.h"
#import "MyselfCenterMyLabelCell.h"
#import "MyselfCenterSchoolCell.h"
#import "MyselfCenterVideoAndVicesAndBooksCell.h"
#import "MyselfCenterMyWordCell.h"
#import "MyselfCenterVideo+Music+BookVC.h"
#import "FriendsVC.h"
#import "MineEditMyselfCardVC.h"
#import "MineMyselfCenterInfoModel.h"
#import "MineMyselfCenterInfoThecoverModel.h"
#import "MineSelfCenterImageLIstModel.h"

@interface MineCenterHomeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineMyselfCenterInfoModel *model;
@property (nonatomic,strong) MyselfCenterHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,copy) NSString *coverImageStr;

@end

@implementation MineCenterHomeVC

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageArr = [NSMutableArray array];
    [self createData];
    [self setTableView];
}

- (void)createData{
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:seachUserInforMore parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            NSDictionary *dic = arr[0];
            mySelf.model = [MineMyselfCenterInfoModel mj_objectWithKeyValues:dic];
            NSArray *array = mySelf.model.imageUris;
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                MineSelfCenterImageLIstModel *model = [MineSelfCenterImageLIstModel mj_objectWithKeyValues:dic];
                if ([model.iscover integerValue] == 0) {
                    [mySelf.imageArr addObject:model.imageURL];
                }else{
                    mySelf.coverImageStr = model.imageURL;
                }
            }
            mySelf.headerView.dataArr = mySelf.imageArr;
            [mySelf.listView reloadData];
        }
    } fail:^(NSString *error) {
        
    }];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, -(NavTopHeight - 44), kScreenWidth, kScreenHeight +(NavTopHeight - 44))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableHeaderView = [self setTableViewHeader];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCenterMyCoverCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCenterMyCoverCell"];
    [_listView registerClass:[MyselfCenterMyLabelCell class] forCellReuseIdentifier:@"MyselfCenterMyLabelCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfCenterSchoolCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfCenterSchoolCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfCenterVideoAndVicesAndBooksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfCenterVideoAndVicesAndBooksCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfCenterMyWordCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfCenterMyWordCell"];
}

- (UIView *)setTableViewHeader{
    _headerView = [[MyselfCenterHeaderView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _headerView.rightName = @"编辑";
    __weak typeof(self) mySelf = self;
    _headerView.pushViewController = ^(NSString *btuTitle) {
        if ([btuTitle isEqualToString:@"返回"]) {
            [mySelf.navigationController popViewControllerAnimated:YES];
        }else{
            [mySelf pushNoTabBarViewController:[[MineEditMyselfCardVC alloc]init] animated:YES];
        }
    };
    return _headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (kScreenWidth - 30)/690*534 + 65;
    }else if (indexPath.row == 1){
        MyselfCenterMyLabelCell *cell = [MyselfCenterMyLabelCell new];
        return [cell heightWithArr:@[@"射手座",@"乌鲁木齐",@"AB型",@"163cm",@"画家",@"文艺工作者：纪实摄影",@"轩哥哥制作"]];
    }else if (indexPath.row == 2){
        return 120;
    }else if (indexPath.row == 3){
        return 220;
    }else if (indexPath.row == 4){
        return 40;
    }else{
        MyselfCenterMyLabelCell *cell = [MyselfCenterMyLabelCell new];
        return [cell heightWithArr:@[@"射手座",@"乌鲁木齐",@"AB型",@"163cm",@"画家",@"文艺工作者：纪实摄影",@"轩哥哥制作"]];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineCenterMyCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCenterMyCoverCell"];
        cell.loadBtu.hidden = YES;
        [cell.coverImage sd_setImageWithURL:[NSURL URLWithString:_coverImageStr]];
        return cell;
    }else if (indexPath.row == 1){
        MyselfCenterMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterMyLabelCell"];
//        cell.labArr = _model.mylabels;
        return cell;
    }else if (indexPath.row == 2){
        MyselfCenterSchoolCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterSchoolCell"];
        cell.industryLab.text = _model.iname;
        cell.schoolLab.text = _model.school;
        return cell;
    }else if (indexPath.row == 3){
        MyselfCenterVideoAndVicesAndBooksCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterVideoAndVicesAndBooksCell"];
        return cell;
    }else if (indexPath.row == 4){
        MyselfCenterMyWordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterMyWordCell"];
        return cell;
    }else if (indexPath.row == 5){
        MyselfCenterMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterMyLabelCell"];
        cell.labArr = @[@"射手座",@"乌鲁木齐",@"AB型",@"163cm",@"画家",@"文艺工作者：纪实摄影",@"轩哥哥制作"];
        cell.titleStr = @"喜欢的美食";
        return cell;
    }else if (indexPath.row == 6){
        MyselfCenterMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterMyLabelCell"];
        cell.labArr = @[@"射手座",@"乌鲁木齐",@"AB型",@"163cm",@"画家",@"文艺工作者：纪实摄影",@"轩哥哥制作"];
        cell.titleStr = @"喜欢的运动";
        return cell;
    }else if (indexPath.row == 7){
        MyselfCenterMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterMyLabelCell"];
        cell.labArr = @[@"射手座",@"乌鲁木齐",@"AB型",@"163cm",@"画家",@"文艺工作者：纪实摄影",@"轩哥哥制作"];
        cell.titleStr = @"喜欢的休闲方式";
        return cell;
    }else{
        MyselfCenterMyLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfCenterMyLabelCell"];
        cell.labArr = @[@"射手座",@"乌鲁木齐",@"AB型",@"163cm",@"画家",@"文艺工作者：纪实摄影",@"轩哥哥制作"];
        cell.titleStr = @"我的旅行足迹";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        [self pushNoTabBarViewController:[[MyselfCenterVideo_Music_BookVC alloc]init] animated:YES];
    }else if (indexPath.row == 0){
        [self pushNoTabBarViewController:[[FriendsVC alloc]init] animated:YES];
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
