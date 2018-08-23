/**
 
 ArtStar
 
 Created by: KG丿轩帝 on 2018/4/28
 
 Copyright (c) 2017 My Company
 
 ☆★☆★☆★☆★☆★☆★☆★☆★☆
 ★　　│　心想　│　事成　│　　★
 ☆别╭═╮　　 ╭═╮　　 ╭═╮别☆
 ★恋│人│　　│奎│　　│幸│恋★
 ☆　│氣│　　│哥│　　│福│　☆
 ★　│超│　　│制│　　│滿│　★
 ☆别│旺│　　│作│　　│滿│别☆
 ★恋│㊣│　　│㊣│　　│㊣│恋★
 ☆　╰═╯ 天天╰═╯ 開心╰═╯　☆
 ★☆★☆★☆★☆★☆★☆★☆★☆★.
 
 */

#import "MineVC.h"
#import "MineTableViewCell.h"
#import "MineHeaderView.h"
#import "MIneMessageVC.h"
#import "MineCenterHomeVC.h"
#import "MineIntegralVC.h"
#import "MineCollentionVC.h"
#import "MineTheAddressBookVC.h"
#import "MineReleaseHistoryVC.h"
#import "MineTalentShowVC.h"
#import "MineSetUpTheAppVC.h"
#import "MineQuestionHelpVC.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource,MineHeaderViewDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self createData];
    [self setTableView];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, - (NavTopHeight - 44), kScreenWidth, kScreenHeight + (NavTopHeight - 44))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 50;
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.tableHeaderView = [self tabViewHeaderView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.scrollEnabled = NO;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineTableViewCell"];
}

- (UIView *)tabViewHeaderView{
    MineHeaderView *headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NavTopHeight + 225)];
    headerView.delegate = self;
    __weak typeof(self) mySelf = self;
    headerView.pushIntoMyselfCenter = ^{
        [mySelf pushNoTabBarViewController:[[MineCenterHomeVC alloc]init] animated:YES];
    };
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell"];
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.headerImage.image = Image(dic[@"image"]);
    cell.titleLab.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    if ([dic[@"name"] isEqualToString:@"发布记录"]) {
        MineReleaseHistoryVC *releaseVC = [[MineReleaseHistoryVC alloc]init];
        [self pushNoTabBarViewController:releaseVC animated:YES];
    }else if ([dic[@"name"] isEqualToString:@"我的达人"]){
        MineTalentShowVC *talentShow = [[MineTalentShowVC alloc]init];
        [self pushNoTabBarViewController:talentShow animated:YES];
    }else if ([dic[@"name"] isEqualToString:@"我的店铺"]){
        [MBProgressHUD bwm_showTitle:@"开发小哥哥正在努力工作中..." toView:self.view hideAfter:1];
    }else if ([dic[@"name"] isEqualToString:@"设置"]){
        [self pushNoTabBarViewController:[[MineSetUpTheAppVC alloc]init] animated:YES];
    }else if ([dic[@"name"] isEqualToString:@"问题求助"]){
        [self pushNoTabBarViewController:[[MineQuestionHelpVC alloc]init] animated:YES];
    }
}

- (void)createData{
    _dataArr = [NSMutableArray array];
    NSArray *imageArr = @[@"问题求助",@"发布记录",@"我的达人",@"设置",@"我的店铺"];
    NSArray *titleArr = @[@"问题求助",@"发布记录",@"我的达人",@"设置",@"我的店铺"];
    for (int i = 0; i < 5; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:imageArr[i] forKey:@"image"];
        [dic setValue:titleArr[i] forKey:@"name"];
        [_dataArr addObject:dic];
    }
}
//MARK:-------------------------------------------MineHeaderViewDelegate---------------------------------------------
- (void)pushViewControllerViewTitle:(NSString *)title{
    if ([title isEqualToString:@"消息"]) {
        UIApplication *app = [UIApplication sharedApplication];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[MIneMessageVC alloc]init]];
        app.keyWindow.rootViewController = nav;
    }else if ([title isEqualToString:@"积分"]){
        MineIntegralVC *integralVC = [[MineIntegralVC alloc]init];
        [self pushNoTabBarViewController:integralVC animated:YES];
    }else if ([title isEqualToString:@"收藏"]){
        MineCollentionVC *collectionVC = [[MineCollentionVC alloc]init];
        [self pushNoTabBarViewController:collectionVC animated:YES];
    }else if ([title isEqualToString:@"通讯录"]){
        MineTheAddressBookVC *bookVC = [[MineTheAddressBookVC alloc]init];
        [self pushNoTabBarViewController:bookVC animated:YES];
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
