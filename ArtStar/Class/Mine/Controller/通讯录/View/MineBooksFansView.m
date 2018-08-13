//
//  MineBooksFansView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBooksFansView.h"
#import "MineBooksFriendsTableViewCell.h"

@interface MineBooksFansView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,MineBooksFriendsTableViewCellDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineBooksFansView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineBooksFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineBooksFriendsTableViewCell"];
    cell.foucsBtu.hidden = NO;
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.nameLab.text = dic[@"username"];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
    cell.delegate = self;
    cell.ID = [NSString stringWithFormat:@"%@",dic[@"id"]];
    
    return cell;
}
// MARK: --MineBooksFriendsTableViewCellDelegate--
- (void)foucsActionWithID:(NSString *)ID{
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:attorcel parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"toId":ID} succ:^(id result) {
        if ([result[@"code"] integerValue] == 200) {
            [MBProgressHUD bwm_showTitle:@"操作成功" toView:weakSelf hideAfter:1];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshBooks" object:@{@"type":@"4"}];
        }else{
            [MBProgressHUD bwm_showTitle:@"操作失败" toView:weakSelf hideAfter:1];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD bwm_showTitle:@"请求出错" toView:weakSelf hideAfter:1];
    }];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return Image(@"空空如也");
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *str = @"没有粉丝哦~";
    NSDictionary *attributes = @{NSFontAttributeName:SYFont(15),NSForegroundColorAttributeName:Color_999999};
    return [[NSAttributedString alloc]initWithString:str attributes:attributes];
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 25.0;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
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
