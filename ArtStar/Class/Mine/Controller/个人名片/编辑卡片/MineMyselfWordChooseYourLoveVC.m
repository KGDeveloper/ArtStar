//
//  MineMyselfWordChooseYourLoveVC.m
//  ArtStar
//
//  Created by abc on 2018/6/13.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMyselfWordChooseYourLoveVC.h"
#import "MineMyselfWordChooseYourLoveCell.h"
#import "MineAddYourLoveSearchView.h"

@interface MineMyselfWordChooseYourLoveVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) MineAddYourLoveSearchView *searchView;

@end

@implementation MineMyselfWordChooseYourLoveVC

- (void)rightNavBtuAction:(UIButton *)sender{
    if ([_titleStr isEqualToString:@"电影"]) {
        self.searchView.hidden = NO;
        self.searchView.type = LoveMovie;
    }else if ([_titleStr isEqualToString:@"音乐"]){
        self.searchView.hidden = NO;
        self.searchView.type = LoveMusic;
    }else{
        self.searchView.hidden = NO;
        self.searchView.type = LoveBook;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:_titleStr image:Image(@"back")];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = [NSMutableArray array];
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.rowHeight = 85;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTabLeViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineMyselfWordChooseYourLoveCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineMyselfWordChooseYourLoveCell"];
}
- (UIView *)setTabLeViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , ViewHeight(_listView))];
    UIButton *addBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtu.frame = CGRectMake(ViewWidth(_headerView)/2 - 30, ViewHeight(_headerView)/2 - 15, 60, 30);
    [addBtu setTitle:@"添加" forState:UIControlStateNormal];
    [addBtu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtu.titleLabel.font = SYFont(14);
    addBtu.backgroundColor = Color_333333;
    addBtu.layer.cornerRadius = 5;
    addBtu.layer.masksToBounds = YES;
    [addBtu addTarget:self action:@selector(addYourLove) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:addBtu];
    return _headerView;
}

- (void)addYourLove{
    if ([_titleStr isEqualToString:@"电影"]) {
        self.searchView.hidden = NO;
        self.searchView.type = LoveMovie;
    }else if ([_titleStr isEqualToString:@"音乐"]){
        self.searchView.hidden = NO;
        self.searchView.type = LoveMusic;
    }else{
        self.searchView.hidden = NO;
        self.searchView.type = LoveBook;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMyselfWordChooseYourLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMyselfWordChooseYourLoveCell"];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1528896034429&di=61c80c2b182f6e4a60d509de5237d93b&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F005TTqq4gw1fb1tf69lr7j30rs1b8aja.jpg"]];
    return cell;
}

- (MineAddYourLoveSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[MineAddYourLoveSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        _searchView.sendChoose = ^(MineLoveMoviesModel *movies, MineLoveMusicModel *music, MineLoveBookModel *books) {
            [mySelf.dataArr addObject:@""];
            [mySelf.headerView removeFromSuperview];
            mySelf.headerView.frame = CGRectMake(0, 0, 0, 0);
            [mySelf.listView reloadData];
            [mySelf setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"添加" image:nil];
        };
        [self.navigationController.view addSubview:_searchView];
    }
    return _searchView;
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


@implementation MineLoveBookModel
@end

@implementation MineLoveMusicModel
@end

@implementation MineLoveMoviesModel
@end


