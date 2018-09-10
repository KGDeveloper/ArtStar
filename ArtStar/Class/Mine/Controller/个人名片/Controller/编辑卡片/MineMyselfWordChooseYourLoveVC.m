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
    if ([_titleStr isEqualToString:@"喜欢的电影"]) {
        self.searchView.hidden = NO;
        self.searchView.type = LoveMovie;
    }else if ([_titleStr isEqualToString:@"喜欢的音乐"]){
        self.searchView.hidden = NO;
        self.searchView.type = LoveMusic;
    }else{
        self.searchView.hidden = NO;
        self.searchView.type = LoveBook;
    }
}
- (void)leftNavBtuAction:(UIButton *)sender{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < _dataArr.count; i++) {
        if ([_titleStr isEqualToString:@"喜欢的书籍"]) {
            MineLoveBookModel *model = _dataArr[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (model.region == nil) {
                [dic setObject:@"暂无" forKey:@"region"];
            }else{
                [dic setObject:model.region forKey:@"region"];
            }
            if (model.writer == nil) {
                [dic setObject:@"暂无" forKey:@"writer"];
            }else{
                [dic setObject:model.writer forKey:@"writer"];
            }
            if (model.userId == nil) {
                [dic setObject:@"" forKey:@"userId"];
            }else{
                [dic setObject:model.userId forKey:@"userId"];
            }
            if (model.ID == nil) {
                [dic setObject:@"" forKey:@"id"];
            }else{
                [dic setObject:model.ID forKey:@"id"];
            }
            [dic setObject:@(model.bookGrade) forKey:@"bookGrade"];
//            if ([model.bookGrade ]) {
//                
//            }
            [dic setObject:model.bookName forKey:@"bookName"];
            if (model.imageUrl == nil) {
                [dic setObject:@"" forKey:@"imageUrl"];
            }else{
                [dic setObject:model.imageUrl forKey:@"imageUrl"];
            }
            if (model.createTime == nil) {
                [dic setObject:@"暂无" forKey:@"createTime"];
            }else{
                [dic setObject:model.createTime forKey:@"createTime"];
            }
            [arr addObject:dic];
        }else if([_titleStr isEqualToString:@"喜欢的电影"]){
            MineLoveMoviesModel *model = _dataArr[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (model.region == nil) {
                [dic setObject:@"暂无" forKey:@"region"];
            }else{
                [dic setObject:model.region forKey:@"region"];
            }
            if (model.director == nil) {
                [dic setObject:@"暂无" forKey:@"director"];
            }else{
                [dic setObject:model.director forKey:@"director"];
            }
            if (model.userId == nil) {
                [dic setObject:@"" forKey:@"userId"];
            }else{
                [dic setObject:model.userId forKey:@"userId"];
            }
            if (model.ID == nil) {
                [dic setObject:@"" forKey:@"id"];
            }else{
                [dic setObject:model.ID forKey:@"id"];
            }
            [dic setObject:@(model.movieGrade) forKey:@"movieGrade"];
            [dic setObject:model.movieName forKey:@"movieName"];
            if (model.imageUrl == nil) {
                [dic setObject:@"" forKey:@"imageUrl"];
            }else{
                [dic setObject:model.imageUrl forKey:@"imageUrl"];
            }
            if (model.createTime == nil) {
                [dic setObject:@"暂无" forKey:@"createTime"];
            }else{
                [dic setObject:model.createTime forKey:@"createTime"];
            }
            [arr addObject:dic];
        }else if ([_titleStr isEqualToString:@"喜欢的音乐"]){
            MineLoveMusicModel *model = _dataArr[i];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (model.region == nil) {
                [dic setObject:@"暂无" forKey:@"region"];
            }else{
                [dic setObject:model.region forKey:@"region"];
            }
            if (model.singer == nil) {
                [dic setObject:@"暂无" forKey:@"singer"];
            }else{
                [dic setObject:model.singer forKey:@"singer"];
            }
            if (model.userId == nil) {
                [dic setObject:@"" forKey:@"userId"];
            }else{
                [dic setObject:model.userId forKey:@"userId"];
            }
            if (model.ID == nil) {
                [dic setObject:@"" forKey:@"id"];
            }else{
                [dic setObject:model.ID forKey:@"id"];
            }
            [dic setObject:@(model.musicGrade) forKey:@"musicGrade"];
            [dic setObject:model.musicName forKey:@"musicName"];
            if (model.imageUrl == nil) {
                [dic setObject:@"" forKey:@"imageUrl"];
            }else{
                [dic setObject:model.imageUrl forKey:@"imageUrl"];
            }
            if (model.createTime == nil) {
                [dic setObject:@"暂无" forKey:@"createTime"];
            }else{
                [dic setObject:model.createTime forKey:@"createTime"];
            }
            [arr addObject:dic];
        }
    }
    if (self.sendYourLoveArr) {
        self.sendYourLoveArr(arr.copy);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:_titleStr image:Image(@"back")];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createArr];
    [self setTableView];
}

- (void)createArr{
    _dataArr = [NSMutableArray array];
    __weak typeof(self) mySelf = self;
    [_oldArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([mySelf.titleStr isEqualToString:@"喜欢的电影"]) {
            MineLoveMoviesModel *model = [MineLoveMoviesModel mj_objectWithKeyValues:obj];
            [mySelf.dataArr addObject:model];
        }else if ([mySelf.titleStr isEqualToString:@"喜欢的音乐"]){
            MineLoveMusicModel *model = [MineLoveMusicModel mj_objectWithKeyValues:obj];
            [mySelf.dataArr addObject:model];
        }else{
            MineLoveBookModel *model = [MineLoveBookModel mj_objectWithKeyValues:obj];
            [mySelf.dataArr addObject:model];
        }
    }];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.rowHeight = 85;
    _listView.tableFooterView = TabLeViewFootView;
    if (_dataArr.count > 0) {
        [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"添加" image:nil];
    }else{
        _listView.tableHeaderView = [self setTabLeViewHeaderView];
    }
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
    if ([_titleStr isEqualToString:@"喜欢的电影"]) {
        self.searchView.hidden = NO;
        self.searchView.type = LoveMovie;
    }else if ([_titleStr isEqualToString:@"喜欢的音乐"]){
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
    if ([_titleStr isEqualToString:@"喜欢的书籍"]) {
        MineLoveBookModel *model = _dataArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        cell.titleLab.text = model.bookName;
        cell.detailLab.text = [NSString stringWithFormat:@"%f/%@/%@",model.bookGrade,model.writer,model.createTime];
    }else if ([_titleStr isEqualToString:@"喜欢的电影"]){
        MineLoveMoviesModel *model = _dataArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        cell.titleLab.text = model.movieName;
        cell.detailLab.text = [NSString stringWithFormat:@"%f/%@/%@",model.movieGrade,model.director,model.createTime];
    }else{
        MineLoveMusicModel *model = _dataArr[indexPath.row];
        [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
        cell.titleLab.text = model.musicName;
        cell.detailLab.text = [NSString stringWithFormat:@"%f/%@/%@",model.musicGrade,model.singer,model.createTime];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [MBProgressHUD bwm_showHUDAddedTo:self.view title:@"正在删除..." animated:YES];
    __weak typeof(self) mySelf = self;
    if ([_titleStr isEqualToString:@"喜欢的电影"]) {
        MineLoveMoviesModel *model = _dataArr[indexPath.row];
        if (model.ID == nil) {
            [_dataArr removeObject:model];
            [_listView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [KGRequestNetWorking postWothUrl:deleteMovice parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":model.ID} succ:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD bwm_showTitle:@"删除成功" toView:self.view hideAfter:2];
                    [mySelf.dataArr removeObject:model];
                    [mySelf.listView reloadData];
                }else{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD bwm_showTitle:@"删除失败" toView:self.view hideAfter:2];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD bwm_showTitle:@"删除失败" toView:self.view hideAfter:2];
            }];
        }
    }else if ([_titleStr isEqualToString:@"喜欢的音乐"]){
        MineLoveMusicModel *model = _dataArr[indexPath.row];
        if (model.ID == nil) {
            [_dataArr removeObject:model];
            [_listView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [KGRequestNetWorking postWothUrl:deleteMusic parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":model.ID} succ:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD bwm_showTitle:@"删除成功" toView:self.view hideAfter:2];
                    [mySelf.dataArr removeObject:model];
                    [mySelf.listView reloadData];
                }else{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD bwm_showTitle:@"删除失败" toView:self.view hideAfter:2];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD bwm_showTitle:@"删除失败" toView:self.view hideAfter:2];
            }];
        }
    }else{
        MineLoveBookModel *model = _dataArr[indexPath.row];
        if (model.ID == nil) {
            [_dataArr removeObject:model];
            [_listView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }else{
            [KGRequestNetWorking postWothUrl:deleteBook parameters:@{@"tokenCode":[KGUserInfo shareInterace].userTokenCode,@"id":model.ID} succ:^(id result) {
                if ([result[@"code"] integerValue] == 200) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD bwm_showTitle:@"删除成功" toView:self.view hideAfter:2];
                    [mySelf.dataArr removeObject:model];
                    [mySelf.listView reloadData];
                }else{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD bwm_showTitle:@"删除失败" toView:self.view hideAfter:2];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD bwm_showTitle:@"删除失败" toView:self.view hideAfter:2];
            }];
        }
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (MineAddYourLoveSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[MineAddYourLoveSearchView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        __weak typeof(self) mySelf = self;
        _searchView.sendChoose = ^(MineLoveMoviesModel *movies, MineLoveMusicModel *music, MineLoveBookModel *books) {
            if (mySelf.searchView.type == LoveBook) {
                [mySelf.dataArr addObject:books];
                [mySelf.headerView removeFromSuperview];
                mySelf.headerView.frame = CGRectMake(0, 0, 0, 0);
                [mySelf.listView reloadData];
            }else if (mySelf.searchView.type == LoveMovie){
                [mySelf.dataArr addObject:movies];
                [mySelf.headerView removeFromSuperview];
                mySelf.headerView.frame = CGRectMake(0, 0, 0, 0);
                [mySelf.listView reloadData];
            }else{
                [mySelf.dataArr addObject:music];
                [mySelf.headerView removeFromSuperview];
                mySelf.headerView.frame = CGRectMake(0, 0, 0, 0);
                [mySelf.listView reloadData];
            }
            [mySelf setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:@"添加" image:nil];
        };
//        _searchView.hidden = YES;
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

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation MineLoveMusicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end

@implementation MineLoveMoviesModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end


