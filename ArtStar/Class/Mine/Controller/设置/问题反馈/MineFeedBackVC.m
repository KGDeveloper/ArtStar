//
//  MineFeedBackVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineFeedBackVC.h"
#import "MineFeedBackChooseTableViewCell.h"
#import "MineFeedBackIdeaTableViewCell.h"
#import "MineFeedBackPictureTableViewCell.h"
#import "MineTheIdentityJoinTableViewCell.h"

@interface MineFeedBackVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,copy) NSArray *headerArr;

@end

@implementation MineFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"意见反馈" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headerArr = @[@"请选择问题发生场景",@"请输入详细问题和意见",@"请提供问题相关截图或照片",@""];
    [self setUI];
}

- (void)setUI{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineFeedBackChooseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFeedBackChooseTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineFeedBackIdeaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFeedBackIdeaTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineFeedBackPictureTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineFeedBackPictureTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 246;
    }else if (indexPath.section == 1){
        return 100;
    }else if (indexPath.section == 2){
        return 105;
    }else{
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = Color_fafafa;
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    lab.textColor = Color_333333;
    lab.text = _headerArr[section];
    lab.font = SYFont(12);
    [header addSubview:lab];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 0;
    }else{
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineFeedBackChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFeedBackChooseTableViewCell"];
        return cell;
    }else if (indexPath.section == 1){
        MineFeedBackIdeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFeedBackIdeaTableViewCell"];
        cell.ideaTF.delegate = cell;
        return cell;
    }else if (indexPath.section == 2){
        MineFeedBackPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineFeedBackPictureTableViewCell"];
        cell.backView.contentSize = CGSizeMake(90*5, 75);
        cell.photosArr = @[];
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"提交";
        return cell;
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
