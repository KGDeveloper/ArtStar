//
//  MovieNewsDetaialVC.m
//  ArtStar
//
//  Created by abc on 2018/6/27.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MovieNewsDetaialVC.h"

@interface MovieNewsDetaialVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) CommunitySmartView *smartView;
@property (nonatomic,strong) UITableView *listView;

@end

@implementation MovieNewsDetaialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBtuWithTitle:nil image:Image(@"more white")];
    [self setLeftBtuWithTitle:nil image:Image(@"backwhite")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}
//MARK:----------------------------------------导航栏右侧按钮点击事件------------------------------------------------
- (void)rightNavBtuAction:(UIButton *)sender{
    self.smartView.hidden = NO;
}
//MARK:--------------------------------------右侧筛选按钮--------------------------------------------------
- (CommunitySmartView *)smartView{
    if (!_smartView) {
        _smartView = [[CommunitySmartView alloc]initWithFrame:CGRectMake(ViewWidth(self.view) - 100, NavTopHeight - 5, 100, 135) titleArr:@[@"消息",@"收藏",@"举报"] iconArr:@[@"more popup message",@"more popup collection",@"more popup report"]];
        _smartView.hidden = YES;
        [self.navigationController.view addSubview:_smartView];
    }
    return _smartView;
}
//MARK:-----------------------------------------新闻详情页-----------------------------------------------
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.showsVerticalScrollIndicator = NO;
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.bounces = NO;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.delegate = self;
    _listView.dataSource = self;
    [self.view addSubview:_listView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
