//
//  MineMyselfTalentAuditVC.m
//  ArtStar
//
//  Created by abc on 2018/6/19.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineMyselfTalentAuditVC.h"
#import "MineBookButtonView.h"
#import "MineAuditTableViewCell.h"

@interface MineMyselfTalentAuditVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MineBookButtonView *auditWaitBtu;
@property (nonatomic,strong) MineBookButtonView *auditSucBtu;
@property (nonatomic,strong) MineBookButtonView *auditFailBtu;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIView *topView;

@property (nonatomic,copy) NSString *status;

@end

@implementation MineMyselfTalentAuditVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftBtuWithTitle:@"我的达人" image:Image(@"back")];
    [self setRightBtuWithTitle:@"编辑" image:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopView];
    [self setTableView];
}
- (void)setTopView{
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, NavTopHeight, kScreenWidth, 60)];
    [self.view addSubview:_topView];
    
    _auditWaitBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth/3, 60)];
    _auditWaitBtu.count = @"3";
    _auditWaitBtu.name = @"审核中";
    _auditWaitBtu.btuColor = Color_333333;
    __weak typeof(self) mySelf = self;
    _auditWaitBtu.touchUpInside = ^{
        [mySelf changeTouchBtuColor:mySelf.auditWaitBtu];
    };
    [_topView addSubview:_auditWaitBtu];
    
    _auditSucBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/3, 0,kScreenWidth/3, 60)];
    _auditSucBtu.count = @"3";
    _auditSucBtu.name = @"审核通过";
    _auditSucBtu.btuColor = Color_999999;
    _auditSucBtu.touchUpInside = ^{
        [mySelf changeTouchBtuColor:mySelf.auditSucBtu];
    };
    [_topView addSubview:_auditSucBtu];
    
    _auditFailBtu = [[MineBookButtonView alloc]initWithFrame:CGRectMake(kScreenWidth/3*2, 0,kScreenWidth/3, 60)];
    _auditFailBtu.count = @"3";
    _auditFailBtu.name = @"审核失败";
    _auditFailBtu.btuColor = Color_999999;
    _auditFailBtu.touchUpInside = ^{
        [mySelf changeTouchBtuColor:mySelf.auditFailBtu];
    };
    [_topView addSubview:_auditFailBtu];
    
    UIView *lowLine = [[UIView alloc]initWithFrame:CGRectMake(0,59, kScreenWidth, 1)];
    lowLine.backgroundColor = Color_ededed;
    [_topView addSubview:lowLine];
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 58, 50, 2)];
    _line.backgroundColor = Color_333333;
    _line.centerX = _auditWaitBtu.centerX;
    [_topView addSubview:_line];
    
}

- (void)changeTouchBtuColor:(MineBookButtonView *)sender{
    for (id obj in _topView.subviews) {
        if ([obj isKindOfClass:[MineBookButtonView class]]) {
            MineBookButtonView *norBtu = obj;
            norBtu.btuColor = Color_999999;
        }
    }
    sender.btuColor = Color_333333;
    _status = sender.name;
    [UIView animateWithDuration:0.2 animations:^{
        self.line.centerX = sender.centerX;
    }];
    [_listView reloadData];
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0,NavTopHeight + 60, kScreenWidth, kScreenHeight - NavTopHeight)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 150;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.backgroundColor = Color_fafafa;
    [self.view addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineAuditTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineAuditTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineAuditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAuditTableViewCell"];
    if ([_status isEqualToString:@"审核中"]) {
        cell.auditImage.image = Image(@"审核中");
    }else if ([_status isEqualToString:@"审核通过"]){
        cell.auditImage.image = Image(@"审核通过");
    }else{
        cell.auditImage.image = Image(@"审核失败");
    }
    cell.viewWidth.constant = 0;
    cell.editBtu.hidden = YES;
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
