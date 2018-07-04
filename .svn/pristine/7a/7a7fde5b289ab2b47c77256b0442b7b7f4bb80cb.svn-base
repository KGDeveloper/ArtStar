//
//  MineSystemVC.m
//  ArtStar
//
//  Created by abc on 2018/6/25.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineSystemVC.h"
#import "MessageSystemActivityCell.h"
#import "MessageSystemNoticeCell.h"

@interface MineSystemVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *activityBtu;
@property (nonatomic,strong) UIButton *noticeBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,assign) CGFloat rowHeight;
@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineSystemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBtuWithFrame:CGRectMake(0, 0, 150, 30) title:@"系统通知" image:Image(@"back")];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    _rowHeight = 197;
    [self setTableView];
}

- (void)setUI{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,NavTopHeight, kScreenWidth, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    _activityBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _activityBtu.frame = CGRectMake(0,0, kScreenWidth/2, 50);
    [_activityBtu setTitle:@"活动" forState:UIControlStateNormal];
    [_activityBtu setTitleColor:Color_333333 forState:UIControlStateNormal];
    _activityBtu.titleLabel.font = SYFont(14);
    [_activityBtu addTarget:self action:@selector(activityAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_activityBtu];
    
    _noticeBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    _noticeBtu.frame = CGRectMake(kScreenWidth/2,0, kScreenWidth/2, 50);
    [_noticeBtu setTitle:@"通知" forState:UIControlStateNormal];
    [_noticeBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    _noticeBtu.titleLabel.font = SYFont(14);
    [_noticeBtu addTarget:self action:@selector(noticeAction:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_noticeBtu];
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 25)];
    hLine.centerX = topView.centerX;
    hLine.centerY = ViewHeight(topView)/2;
    hLine.backgroundColor = Color_ededed;
    [topView addSubview:hLine];
    
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
    vLine.backgroundColor = Color_ededed;
    [topView addSubview:vLine];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 48, 30, 2)];
    _line.centerX = _activityBtu.centerX;
    _line.backgroundColor = Color_333333;
    [topView addSubview:_line];
    
}

- (void)activityAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_noticeBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    
    _rowHeight = 197;
    [_listView reloadData];
}

- (void)noticeAction:(UIButton *)sender{
    [sender setTitleColor:Color_333333 forState:UIControlStateNormal];
    [_activityBtu setTitleColor:Color_999999 forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    
    _rowHeight = 90;
    [_listView reloadData];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavTopHeight + 50, kScreenWidth, kScreenHeight - 50 - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MessageSystemActivityCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MessageSystemActivityCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MessageSystemNoticeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MessageSystemNoticeCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_rowHeight == 90) {
        MessageSystemNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageSystemNoticeCell"];
        return cell;
    }else{
        MessageSystemActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageSystemActivityCell"];
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
