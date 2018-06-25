//
//  MyselfWordInfoView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfWordInfoView.h"
#import "MyselfWordInfoHeaderView.h"
#import "TheEndCell.h"

@interface MyselfWordInfoView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) MyselfWordInfoHeaderView *headerView;

@end;

@implementation MyselfWordInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.rowHeight = 95;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"TheEndCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TheEndCell"];

}

- (MyselfWordInfoHeaderView *)setTableViewHeaderView{
    _headerView = [[MyselfWordInfoHeaderView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 100)];
    _headerView.titleArr = @[@"微博：@欧阳若溪",@"生于河南省洛阳市",@"现居北京市朝阳区望京西",@"毕业于中国地质大学（武汉）艺术系",@"2010年作品被选入中国地质大学艺术系优秀作品展并获取优秀奖",@"2016年四川省文物局油画展",@"2017年锦绣尚郡别墅区青年艺术家作品展，作品曾多次被机构和个人收藏"];
    _headerView.imageStr = @"http://img1.jfdown.com/upload/0/1fmmkaqh.jpg";
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TheEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheEndCell"];
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
