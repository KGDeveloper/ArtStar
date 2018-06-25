//
//  MineWriteTheIdentityInfoVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineWriteTheIdentityInfoVC.h"
#import "MineChooseIndustryTableViewCell.h"
#import "MineUnitAndPositionTableViewCell.h"
#import "MinePushIDCardTableViewCell.h"
#import "MineTheIdentityJoinTableViewCell.h"
#import "MineWorksIndustryView.h"

@interface MineWriteTheIdentityInfoVC ()<UITableViewDelegate,UITableViewDataSource,MineChooseIndustryTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineWorksIndustryView *chooseWorks;

@end

@implementation MineWriteTheIdentityInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"填写认证信息" image:Image(@"back")];
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
    
    [_listView registerNib:[UINib nibWithNibName:@"MineChooseIndustryTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineChooseIndustryTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineUnitAndPositionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineUnitAndPositionTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MinePushIDCardTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MinePushIDCardTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    }else if (indexPath.row == 1){
        return 111;
    }else if (indexPath.row == 4){
        return 70;
    }else{
        return 175;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MineChooseIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineChooseIndustryTableViewCell"];
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 1){
        MineUnitAndPositionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineUnitAndPositionTableViewCell"];
        return cell;
    }else if (indexPath.row == 2){
        MinePushIDCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePushIDCardTableViewCell"];
        return cell;
    }else if (indexPath.row == 3){
        MinePushIDCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MinePushIDCardTableViewCell"];
        cell.titleLab.text = @"上传以下证件材料(例如工牌等)";
        [cell.leftBtu setImage:Image(@"职业证明材料") forState:UIControlStateNormal];
        cell.rightBtu.hidden = YES;
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"完成(2/2)";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (MineWorksIndustryView *)chooseWorks{
    if (!_chooseWorks) {
        _chooseWorks = [[MineWorksIndustryView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_chooseWorks];
    }
    return _chooseWorks;
}
//MARK:---------------------------------------MineChooseIndustryTableViewCellDelegate-------------------------------------------------
- (void)showIndustryViewChooseJob{
    self.chooseWorks.hidden = NO;
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
