//
//  PickUpTaskView.m
//  ArtStar
//
//  Created by 文艺星球 on 2018/8/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "PickUpTaskView.h"
#import "PickUpTaskTableViewCell.h"
#import "TaskDetailVC.h"

@interface PickUpTaskView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation PickUpTaskView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _dataArr = [NSMutableArray array];
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.bounces = NO;
    _listView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"PickUpTaskTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PickUpTaskTableViewCell"];
}
// MARK: --UITableViewDelegate--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
// MARK :--UITableViewDataSource--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PickUpTaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PickUpTaskTableViewCell" forIndexPath:indexPath];
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.titleLab.text = dic[@"tname"];
    cell.detailLab.text = [NSString stringWithFormat:@"报酬：%@/小时",dic[@"money"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    TaskDetailVC *vc = [[TaskDetailVC alloc]init];
    vc.tid = dic[@"tid"];
    [[self supViewController].navigationController pushViewController:vc animated:YES];
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

- (void)reloadData{
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:checkUserTask parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"taskQuery":@{@"page":@"1",@"rows":@"15",@"maddress":@"北京市"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            weakSelf.dataArr = result[@"data"];
            [weakSelf.listView reloadData];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        [MBProgressHUD bwm_showTitle:@"请求失败" toView:weakSelf hideAfter:1];
    }];
}

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
