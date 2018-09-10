//
//  MineBooksFocusView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBooksFocusView.h"
#import "MineBooksFriendsTableViewCell.h"
#import "MineChatDetaialViewController.h"

@interface MineBooksFocusView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIButton *leftBtu;
@property (nonatomic,strong) UIButton *rightBtu;
@property (nonatomic,strong) UIView *line;

@property (nonatomic,assign) BOOL isNews;

@end

@implementation MineBooksFocusView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _isNews = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    
    _leftBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtu.frame = CGRectMake(0, 0, ViewWidth(self)/2, 50);
    [_leftBtu setTitle:@"关注的人" forState:UIControlStateNormal];
    [_leftBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(14);
    [_leftBtu addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtu];
    
    _rightBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtu.frame = CGRectMake(ViewWidth(self)/2, 0, ViewWidth(self)/2, 50);
    [_rightBtu setTitle:@"新闻账号" forState:UIControlStateNormal];
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [_rightBtu addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtu];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49, ViewWidth(self), 1)];
    lowLine.backgroundColor = Color_ededed;
    [self addSubview:lowLine];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(ViewWidth(self)/4 - 23, 48, 55, 2)];
    _line.backgroundColor = Color_333333;
    [self addSubview:_line];
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ViewWidth(self), ViewHeight(self) - 50)];
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
    if (_isNews == YES) {
        return _newsArr.count;
    }else{
        return _peopleArr.count;
    }
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    __weak typeof(self) weakSelf = self;
    
    UITableViewRowAction *cancleAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (weakSelf.isNews == YES) {
            NSDictionary *dic = weakSelf.newsArr[indexPath.row];
            [KGRequestNetWorking postWothUrl:attorcel parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"zid":dic[@"id"]} succ:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    [MBProgressHUD bwm_showTitle:@"操作成功" toView:weakSelf hideAfter:1];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshBooks" object:@{@"type":@"3"}];
                }else{
                    [MBProgressHUD bwm_showTitle:@"操作失败" toView:weakSelf hideAfter:1];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf hideAfter:1];
            }];
        }else{
            NSDictionary *dic = weakSelf.peopleArr[indexPath.row];
            [KGRequestNetWorking postWothUrl:attorcel parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"toId":dic[@"id"]} succ:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    [MBProgressHUD bwm_showTitle:@"操作成功" toView:weakSelf hideAfter:1];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshBooks" object:@{@"type":@"2"}];
                }else{
                    [MBProgressHUD bwm_showTitle:@"操作失败" toView:weakSelf hideAfter:1];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf hideAfter:1];
            }];
        }
    }];
    cancleAction.backgroundColor = Color_333333;
    return @[cancleAction];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineBooksFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineBooksFriendsTableViewCell"];
    if (_isNews == YES) {
        cell.foucsBtu.hidden = NO;
        [cell.foucsBtu setTitle:@"已关注" forState:UIControlStateNormal];
        cell.foucsBtu.backgroundColor = Color_999999;
        cell.imageWidth.constant = 0;
    }else{
        cell.foucsBtu.hidden = YES;
        cell.imageWidth.constant = 40;
        NSDictionary *dic = _peopleArr[indexPath.row];
        cell.nameLab.text = dic[@"username"];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isNews == NO) {
        NSDictionary *dic = _peopleArr[indexPath.row];
        MineChatDetaialViewController *chatVC = [[MineChatDetaialViewController alloc]init];
        chatVC.title = dic[@"username"];
        chatVC.conversationType = ConversationType_PRIVATE;
        chatVC.targetId = [NSString stringWithFormat:@"%@",dic[@"id"]];
        chatVC.displayUserNameInCell = YES;
        [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
        [[self supViewController].navigationController pushViewController:chatVC animated:YES];
    }
}

- (void)leftClick:(UIButton *)sender{
    [_rightBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _rightBtu.titleLabel.font = SYFont(13);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isNews = NO;
    [_listView reloadData];
}

- (void)rightClick:(UIButton *)sender{
    [_leftBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _leftBtu.titleLabel.font = SYFont(13);
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    sender.titleLabel.font = SYFont(14);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    _isNews = YES;
    [_listView reloadData];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"没有数据哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}

- (void)setPeopleArr:(NSArray *)peopleArr{
    _peopleArr = peopleArr;
    [_listView reloadData];
}
- (void)setNewsArr:(NSArray *)newsArr{
    _newsArr = newsArr;
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
