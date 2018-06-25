//
//  MineBooksFriendsView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineBooksFriendsView.h"
#import "MineBooksFriendsTableViewCell.h"

@interface MineBooksFriendsView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineBooksFriendsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 70;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineBooksFriendsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineBooksFriendsTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UITableViewRowAction *topAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    topAction.backgroundColor = Color_999999;
    
    UITableViewRowAction *nikeNameAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"备注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    nikeNameAction.backgroundColor = Color_999999;
    
    UITableViewRowAction *cancleAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    cancleAction.backgroundColor = Color_333333;
    return @[cancleAction,nikeNameAction,topAction];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineBooksFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineBooksFriendsTableViewCell"];
    cell.foucsBtu.hidden = YES;
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
