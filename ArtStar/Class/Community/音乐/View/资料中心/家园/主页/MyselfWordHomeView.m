//
//  MyselfWordHomeView.m
//  ArtStar
//
//  Created by abc on 6/1/18.
//  Copyright © 2018 KG丿轩帝. All rights reserved.
//

#import "MyselfWordHomeView.h"
#import "MySelfWordHomeTableViewHeaderView.h"
#import "TheEndCell.h"
#import "MyselfIdentificationView.h"
#import "MyselfWordHomeMusicCell.h"

@interface MyselfWordHomeView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) MySelfWordHomeTableViewHeaderView *mySelfHeader;
@property (nonatomic,strong) MyselfIdentificationView *identifcationView;

@end

@implementation MyselfWordHomeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setScrollView];
    }
    return self;
}

- (void)setScrollView{
    
    _listView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.tableFooterView = TabLeViewFootView;
    _listView.tableHeaderView = [self setTableViewHeaderView];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_listView];
    
    [_listView registerNib:[UINib nibWithNibName:@"TheEndCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TheEndCell"];
    [_listView registerNib:[UINib nibWithNibName:@"MyselfWordHomeMusicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyselfWordHomeMusicCell"];
}

- (UIView *)setTableViewHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(self), 340)];
    //MARK:--------------------------------------------个人信息--------------------------------------------
    _mySelfHeader = [[MySelfWordHomeTableViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, ViewWidth(_headerView), 280)];
    _mySelfHeader.headerStr = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1527844203591&di=93c248e91bd8bb80965d7683098796b2&imgtype=0&src=http%3A%2F%2Fwww.qqzhi.com%2Fuploadpic%2F2015-01-26%2F201846574.jpg";
    [_headerView addSubview:_mySelfHeader];
    //MARK:--------------------------------------------身份标识--------------------------------------------
    _identifcationView = [[MyselfIdentificationView alloc]initWithFrame:CGRectMake(0, 280, ViewWidth(_headerView), 60)];
    _identifcationView.imageArr = @[@"authentication",@"authenticationn"];
    [_headerView addSubview:_identifcationView];
    
    return _headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 95;
    }else{
        return (kScreenWidth - 30)/690*800 + 65;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        TheEndCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheEndCell"];
        return cell;
    }else{
        MyselfWordHomeMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyselfWordHomeMusicCell"];
        return cell;
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
