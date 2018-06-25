//
//  MineReleaseThemeView.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineReleaseThemeView.h"
#import "MineReleaseThemeTableViewCell.h"

@interface MineReleaseThemeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineReleaseThemeView

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
    
    [_listView registerNib:[UINib nibWithNibName:@"MineReleaseThemeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineReleaseThemeTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineReleaseThemeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineReleaseThemeTableViewCell"];
    cell.viewWidth.constant = 0;
    cell.deleteBtu.hidden = YES;
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
