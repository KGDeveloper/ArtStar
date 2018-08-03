//
//  MineJoinAddBaseInfoVC.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineJoinAddBaseInfoVC.h"
#import "MineTheIdentityJoinTableViewCell.h"
#import "MineAddBaseInfoTableViewCell.h"
#import "MineAddBaseNameAndPhoneTableViewCell.h"
#import "MineAddBaseInfoChooseIDTableViewCell.h"
#import "MineChooseCardTypeView.h"
#import "MineWriteTheIdentityInfoVC.h"

@interface MineJoinAddBaseInfoVC ()<UITableViewDelegate,UITableViewDataSource,MineAddBaseInfoChooseIDTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineChooseCardTypeView *chooseCardView;

@end

@implementation MineJoinAddBaseInfoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"补充基本信息" image:Image(@"back")];
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
    
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineAddBaseInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAddBaseInfoTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineAddBaseNameAndPhoneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAddBaseNameAndPhoneTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineAddBaseInfoChooseIDTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAddBaseInfoChooseIDTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 60;
    }else if (indexPath.row == 1){
        return 110;
    }else if (indexPath.row == 2){
        return 110;
    }else{
        return 70;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        MineAddBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddBaseInfoTableViewCell"];
        return cell;
    }else if (indexPath.row == 1){
        MineAddBaseNameAndPhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddBaseNameAndPhoneTableViewCell"];
        return cell;
    }else if (indexPath.row == 2){
        MineAddBaseInfoChooseIDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddBaseInfoChooseIDTableViewCell"];
        cell.delegate = self;
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"下一步(1/2)";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        MineWriteTheIdentityInfoVC *identity = [[MineWriteTheIdentityInfoVC alloc]init];
        [self pushNoTabBarViewController:identity animated:YES];
    }
}

- (MineChooseCardTypeView *)chooseCardView{
    if (!_chooseCardView) {
        _chooseCardView = [[MineChooseCardTypeView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        [self.navigationController.view addSubview:_chooseCardView];
    }
    return _chooseCardView;
}
//MARK:-------------------------------------MineAddBaseInfoChooseIDTableViewCellDelegate---------------------------------------------------
- (void)showChooseCardView{
    self.chooseCardView.hidden = NO;
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
