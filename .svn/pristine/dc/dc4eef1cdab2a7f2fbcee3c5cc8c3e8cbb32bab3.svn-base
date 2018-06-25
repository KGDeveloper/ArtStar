//
//  MusicMusiciansView.m
//  ArtStar
//
//  Created by abc on 5/31/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicMusiciansView.h"
#import "MusicMusiciansCell.h"

@interface MusicMusiciansView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MusicMusiciansView

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
    _listView.rowHeight = 110;
    _listView.tableHeaderView = [self setHeaderView];
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MusicMusiciansCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MusicMusiciansCell"];
}
//MARK:--------------------------------------------头视图--------------------------------------------
- (UIView *)setHeaderView{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 10)];
    header.backgroundColor = Color_fafafa;
    return header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicMusiciansCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicMusiciansCell"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pushViewController) {
        self.pushViewController();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
