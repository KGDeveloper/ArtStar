//
//  MineQuestionHelpVC.m
//  ArtStar
//
//  Created by abc on 2018/6/20.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineQuestionHelpVC.h"
#import "MineHelpChooseTableViewCell.h"
#import "MineTheIdentityJoinTableViewCell.h"

@interface MineQuestionHelpVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineQuestionHelpVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"问题求助" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}

- (void)setUI{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight , kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineHelpChooseTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineHelpChooseTableViewCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MineTheIdentityJoinTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTheIdentityJoinTableViewCell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *titleArr = @[@"帮助",@"更多帮助"];
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    header.backgroundColor = Color_fafafa;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth - 30, 40)];
    lab.textColor = Color_333333;
    lab.text = titleArr[section];
    lab.font = SYFont(12);
    [header addSubview:lab];
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 250;
    }else{
        return 40;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MineHelpChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineHelpChooseTableViewCell"];
        return cell;
    }else{
        MineTheIdentityJoinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTheIdentityJoinTableViewCell"];
        cell.textLab.text = @"问一问";
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
