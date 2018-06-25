//
//  HotInstitutionsDetailVC.m
//  ArtStar
//
//  Created by abc on 5/30/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "HotInstitutionsDetailVC.h"
#import "HotMoviesDetailCommentCell.h"

@interface HotInstitutionsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation HotInstitutionsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"全部评论（300）" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTbaleView];
    [self setBottomCommentView];
}

- (void)setBottomCommentView{
    KGLowCommentView *commentView = [[KGLowCommentView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    commentView.actionWithTitle = ^(NSString *title, NSString *text) {
        
    };
    [self.view addSubview:commentView];
}

- (void)setTbaleView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, kScreenHeight - NavTopHeight - 50)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.rowHeight = 140;
    [self.view addSubview:_listView];
    
    [_listView registerClass:[HotMoviesDetailCommentCell class] forCellReuseIdentifier:@"HotMoviesDetailCommentCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotMoviesDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotMoviesDetailCommentCell"];
    return cell;
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
