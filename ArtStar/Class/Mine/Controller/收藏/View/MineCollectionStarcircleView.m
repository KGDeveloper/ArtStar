//
//  MineCollectionStarcircleView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionStarcircleView.h"
#import "MineCollectionStarCircleTableViewCell.h"

@interface MineCollectionStarcircleView ()<UITableViewDelegate,UITableViewDataSource,MineCollectionStarCircleTableViewCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) NSInteger page;

@end

@implementation MineCollectionStarcircleView

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
    _listView.rowHeight = 165;
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
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCollectionStarCircleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCollectionStarCircleTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionStarCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCollectionStarCircleTableViewCell"];
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        if (![dic[@"portraitUri"] isKindOfClass:[NSNull class]]) {
            [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"portraitUri"]]];
        }
        if (![dic[@"content"] isKindOfClass:[NSNull class]]) {
            NSData *jsonData = [dic[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *strArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSString *str = strArr[0];
            for (int i = 1; i < strArr.count; i++) {
                str = [NSString stringWithFormat:@"%@%@",str,strArr[i]];
            }
            cell.detailLab.text = str;
        }
        if (![dic[@"username"] isKindOfClass:[NSNull class]]) {
            cell.nameLab.text = dic[@"username"];
        }
        if (![dic[@"createTime"] isKindOfClass:[NSNull class]]) {
            cell.timeLab.text = dic[@"createTime"];
        }
        if (![dic[@"friendImg"] isKindOfClass:[NSNull class]]) {
            cell.topWidth.constant = 80;
            NSString *endStr = [[dic[@"friendImg"] componentsSeparatedByString:@"."] lastObject];
            if ([endStr isEqualToString:@"mp4"]) {
                cell.topImage.image = [[KGRequestNetWorking shareIntance] thumbnailImageForVideo:[NSURL URLWithString:dic[@"friendImg"]]];
            }else{
                [cell.topImage sd_setImageWithURL:[NSURL URLWithString:dic[@"friendImg"]]];
            }
        }else{
            cell.topWidth.constant = 0;
        }
        cell.cellId = [dic[@"id"] integerValue];
    }
    cell.delegate = self;
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
// MARK: --MineCollectionStarCircleTableViewCellDelegate--
- (void)deleteContellWithID:(NSInteger)ID{
    __weak typeof(self) weakSelf = self;
    [KGRequestNetWorking postWothUrl:deletePersonCollectByid parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":@(ID)} succ:^(id result) {
        [weakSelf.listView.mj_header beginRefreshing];
    } fail:^(NSError *error) {
        [weakSelf.listView.mj_header beginRefreshing];
    }];
}
- (void)createData{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [KGRequestNetWorking postWothUrl:seachPersonCollect parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"collectType":@"2",@"pcquery":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
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
