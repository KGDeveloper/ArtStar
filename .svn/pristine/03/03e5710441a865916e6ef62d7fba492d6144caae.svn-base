//
//  HeadLinesDetailVC.m
//  ArtStar
//
//  Created by abc on 5/24/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HeadLinesDetailVC.h"
#import "HeadLinesNormalCell.h"
#import "HeadLinesDetaialCommentCell.h"
#import "HeadLinesDetaialAllCommentVC.h"

@interface HeadLinesDetailVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) HeadLinesVideoPlayVide *video;
@property (nonatomic,strong) ShrinkageView *shrinkageView;
@property (nonatomic,strong) CommunitySmartView *smartView;
@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;

@end
//MARK:--头条--
//MARK:--视频--
//MARK:--详情--
//MARK:--播放--
@implementation HeadLinesDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#000000"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"backwhite")];
    [self setRightBtuWithFrame:CGRectMake(0, 0, 50, 30) title:nil image:Image(@"more white")];
    
    [self setTableView];
    [self setLowView];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.smartView.hidden = YES;
    [_video releasePlayer];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStylePlain];
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesNormalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesNormalCell"];
    [_listView registerNib:[UINib nibWithNibName:@"HeadLinesDetaialCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HeadLinesDetaialCommentCell"];
}

- (UIView *)setTableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenWidth/75*50 + 289)];
    _video = [[HeadLinesVideoPlayVide alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/75*50)];
    [_headerView addSubview:_video];
    [_video playVideoWithUrl:[NSURL URLWithString:@"http://221.228.226.23/11/t/j/v/b/tjvbwspwhqdmgouolposcsfafpedmb/sh.yinyuetai.com/691201536EE4912BF7E4F1E2C67B8119.mp4"]];
    
    __weak typeof(self) mySelf = self;
    _shrinkageView = [[ShrinkageView alloc]initWithFrame:CGRectMake(0,ViewHeight(_video), kScreenWidth, 289)];
    _shrinkageView.changeViewHeight = ^(CGFloat height) {
        mySelf.shrinkageView.frame = CGRectMake(0,ViewHeight(mySelf.video), kScreenWidth, height);
        mySelf.headerView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth/75*50 + height);
        [mySelf.listView reloadData];
    };
    [_headerView addSubview:_shrinkageView];
    
    return _headerView;
}

- (void)rightNavBtuAction:(UIButton *)sender{
    self.smartView.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataArr.count == 0) {
        return 1;
    }else{
        return _dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArr.count == 0) {
        return 100;
    }else{
        return 145;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArr.count == 0) {
        HeadLinesNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesNormalCell"];
        return cell;
    }else{
        HeadLinesDetaialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadLinesDetaialCommentCell"];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArr.count > 0) {
        [self pushNoTabBarViewController:[[HeadLinesDetaialAllCommentVC alloc]init] animated:YES];
    }
}

- (void)setLowView{
    KGLowCommentView *commentView = [[KGLowCommentView alloc]initWithFrame:CGRectMake(0,kScreenHeight - 50, kScreenWidth, 50)];
    [self.view addSubview:commentView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > NavTopHeight) {
        [self setNavBackGroundClearColor];
    }else{
        [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:nil];
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#000000"];
        
    }
}

- (CommunitySmartView *)smartView{
    if (!_smartView) {
        _smartView = [[CommunitySmartView alloc]initWithFrame:CGRectMake(ViewWidth(self.view) - 100, NavTopHeight - 5, 100, 135) titleArr:@[@"消息",@"收藏",@"举报"] iconArr:@[@"more popup message",@"more popup collection",@"more popup report"]];
        _smartView.hidden = YES;
        [self.navigationController.view addSubview:_smartView];
    }
    return _smartView;
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
