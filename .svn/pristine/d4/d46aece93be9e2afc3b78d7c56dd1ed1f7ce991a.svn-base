//
//  MyselfCenterVideo+Music+BookVC.m
//  ArtStar
//
//  Created by abc on 6/6/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfCenterVideo+Music+BookVC.h"
#import "MyselfLoveMoviesCell.h"
#import "MyselfLoveMusicCell.h"

@interface MyselfCenterVideo_Music_BookVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MyselfCenterVideo_Music_BookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"影音书" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableView];
    
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MyselfLoveMoviesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfLoveMoviesCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfLoveMusicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfLoveMusicCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 200;
    }else{
        return 215;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        MyselfLoveMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfLoveMusicCell"];
        cell.imageArr = _userMusics;
        return cell;
    }else if(indexPath.row == 0){
        MyselfLoveMoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfLoveMoviesCell"];
        cell.imageArr = _userMovies;
        cell.titleLab.text = @"喜欢的电影";
        return cell;
    }else{
        MyselfLoveMoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfLoveMoviesCell"];
        cell.imageArr = _userBooks;
        cell.titleLab.text = @"喜欢的书籍";
        return cell;
    }
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
