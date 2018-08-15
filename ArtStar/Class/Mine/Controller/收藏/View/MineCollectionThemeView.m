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

@end

@implementation MineCollectionThemeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _dataArr = [NSMutableArray array];
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
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicManagementMyThemeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicManagementMyThemeCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    deleteAction.backgroundColor = Color_333333;
    return @[deleteAction];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicManagementMyThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicManagementMyThemeCell"];
    if (_dataArr.count > 0) {
        NSDictionary *dic = _dataArr[indexPath.row];
        if (![dic[@"content"] isKindOfClass:[NSNull class]]) {
            NSData *strData = [dic[@"content"] dataUsingEncoding:NSUTF8StringEncoding];
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
        if (![dic[@"friendImg"] isKindOfClass:[NSNull class]]) {
            cell.themeImage.image = [[KGRequestNetWorking shareIntance] thumbnailImageForVideo:[NSURL URLWithString:dic[@"friendImg"]]];
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
    [KGRequestNetWorking postWothUrl:seachPersonCollect parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"collectType":@"3",@"pcquery":@{@"page":@"1",@"rows":@"15"}} succ:^(id result) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
        if ([result[@"code"] integerValue] == 200) {
            NSArray *tmp = result[@"data"];
            if (tmp.count > 0) {
                [weakSelf.dataArr addObjectsFromArray:tmp];
                [weakSelf.listView reloadData];
            }
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
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
