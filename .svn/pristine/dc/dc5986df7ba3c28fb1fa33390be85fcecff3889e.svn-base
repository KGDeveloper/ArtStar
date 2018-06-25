//
//  MineReleaseArticleView.m
//  ArtStar
//
//  Created by abc on 2018/6/15.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineReleaseArticleView.h"
#import "MineReleaseArticleTableViewCell.h"

@interface MineReleaseArticleView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineReleaseArticleView

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
    
    [_listView registerNib:[UINib nibWithNibName:@"MineReleaseArticleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineReleaseArticleTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineReleaseArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineReleaseArticleTableViewCell"];
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
