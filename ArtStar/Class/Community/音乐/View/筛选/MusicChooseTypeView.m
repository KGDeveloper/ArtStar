//
//  MusicChooseTypeView.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicChooseTypeView.h"
#import "MusicChooseTypeCell.h"

@interface MusicChooseTypeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MusicChooseTypeView

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
    _listView.rowHeight = 45;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTabViewHeader];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicChooseTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicChooseTypeCell"];
}
- (UIView *)setTabViewHeader{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 45)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *headerLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ViewWidth(headerView) - 20, ViewHeight(headerView))];
    headerLab.text = @"全部";
    headerLab.textColor = Color_333333;
    headerLab.font = SYFont(13);
    [headerView addSubview:headerLab];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicChooseTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicChooseTypeCell"];
    cell.selectedBackgroundView = [self tableViewWhiteBackView:cell.frame];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sendType) {
        self.sendType(@"");
    }
}
- (UIView *)tableViewWhiteBackView:(CGRect)frame{
    UIView *backView = [[UIView alloc]initWithFrame:frame];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
