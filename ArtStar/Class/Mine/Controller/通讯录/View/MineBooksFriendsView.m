//
//  MineBooksFriendsView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBooksFriendsView.h"
#import "MineBooksFriendsTableViewCell.h"
#import "AppDelegate.h"
#import "MineChatDetaialViewController.h"

@interface MineBooksFriendsView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *friendsArr;

@end

@implementation MineBooksFriendsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _friendsArr = [NSMutableArray array];
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 70;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineBooksFriendsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineBooksFriendsTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _friendsArr.count;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    
    UITableViewRowAction *cancleAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *dic = weakSelf.dataArr[indexPath.row];
        [KGRequestNetWorking postWothUrl:attorcel parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"toId":dic[@"id"]} succ:^(id result) {
            if ([result[@"code"] integerValue] == 200) {
                [MBProgressHUD bwm_showTitle:@"操作成功" toView:weakSelf hideAfter:1];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshBooks" object:@{@"type":@"1"}];
            }else{
                [MBProgressHUD bwm_showTitle:@"操作失败" toView:weakSelf hideAfter:1];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf hideAfter:1];
        }];
    }];
    cancleAction.backgroundColor = Color_333333;
    return @[cancleAction];//topAction
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineBooksFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineBooksFriendsTableViewCell"];
    cell.foucsBtu.hidden = YES;
    NSDictionary *dic = _friendsArr[indexPath.row];
    cell.nameLab.text = dic[@"username"];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _friendsArr[indexPath.row];
    MineChatDetaialViewController *chatVC = [[MineChatDetaialViewController alloc]init];
    chatVC.title = dic[@"username"];
    chatVC.conversationType = ConversationType_PRIVATE;
    chatVC.targetId = [NSString stringWithFormat:@"%@",dic[@"id"]];
    chatVC.displayUserNameInCell = YES;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [[self supViewController].navigationController pushViewController:chatVC animated:YES];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"没有好友哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    _friendsArr = [NSMutableArray arrayWithArray:dataArr];
    [_listView reloadData];
}
// MARK: --获取控制器--
- (UIViewController *)supViewController{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
