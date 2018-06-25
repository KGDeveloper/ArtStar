//
//  MusicPerformanceView.m
//  ArtStar
//
//  Created by abc on 5/28/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MusicPerformanceView.h"
#import "MusicPerformanceCell.h"

@interface MusicPerformanceView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HeaderScrollAndPageView *pageView;
@property (nonatomic,strong) UITableView *lietView;
@property (nonatomic,strong) UIView *headerView;

@end


@implementation MusicPerformanceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _lietView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _lietView.delegate = self;
    _lietView.dataSource = self;
    _lietView.tableHeaderView = [self setTableView];
    _lietView.tableFooterView = TabLeViewFootView;
    _lietView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_lietView];
    
    [_lietView registerClass:[MusicPerformanceCell class] forCellReuseIdentifier:@"MusicPerformanceCell"];
    
}

- (UIView *)setTableView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewWidth(self)/750*500 + 40 + 60)];
    
    _pageView = [[HeaderScrollAndPageView alloc]initWithFrame:_headerView.bounds style:HeaderStyleOther];
    _pageView.imageArr = @[@"1",@"2",@"3",@"4",@"5"];
    [_headerView addSubview:_pageView];
    
    return _headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%3 == 0) {
        return (ViewWidth(self) - 30)/690*400 + 65;
    }else{
        return (ViewWidth(self) - 30)/690*400 + 105;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicPerformanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicPerformanceCell"];
    if (indexPath.row%3 == 0) {
        [cell normalStatus];
    }else{
        if (indexPath.row%2 == 0) {
            [cell willEndStatus];
        }else{
            [cell willStarStatus];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pushToDetaialVC) {
        self.pushToDetaialVC();
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
