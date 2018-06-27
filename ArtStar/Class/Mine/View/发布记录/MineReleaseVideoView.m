//
//  MineReleaseVideoView.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineReleaseVideoView.h"
#import "MineReleaseVideoTableViewCell.h"

@interface MineReleaseVideoView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineReleaseVideoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTableView];
    }
    return self;
}

- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 150;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineReleaseVideoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineReleaseVideoTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineReleaseVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineReleaseVideoTableViewCell"];
    if (_isEditCell == YES) {
        cell.viewWidth.constant = 30;
        cell.deleteBtu.hidden = NO;
    }else{
        cell.viewWidth.constant = 0;
        cell.deleteBtu.hidden = YES;
    }
    return cell;
}

- (void)setIsEditCell:(BOOL)isEditCell{
    _isEditCell = isEditCell;
    [_listView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
