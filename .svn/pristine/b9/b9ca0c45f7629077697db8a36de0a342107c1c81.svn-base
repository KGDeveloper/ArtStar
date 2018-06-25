//
//  MineControllerArticleView.m
//  ArtStar
//
//  Created by abc on 2018/6/14.
//  Copyright © 2018年 KG丿轩帝. All rights reserved.
//

#import "MineControllerArticleView.h"
#import "MineCollectionArticleTableViewCell.h"

@interface MineControllerArticleView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;

@end

@implementation MineControllerArticleView

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
    _listView.rowHeight = 150;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"MineCollectionArticleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MineCollectionArticleTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCollectionArticleTableViewCell"];
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
