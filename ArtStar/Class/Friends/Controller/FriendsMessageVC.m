//
//  FriendsMessageVC.m
//  ArtStar
//
//  Created by abc on 5/23/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "FriendsMessageVC.h"
#import "FriednsMessageCell.h"
#import "FriendsDeleteAllMessageView.h"
#import "FriendsMessageModel.h"

@interface FriendsMessageVC ()<UITableViewDelegate,UITableViewDataSource,FriendsDeleteAllMessageViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) FriendsDeleteAllMessageView *deleteView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation FriendsMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"消息" image:Image(@"back")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 150, 30) title:nil image:Image(@"empty")];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    [self createData];
    [self setUpTableView];
}
- (void)rightNavBtuAction:(UIButton *)sender{
    self.deleteView.hidden = NO;
}

- (void)createData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _dataArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [KGRequestNetWorking postWothUrl:pushUnreadMessages parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"informQuery":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            NSArray *arr = result[@"data"];
            mySelf.dataArr = [FriendsMessageModel mj_objectArrayWithKeyValuesArray:arr];
            [mySelf.listView reloadData];
        }
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:mySelf.view animated:YES];
    }];
}

- (void)setUpTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 75;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"FriednsMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FriednsMessageCell"];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) mySelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [mySelf.dataArr removeObjectAtIndex:indexPath.row];
        [mySelf.listView reloadData];
    }];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"屏蔽" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    editAction.backgroundColor = Color_cccccc;
    return @[deleteAction,editAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriednsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriednsMessageCell"];
    FriendsMessageModel *model = _dataArr[indexPath.row];
    if ([model.islikeCount integerValue] == 1) {
        [cell showZansImage];
    }else{
        cell.detaialLab.text = model.content;
    }
    if (model.images.count > 0) {
        NSDictionary *imagedic = [model.images firstObject];
        [cell.rightImage sd_setImageWithURL:[NSURL URLWithString:imagedic[@"imageURL"]]];
    }else{
        cell.rightImage.hidden = YES;
    }
    NSDictionary *dic = model.userInfor;
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    cell.nikName.text = dic[@"username"];
    cell.timeLab.text = model.createTimeStr;
    return cell;
}

- (FriendsDeleteAllMessageView *)deleteView{
    if (!_deleteView) {
        _deleteView = [[FriendsDeleteAllMessageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _deleteView.delegate = self;
        [self.navigationController.view addSubview:_deleteView];
    }
    return _deleteView;
}
//MARK:--FriendsDeleteAllMessageViewDelegate--
- (void)deleteAllMessage{
    [_dataArr removeAllObjects];
    [_listView reloadData];
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
