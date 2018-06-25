//
//  HotMoviesVC.m
//  ArtStar
//
//  Created by abc on 5/29/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotMoviesVC.h"
#import "HotMoviesCell.h"
#import "HotMoviesDetailVC.h"

@interface HotMoviesVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,assign) BOOL isSelectSegment;

@end

@implementation HotMoviesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:nil image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isSelectSegment = NO;

    [self setNavButton];
    [self setTbaleView];
}

- (void)setNavButton{
    NSArray *titleArr = @[@"热门电影",@"即将上映"];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:titleArr];
    segment.frame = CGRectMake(kScreenWidth/2 - 80, 0, 160, 25);
    segment.backgroundColor = [UIColor whiteColor];
    segment.tintColor = Color_333333;
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segment;
}
//MARK:--切换--
- (void)segmentAction:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        _isSelectSegment = NO;
    }else{
        _isSelectSegment = YES;
    }
    [_listView reloadData];
}
//MARK:--创建视图--
- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 130;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"HotMoviesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HotMoviesCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotMoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMoviesCell"];
    if (_isSelectSegment == NO) {
        [cell hotMovies];
    }else{
        [cell willPlayMovies];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushNoTabBarViewController:[[HotMoviesDetailVC alloc]init] animated:YES];
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
