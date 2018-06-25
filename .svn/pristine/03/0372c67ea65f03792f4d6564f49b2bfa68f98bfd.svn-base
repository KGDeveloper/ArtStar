//
//  MineCollectionExhibitionView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineCollectionExhibitionView.h"
#import "MineCollectionExibitionTableViewCell.h"

@interface MineCollectionExhibitionView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineCollectionExhibitionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTableView];
    }
    return self;
}
- (void)setTableView{
    _listView = [[UITableView alloc]initWithFrame:self.bounds];
    _listView.dataSource = self;
    _listView.delegate = self;
    _listView.rowHeight = (kScreenWidth - 30)/690*400 + 100;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCollectionExibitionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCollectionExibitionTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    headerView.backgroundColor = Color_fafafa;
    return headerView;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"2018-01-03";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionExibitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCollectionExibitionTableViewCell"];
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
