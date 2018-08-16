//
//  MineCollectionThemeView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionThemeView.h"
#import "MusicManagementMyThemeCell.h"

@interface MineCollectionThemeView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;

@end

@implementation MineCollectionThemeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _dataArr = [NSMutableArray array];
        _page = 1;
        [self createData];
        [self setTableView];
    }
    return self;
}
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.emptyDataSetSource = self;
    _listView.emptyDataSetDelegate = self;
    _listView.rowHeight = 60;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __weak typeof(self) weakSelf = self;
    _listView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        weakSelf.dataArr = [NSMutableArray array];
        [weakSelf.listView.mj_header beginRefreshing];
        [weakSelf createData];
    }];
    _listView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        [weakSelf.listView.mj_footer beginRefreshing];
        [weakSelf createData];
    }];
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicManagementMyThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicManagementMyThemeCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *dic = weakSelf.dataArr[indexPath.row];
        [KGRequestNetWorking postWothUrl:deletePersonCollectByid parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":dic[@"id"]} succ:^(id result) {
            [weakSelf.listView.mj_header beginRefreshing];
        } fail:^(NSError *error) {
            [weakSelf.listView.mj_header beginRefreshing];
        }];
    }];
    deleteAction.backgroundColor = Color_333333;
    return @[deleteAction];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicManagementMyThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicManagementMyThemeCell"];
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        if (![dic[@"topicContent"] isKindOfClass:[NSNull class]]) {
            NSData *strData = [dic[@"topicContent"] dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&error];
            NSString *str = dataArr[0];
            for (int i = 1; i < dataArr.count; i++) {
                str = [NSString stringWithFormat:@"%@%@",str,dataArr[i]];
            }
            cell.themeIntruceLab.text = str;
        }
        
        cell.themeLab.text = [NSString stringWithFormat:@"# %@ #",dic[@"topictitle"]];
        if (![dic[@"topicImg"] isKindOfClass:[NSNull class]]) {
            [cell.themeImage sd_setImageWithURL:[NSURL URLWithString:dic[@"topicImg"]]];
        }
    }
    return cell;
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

- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequestNetWorking postWothUrl:seachPersonCollect parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"collectType":@"3",@"pcquery":@{@"page":@(_page),@"rows":@"15"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
            }
        }
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        [weakSelf.listView.mj_footer endRefreshing];
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView reloadData];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
